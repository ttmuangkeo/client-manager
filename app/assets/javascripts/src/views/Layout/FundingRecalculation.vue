<template>
  <section class="container">
manual added source
<pre>
{
    "details": "{\"source\":\"ManualAdded\"}",
    "eventType": "FundingRecalculation",
    "id": "{{uuid}}",
    "loanId": "{{loanId}}",
    "timestamp": "{{utc}}"
}    
</pre>   
  </section>
</template>

<script>
  import Vue from 'vue'
  import VueClipboard from 'vue-clipboard2'
  Vue.use(VueClipboard);

export default {
  props: ['uuid', 'utc', 'loanId'],
  components: {
    VueClipboard
  },
  data() {
    return {
      verifiedBy: '',
      username: '',
      source: '',
      oldTotalSystemCost: '',
      newTotalSystemCost: '',
    }
  },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      }
    }
}
</script>

<style>
</style>