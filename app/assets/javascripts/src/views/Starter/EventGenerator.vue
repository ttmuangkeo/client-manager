<!-- <template>
  <div class="container">
    <div class="row">
      <section id="changeType">
        <div id="changeForm" class="form-group">
          <label>type</label>
          <select
            @change="testing(events)"
            name="eventType"
            id="eventType"
            class="form-select"
            v-model="events"
          >
            <option v-for="(event, key) in $store.getters.eventsData" :key="key">
              {{key}}
            </option>
          </select>
          <br>
          <input type="text" placeholder="loanId" v-model="loanId">
        </div>
      </section>
      <div id="form" v-if="this.events">
        <hr />
        <component 
        v-bind:is="this.events" 
        :uuid=this.uuid 
        :utc=this.utc
        :loanId=this.loanId>
        </component>
      </div>
    </div>
  </div>
</template> -->

<template>
  <div>
    <base-header class="pb-6 pb-8 pt-5 pt-md-4 bg-transparent">
      <h1>Event Generator</h1>
    </base-header>
    <b-container fluid>
      <b-row>
        <b-col xl="4" class="order-xl-1">
          <template>
            <b-form>
              <div class="pl-lg-4">
                <section id="changeOrder">
                  <div id="changeForm">
                    <label>Type</label>
                    <select
                      @change="testing(events)"
                      name="eventType"
                      id="eventType"
                      class="form-select"
                      v-model="events"
                    >
                      <option
                        v-for="(event, key) in $store.getters.eventsData"
                        :key="key"
                      >
                        {{ key }}
                      </option>
                    </select>
                    <br />
                    <base-input
                      type="text"
                      placeholder="loanId"
                      v-model="loanId"
                    ></base-input>
                  </div>
                </section>
              </div>
            </b-form>
          </template>
        </b-col>
        <b-col xl="8" class="order-xl-2">
          <b-row lg="5" v-show="$store.getters.organzationUsers">
            <div id="form" v-if="this.events">
              <component
                v-bind:is="this.events"
                :uuid="this.uuid"
                :utc="this.utc"
                :loanId="this.loanId"
              >
              </component>
            </div>
          </b-row>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import ChangeOrder from "../Layout/ChangeOrder.vue";
import FundingRecalculation from "../Layout/FundingRecalculation.vue";
import LoanCanceled from "../Layout/LoanCanceled.vue";
import DocsRequested from "../Layout/DocsRequested.vue";
import { uuid } from "vue-uuid";
import dataJson from "../../json/data.json";
export default {
  data() {
    return {
      events: "",
      loanId: "",
      uuid: uuid.v4(),
      utc: this.utcGenerator(),
    };
  },
  components: {
    ChangeOrder,
    FundingRecalculation,
    LoanCanceled,
    DocsRequested,
  },
  mounted() {
    const self = this;
    if (!this.events) {
      self.$store.commit("updateEventsData", dataJson);
    }
  },
  methods: {
    utcGenerator() {
      return new Date().toISOString();
    },
    testing(data) {
      const self = this;
      self.$store.commit("updateEventsType", data);
    },
  },
};
</script>

<style>

</style>