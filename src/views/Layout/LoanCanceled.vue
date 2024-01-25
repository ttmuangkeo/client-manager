<template>
  <section class="container">
    <div class="row">
      <div class="form-group">
        <div>
          <label>
            reason
            <select v-model="reason">
              <option>Customer No Longer Interested</option>
              <option>Credit Expired</option>
            </select>
          </label>   
          <label>
            canceledBy
            <input 
            type="email"
            v-model="canceledBy"
            >
          </label>                                                        
        </div>
      </div>
    </div>
      <pre>
{
  "details": "{\"reason\":\"{{reason}}\",\"canceledBy\":\"{{canceledBy}}\"}",
  "eventType": "LoanCanceled",
  "id": "{{uuid}}",
  "loanId": "{{loanId}}",
  "timestamp": "{{utc}}"
}
      </pre>    
  </section>
</template>

<script>
export default {
  props: ['uuid', 'utc', 'loanId'],
  data() {
    return {
      reason: null,
      canceledBy: ''
    }
  }
}
</script>

<style scoped>
</style>