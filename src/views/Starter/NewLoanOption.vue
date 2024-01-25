<template>
  <card>
    <b-row align-v="center" slot="header" >
      <b-col cols="8">
        <h3 class="mb-0">New Loan Option </h3>
      </b-col>
    </b-row>

    <b-form>
      <div class="pl-lg-4">
        <b-row>
          <b-col lg="2">
            <base-input
              type="number"
              label="Term"
              placeholder="10"
              v-model="standardLoan.term"
            >
            <select>
              <option v-for="(term, key) in $store.getters.uniqueTerms" :key="key">
                {{term}}
              </option>
            </select>
            </base-input>            
          </b-col>
          <b-col lg="2">
            <base-input
              type="number"
              label="Rate"
              placeholder="2.99"
              v-model="standardLoan.rate"
            >
            </base-input>
          </b-col>
          <b-col lg="2">
            <base-input
              type="number"
              label="Program Fee"
              placeholder="15.25"
              v-model="standardLoan.programFee"
            >
            </base-input>
          </b-col>
          <b-col lg="6">
            <base-input
              type="text"
              label="Product"
              placeholder=""
              v-model="standardLoan.installationCategories"
            >
            </base-input>
          </b-col>
        </b-row>
        <button class="btn btn-success" @click="updateProfile">Add</button>
      </div>
    </b-form>
  </card>
</template>
<script>
export default {
  data() {
    return {
      standardLoan: {
        installationCategories: [],
        productCode: '',
        programFee: '',
        rate: '',
        term: ''
      },
      flexpayLoanOption: {
        installationCategories: '',
        productCode: '',
        programFee: '',
        promotionalPeriod: '',
        promotionalPeriodInterval: '',
        promotionalPeriodType: '',
        rate: '',
        term: ''         
      }
    };
  },
  computed: {
    programFeeParse() {
      return parseInt(this.programFee)
    }
    },
  methods: {
    updateProfile() {
      const self = this;
      const newLoanOption = JSON.stringify(this.standardLoan)
      console.log(newLoanOption)
      // self.$store.commit("updatePartnerData", newLoanOption);
    }
  }
};
</script>
<style></style>
