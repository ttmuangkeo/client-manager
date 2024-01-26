<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-4 bg-transparent">
      <h1>API Key Generator</h1>
    </base-header>
    <b-container fluid>
      <b-row>
        <!-- <b-col xl="9" class="order-xl-2 mb-5">
          <Organization></Organization>
        </b-col> -->
        <b-col xl="4" class="order-xl-1">
          <template>
            <card>
              <b-form>
                <div class="pl-lg-4">
                  <b-row>
                    <b-col lg="12">
                      <base-input
                        type="Text"
                        label="Organization IDsss"
                        placeholder="3fa85f64-5717-4562-b3fc-2c963f66afa6"
                        v-model="orgId"
                        @blur="getOrgUser"
                      >
                      </base-input>
                      <div v-show="orgId">
                        <p v-html="$store.getters.organzation.name"></p>
                      </div>
                    </b-col>
                    <b-col lg="12">
                      <base-input
                        type="Text"
                        label="Origin Bearer Token"
                        placeholder="Token"
                        v-model="TOKEN"
                        @blur="getUsers"
                      >
                      </base-input>
                      <p v-html="$store.getters.user.name"></p>
                      <p v-html="$store.getters.user.tenant"></p>
                    </b-col>
                    <b-col lg="12">
                      <base-input
                        type="Text"
                        label="Distributor"
                        placeholder="SOLO"
                        v-model="keyName"
                      >
                      </base-input>
                    </b-col>
                  </b-row>
                </div>
                <hr class="my-4" />
                <a @click="createApiKey" class="btn btn-success">
                  Create Key
                </a>
              </b-form>
              <hr>
              <pre>{{ payload }}</pre>
            </card>
          </template>
        </b-col>
        <b-col xl="8" class="order-xl-2">
          <b-row lg="5" v-show="$store.getters.organzationUsers">
            <template>
              <card>
            <b-col lg="12"
              v-for="(res, key) in $store.getters.organzationUsers"
              :key="key"
            >
              <p>name: {{ res.name }}</p> 
              <!-- <p>OrgID: {{ res.apiKeys[0].organizationId }}</p>  -->
              <!-- <p>ExpirationData: {{ res.apiKeys[key].expirationDate }}</p> -->
              <button
                type="button"
                class="btn btn-danger"
                @click="deleteKeys(res.name, res.contextId)"
              >
                Delete
              </button>
              <hr>
            </b-col>
              </card>
            </template>
          </b-row>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>


<script>
import axios from "axios";
import Organization from "../Layout/Organization.vue";
import BaseHeader from "../../components/BaseHeader.vue";
export default {
  data() {
    return {
      data: "",
      TOKEN: "",
      authToken: "",
      orgId: "",
      orgGuid: "",
      keyName: "",
      payload: "",
    };
  },
  components: {
    Organization,
    BaseHeader,
  },
  methods: {
    getUsers() {
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = "Users/me?tenant=sandbox01";
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json",
            Authorization: "Bearer " + this.TOKEN,
          },
        })
        .get(ENDPOINT)
        .then((res) => {
          if(res.status === 200) {
            const self = this;
            self.$store.commit("updateUser", res.data);
            this.authorization(res.data.contexts[0].guid);
          }
        })
        .catch((err) => {
            if (err.response.status === 401) {
              alert(err.response.status + " Bad Bearer Token")
            }
        });
    },
    authorization(guid) {
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = "Authorization";
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json",
            Authorization: "Bearer " + this.TOKEN,
          },
        })
        .post(ENDPOINT, { contextId: guid })
        .then((res) => {
          console.log(res);
          this.authToken = res.data.token;
          this.getOrg(res.data.token);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getOrg(token) {
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = "Organizations/external/" + this.orgId;
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json",
            Authorization: "Bearer " + token,
          },
        })
        .get(ENDPOINT)
        .then((res) => {
          const self = this;
          self.$store.commit("updateOrganization", res.data.payload);
          this.orgGuid = res.data.payload.guid;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    createApiKey() {
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = "Users/system/";
      const self = this;
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json-patch+json",
            Authorization: "Bearer " + this.TOKEN,
          },
        })
        .post(ENDPOINT, {
          name: self.$store.getters.organzation.name + ' ' + self.$store.getters.organzation.tenant.code + ' ' + this.keyName,
          organizationId: this.orgGuid,
          roleId: "d6508641-2b1e-4654-8133-bc7b01d91d36",
          publicKey: "",
        })
        .then((res) => {
          console.log(res);
          this.payload = res.data.payload.apiKeys[0];
        })
        .catch((err) => {
          console.log(err.status);
        });
    },
    getOrgUser() {
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = "Organizations/" + this.orgGuid + "/users";
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json-patch+json",
            Authorization: "Bearer " + this.TOKEN,
          },
        })
        .get(ENDPOINT)
        .then((res) => {
          console.log(res);
          const self = this;
          self.$store.commit("updateOrganizationUsers", res.data.payload);
        })
        .catch((err) => {
          console.log(err);
        });
    },
    deleteKeys(name, contextId) {
      // const BASEURL = "https://directory-dev.loanpal.services/";
      // const ENDPOINT = 'Users/contexts' + this.orgGuid
      // if (confirm("Deleting " + name + "are you sure?")) {
      //   console.log(contextId);
      // }
      const BASEURL = "https://directory-dev.loanpal.services/";
      const ENDPOINT = 'Users/contexts/' + this.orgGuid
      axios
        .create({
          baseURL: BASEURL,
          headers: {
            "Content-Type": "application/json-patch+json",
            Authorization: "Bearer " + this.TOKEN,
          },
        })
        .delete(ENDPOINT)
        .then((res) => {
          if (confirm("Deleting " + name + "are you sure?")) {
            console.log(res)
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
};
</script>

<style>
</style>