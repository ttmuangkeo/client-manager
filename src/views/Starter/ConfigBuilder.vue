<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-transparent">
      <!-- Card stats -->
      <b-row>
        <b-col xl="2" md="6">
          <stats-card title="Communications"
                      type="gradient-red"
                      class="mb-4">
            <template slot="footer">
                <sidebar-item
                    :link="{
                        name: 'edit',
                        path: '/event-generator'
                        }"
                    >
                </sidebar-item>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Features"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
                <sidebar-item
                    :link="{
                        name: 'edit',
                        path: '/event-generator'
                        }"
                    >
                </sidebar-item>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Funding Options"
                      type="gradient-green"
                      class="mb-4">
            <template slot="footer">
                <sidebar-item
                    :link="{
                        name: 'edit',
                        path: '/event-generator'
                        }"
                    >
                </sidebar-item>
            </template>
          </stats-card>

        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="ID"
                      type="gradient-info"
                      class="mb-4">

            <template slot="footer">
                <sidebar-item
                    :link="{
                        name: 'edit',
                        path: '/event-generator'
                        }"
                    >
                </sidebar-item>
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Installation Categories"
                      type="gradient-red"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Loan Options Map"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Name"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Salesforce"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Source Options"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Vital Info"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
        <b-col xl="2" md="6">
          <stats-card title="Product Type"
                      type="gradient-orange"
                      class="mb-4">

            <template slot="footer">
            </template>
          </stats-card>
        </b-col>
      </b-row>
    </base-header>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';

  Vue.use(VueClipboard)
  export default {
    name: 'icons',
    components: {
      BaseHeader
    },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      }
    }
  };
</script>
<style></style>
