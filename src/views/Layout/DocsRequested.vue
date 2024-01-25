<template>
  <section class="container">
    <div class="row">
      <div class="form-group">
        <div>
          <label>
            requestedBy
            <input 
              type="text"
              class="form-control"
              placeholder="test@loanpal.com"
              v-model="requestedBy"
            />
          </label>
          <label>
            forceRegen
            <select v-model="forceRegen">
              <option>false</option>
              <option>true</option>
            </select>
          </label>                                                     
        </div>
      </div>
    </div>
<pre>
{
    "details": "{\"requestedBy\":\"{{requestedBy}}\",\"forceRegen\":true,\"skipAuthorizer\":false}",
    "eventType": "DocsRequested",
    "id": "{{uuid}}",
    "loanId": "{{loanId}}",
    "timestamp": "{{utc}}"
}
</pre>
  </section>
</template>

<script>
export default {
  props: ['uuid', 'loanId', 'utc'],
  data() {
    return {
      forceRegen: null,
      requestedBy: ''
    }
  }
}
</script>

<style scoped>
</style>