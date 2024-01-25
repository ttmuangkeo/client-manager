<template>
  <card>
    <b-form>
      <div class="pl-lg-4">
        <b-row>
          <b-col lg="12">
            <base-input
              type="Text"
              label="Origin Bearer Token"
              placeholder="Token"
              v-model="TOKEN"
              @keyup="getUsers"
            >
            </base-input>
          </b-col>
          <b-col lg="12">
            <base-input
              type="Text"
              label="Organization ID"
              placeholder="3fa85f64-5717-4562-b3fc-2c963f66afa6"
              v-model="orgId"
            >
            </base-input>
          </b-col>
        </b-row>
        <b-row >
          <b-col lg="12">
            <base-input
              type="Text"
              label="Name of API key"
              placeholder="sunrun sandbox01 opensolar"
              v-model="keyName"
            >
            </base-input>
          </b-col>
        </b-row>
      </div>
      <hr class="my-4">
      <button @click="createKey" class="btn btn-success">Create Key</button>
    </b-form>
  </card>
</template>
<script>
export default {
  data() {
    return {
        data: '',
        authToken: '',
        orgGuid: '',
        payload: '',
        TOKEN: '',
        orgId: '',
        keyName: ''
    };
  },
  methods: {
  }
};
</script>
<style></style>
