<template>
  <div>
    <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-transparent">
      <h1 v-html="$store.getters.partnerData.name"></h1>
      <button
        type="button"
        class="btn"
        v-clipboard:copy="$store.getters.partnerData.organizationId"
        v-clipboard:success="onCopy"
        title=""
        data-original-title="Copy to clipboard"
      >
        <div>
          <p>OrgID</p>
          <span v-html="$store.getters.partnerData.organizationId"></span>
        </div>
      </button>
      <button
        type="button"
        class="btn"
        v-clipboard:copy="$store.getters.partnerData.id"
        v-clipboard:success="onCopy"
        title=""
        data-original-title="Copy to clipboard"
      >
        <div>
          <div>
            <p>ID</p>
            <span v-html="$store.getters.partnerData.id"></span>
          </div>
        </div>
      </button>
      <button
        type="button"
        class="btn"
        v-clipboard:copy="$store.getters.partnerData.salesforce.accountId"
        v-clipboard:success="onCopy"
        title=""
        data-original-title="Copy to clipboard"
      >
        <div>
          <div>
            <p>Salesforce ID</p>
            <span v-html="$store.getters.partnerData.salesforce.accountId"></span>
            <div v-if="!validateSalesforceId($store.getters.partnerData.salesforce.accountId)">
              <p class="text-warning">not a salesforce ID</p>
            </div>
          </div>
        </div>
      </button>
      <div>
        <ul v-for="(fee, key) in $store.getters.programFee" :key="key">
          <li>{{ fee + "%" }}</li>
        </ul>
      </div>
      <hr />
      <!-- Card stats -->
      <b-row>
        <b-col xl="3" md="6">
          <stats-card
            title="Vital Info"
            type="gradient-orange"
            :sub-title="$store.getters.partnerData.vitalInfo.email"
            class="mb-4"
          >
            <template slot="footer">
              <p v-html="$store.getters.partnerData.vitalInfo.address.city"></p>
              <p
                v-html="$store.getters.partnerData.vitalInfo.address.street"
                class="text-nowrap"
              ></p>
              <p v-html="$store.getters.partnerData.vitalInfo.email"></p>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="3" md="6">
          <stats-card
            title="Installation Category"
            type="gradient-green"
            :sub-title="$store.getters.partnerData.installationCategories"
            class="mb-4"
          >
          </stats-card>
        </b-col>
        <b-col xl="3" md="6">
      <button
        type="button"
        class="btn"
        v-clipboard:copy="$store.getters.partnerData.communicationOptions.admin"
        v-clipboard:success="onCopy"
        title=""
        data-original-title="Copy to clipboard"
      >
        <div>
          <p>Admin Email</p>
          <span v-html="$store.getters.partnerData.communicationOptions.admin"></span>
        </div>
      </button>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card
            title="Sub650"
            type="gradient-green"
            :sub-title="$store.getters.partnerData.features.sub650"
            class="mb-4"
          >
          </stats-card>
        </b-col>
      </b-row>
    </base-header>
    <b-container fluid class="mt--6">
      <button @click="loanConfig = !loanConfig" class="btn btn-secondary mb-4">
        mapping/term
      </button>
      <button @click="addLoanOption" type="button" class="btn btn-success mb-4">
        <span>Add New Option</span>
      </button>
      <b-row v-show="enableAddingNewLoanOption">
        <newLoanOption/>
      </b-row>      
      <!-- <button @click="programFee" type="button" class="btn btn-secondary mb-4">
        <span>program fees</span>
      </button> -->
      <b-row v-show="loanConfig">
        <b-col
          lg="1"
          v-for="(key, res) in $store.getters.partnerData.loanOptionsMap"
          :key="key"
        >
          <p @click="parseOptionMap(res, key)" class="mb-3">
            <span class="btn">{{ res }}</span>
          </p>
        </b-col>
      </b-row>
      <b-row v-show="!loanConfig">
        <b-col lg="2" v-for="(res, key) in findTerms" :key="key">
          <p @click="loadPartnerData(res)" class="mb-3">
            <button
              type="button"
              class="btn-icon-clipboard"
              v-clipboard:success="onCopy"
              title=""
              :data-original-title="Success"
            >
              <div>Term: 
                <span>{{ res }}</span>
              </div>
            </button>
          </p>
        </b-col>
        <!-- <b-col lg="2">
          <p @click="loadPartnerData($store.getters.newPartnerData.loanOptions)">all</p>
        </b-col>      -->
      </b-row>
    </b-container>
    <b-container fluid>
      <loanOption />
    </b-container>
  </div>
