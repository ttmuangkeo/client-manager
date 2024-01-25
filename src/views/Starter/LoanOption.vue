<template>
  <div>
    <b-container fluid class="mt--0">
      <b-row class="justify-content-center">
        <b-col lg="12">
          <card header-classes="bg-transparent">
            <h3 slot="header" class="mb-0">ID and Program Fee</h3>
            <b-row
              class="icon-examples"
              v-for="(res, key) in $store.getters.newPartnerData"
              :key="key"
            >
              <b-col xl="1" md="6">
                <stats-card
                  title="Default Loan Attribute"
                  type="gradient-red"
                  class="mb-4"
                >
                  <span class="text-success mr-2">ID: {{ res.id }}</span>
                </stats-card>
              </b-col>
              <b-col xl="1" md="6">
                <stats-card
                  title="Term"
                  type="gradient-red"
                  :sub-title="res.term"
                  class="mb-4"
                >
                  <template slot="footer"> </template>
                </stats-card>
              </b-col>
              <b-col xl="1" md="6">
                <stats-card
                  title="Rate"
                  type="gradient-red"
                  :sub-title="res.rate"
                  class="mb-4"
                >
                </stats-card>
              </b-col>
              <b-col xl="2" md="6">
                <stats-card
                  title="Product Code"
                  type="gradient-red"
                  :sub-title="res.productCode"
                  class="mb-4"
                >
                  <template slot="footer"> </template>
                </stats-card>
              </b-col>
              <b-col xl="2" md="6">
                <stats-card title="" type="gradient-red" class="mb-4">
                  <template slot="footer">
                    <div class="btn">
                      <div class="text-nowrap btn-success" v-if="res.isSub650">
                        Sub650: {{ res.isSub650 }}
                      </div>
                        <span>Program Fee: {{ res.programFee }}</span>
                    </div>
                    <div
                      class="text-warning"
                      v-if="isString(res.programFee, res.promotionalPeriod)"
                    >
                      <p>Program Fee is a String Type</p>
                    </div>
                  </template>
                </stats-card>
              </b-col>
              <b-col xl="5" md="6">
                <stats-card title="Seeding" type="gradient-green" class="mb-4" id="seeding">
                  <template slot="footer">
                    <div
                      class="text-warning"
                      v-if="res.partnerOfferId === undefined"
                    >
                      <p>Seeding is missing: partnerOfferId</p>
                    </div>
                    <div
                      class="text-warning"
                      v-else-if="res.productId === undefined"
                    >
                      <p>Seeding is missing productId</p>
                    </div>
                    <div
                      class="text-warning"
                      v-else-if="res.categoryId === undefined"
                    >
                      <p>Seeding is missing categoryId</p>
                    </div>
                    <div
                      class="text-warning"
                      v-else-if="res.appliedPromotionIds === undefined"
                    >
                      <p>Seeding is missing appliedPromotionIds</p>
                    </div>
                    <div
                      class="text-warning"
                      v-else-if="
                        res.productCode !== 'INTEREST_ONLY' && res.id > 1000
                      "
                    >
                      <p>
                        Product Code needs to be
                        <span class="text-success">INTEREST_ONLY</span>
                      </p>
                    </div>
                    <div v-else>
                      <p class="text-nowrap">
                        Applied Promo: {{ res.appliedPromotionIds }}
                      </p>
                      <p class="text-nowrap">Base Rate: {{ res.baseRate }}</p>
                      <p class="text-nowrap">
                        Program Fee: {{ res.categoryCode }}
                      </p>
                      <p class="text-nowrap">
                        Program ID: {{ res.loanProgramId }}
                      </p>
                      <p class="text-nowrap">
                        partner Offer ID: {{ res.partnerOfferId }}
                      </p>
                      <p class="text-nowrap">Product ID: {{ res.productId }}</p>
                    </div>
                  </template>
                </stats-card>
              </b-col>
            </b-row>
          </card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import Vue from "vue";
import VueClipboard from "vue-clipboard2";
import BaseHeader from "@/components/BaseHeader";

Vue.use(VueClipboard);
export default {
  name: "icons",
  components: {
    BaseHeader,
  },
  methods: {
    onCopy() {
      this.$notify({
        type: "info",
        message: "Copied to clipboard",
      });
    },
    isString(programFee, promotionalPeriod) {
      if (typeof programFee == "string") {
        return programFee;
      } else if (typeof promotionalPeriod == "string") {
        return promotionalPeriod;
      }
    }
  }
};
</script>
<style>
</style>
