<template>
  <section class="container">
    <div class="row">
      <div class="form-group">
        <div>
          <label>
            oldOfferId
            <input 
              type="text"
              class="form-control"
              v-model="oldOfferId"
              placeholder="e9b413d5-3115-4777-85f9-adfeac193c38"
            />
          </label>
          <label>
            newOfferId
            <input 
              type="text"
              class="form-control"
              v-model="newOfferId"
              placeholder="e9b413d5-3115-4777-85f9-adfeac193c38"
            />
          </label>
          <label>
            oldTotalAmount
            <input 
              type="text"
              class="form-control"
              v-model="oldTotalAmount"
              placeholder="$1234"
            />
          </label> 
          <label>
            oldProjectCost
            <input 
              type="text"
              class="form-control"
              v-model="oldProjectCost"
              placeholder="$1234"
            />
          </label> 
          <label>
            newTotalAmount
            <input 
              type="text"
              class="form-control"
              v-model="newTotalAmount"
              placeholder="$1234"
            />
          </label> 
          <label>
            oldSelectedLoanOption
            <input 
              type="text"
              class="form-control"
              v-model="oldSelectedLoanOption"
              placeholder="1"
            />
          </label> 
          <label>
            newSelectedLoanOption
            <input 
              type="text"
              class="form-control"
              v-model="newSelectedLoanOption"
              placeholder="2"
            />
          </label>
          <label>
            oldTotalSystemCost
            <input 
              type="text"
              class="form-control"
              v-model="oldTotalSystemCost"
              placeholder="$1234"
            />
          </label> 
          <label>
            newTotalSystemCost
            <input 
              type="text"
              class="form-control"
              v-model="newTotalSystemCost"
              placeholder="$1234"
            />
          </label> 
          <label>
            verifiedBy
            <input 
              type="text"
              class="form-control"
              v-model="verifiedBy"
              placeholder="eeClientEnergy"
            />
          </label>   
          <label>
            autopayIntent
            <select v-model="autopayIntent">
              <option>false</option>
              <option>true</option>
            </select>
          </label>                                                                       
        </div>
      </div>
    </div>
    <pre>
{
  "details": "{\"oldOfferId\":\"{{oldOfferId}}\",\"newOfferId\":\"{{newOfferId}}\",\"oldProjectCost\":{{oldProjectCost}},\"newProjectCost\":{{newProjectCost}},\"oldTotalAmount\":{{oldTotalAmount}},\"newTotalAmount\":{{newTotalAmount}},\"oldSelectedLoanOption\":\"{{oldSelectedLoanOption}}\",\"newSelectedLoanOption\":\"{{newSelectedLoanOption}}\",\"oldTotalSystemCost\":{{oldTotalSystemCost}},\"newTotalSystemCost\":{{newTotalSystemCost}},\"verifiedBy\":\"{{verifiedBy}}\",\"autopayIntent\":{{autopayIntent}}}",
  "eventType": "ChangeOrder",
  "id": "{{ uuid }}",
  "loanId": "{{loanId | trimWhiteSpace}}",
  "timestamp": "{{ utc }}"
}
<div>
  v1 ChangeOrder event
</div>
{
    "details": "{\"autopayIntent\":true,\"oldTotalSystemCost\":\"$45,000.00\",\"newTotalSystemCost\":\"$44,793.86\",\"oldSelectedLoanOption\":\"14\",\"newSelectedLoanOption\":\"13\",\"verifiedBy\":\"isoria@goodleap.com\",\"source\":\"Manual Change Order\"}",
    "eventType": "ChangeOrder",
    "id": "1ee276fc-07a9-4027-8c50-6c0ef03f4e68",
    "loanId": "21-05-061093",
    "timestamp": "2021-08-20T21:16:00.000Z"
}
    </pre>
  </section>
</template>

<script>
export default {
  props: ['uuid', 'utc', 'loanId'],
  data() {
    return {
      oldOfferId: "",
      newOfferId: "",
      oldProjectCost: "",
      newProjectCost: "",
      oldTotalAmount: null,
      newTotalAmount: "",
      oldSelectedLoanOption: "",
      newSelectedLoanOption: "",
      oldTotalSystemCost: "",
      newTotalSystemCost: "",
      verifiedBy: "",
      autopayIntent: null
    }
  }
}
</script>

<style scoped>

</style>