</template>
<script>
import partnerData from "../../json/client-config.json";
import BaseHeader from "../../components/BaseHeader.vue";
import Vue from "vue";
import VueClipboard from "vue-clipboard2";
import LoanOption from "./LoanOption.vue";
import NewLoanOption from "./NewLoanOption.vue";
Vue.use(VueClipboard);

export default {
  name: "partnerConfig",
  components: {
    BaseHeader,
    VueClipboard,
    LoanOption,
    NewLoanOption
  },
  data() {
    return {
      loanConfig: true,
      enableAddingNewLoanOption: false,
      hideLoanOption: false
    };
  },
  mounted() {
    const self = this;
    if (!this.partnerData) {
      self.$store.commit("updatePartnerData", partnerData);
    }
  },
  computed: {
    findTerms: function () {
      const self = this;
      const term = self.$store.getters.partnerData.loanOptions;
      const newTerm = [];
      for (const terms in term) {
        newTerm.push(term[terms].term);
      }
      let uniqueTerms = [...new Set(newTerm)];
      self.$store.commit('updateUniqueTerms', uniqueTerms)
      return uniqueTerms;
    },
  },
  methods: {
    onCopy() {
      this.$notify({
        type: "success",
        message: "",
      });
    },
    getLoanId(loanId) {
      console.log(loanId);
      this.$router.push({ name: "getLoan", params: { loanId: loanId } });
    },
    programFee() {
      const self = this;
      const getAllFees = [];
      const getFees = self.$store.getters.partnerData.loanOptions;
      getFees.forEach((fees) => {
        getAllFees.push(fees.programFee);
      });
      self.$store.commit("updateProgramFee", getAllFees);
    },
    getLatestDealerFee(programFee) {
      return programFee[programFee.length - 1];
    },
    isFlexPay(data) {
      if (data.id > 1000) {
        this.promotionalPeriod1(data);
      } else {
        console.log(false);
      }
    },
    promotionalPeriod1(data) {
      if (data.term === "20") {
        console.log(data);
      }
    },
    isString(programFee, promotionalPeriod) {
      if (typeof programFee == "string") {
        return programFee;
      } else if (typeof promotionalPeriod == "string") {
        return promotionalPeriod;
      }
    },
    addLoanOption() {
      const self = this;
      this.enableAddingNewLoanOption = !this.enableAddingNewLoanOption;
    },
    validateSalesforceId(id) {
      let salesforce = id.substring(0, 3);
      return (salesforce === '001') ? true : false;
    },
    parseOptionMap(index, res) {
      const self = this;
      const validated = [];
      const loanOptionsId = self.$store.getters.partnerData.loanOptions;
      for (const ids in loanOptionsId) {
        const filtering = res.filter(
          (result) => result === loanOptionsId[ids].id
        );
        if (filtering.length > 0) {
          validated.push(...filtering);
          self.$store.commit("updateOptionList", validated);
        }
      }
      this.loadPartnerData(validated);
      return null;
    },
    loadPartnerData(data) {
      const self = this;
      const loanData = self.$store.getters.partnerData.loanOptions;
      const newPartnerData = [];
      loanData.forEach((res, index) => {
        if (this.loanConfig && data.includes(res.id)) {
          newPartnerData.push(res);
          self.$store.commit("updateNewPartnerData", newPartnerData);
          // self.$store.commit('updateNewPartnerData', newPartnerData.programFee)
        } else if (!this.loanConfig && res.term === data) {
          newPartnerData.push(res);
          self.$store.commit("updateNewPartnerData", newPartnerData);
          // this.newProgramFee(newPartnerData);
        } else {
          return null
        }
      });
    },
  },
};
</script>
<style></style>
