<template>
  <section>
    <div v-if="$store.getters.newPartnerData">
      <h4>Loan Options</h4>
      <ul v-for="(result, index) in $store.getters.newPartnerData">
        <li>
          ID: {{ result.id }}
          <br />
          installationCategories: {{result.installationCategories}}
          <br>
          productCode: <strong>{{result.productCode}}</strong>
          <br>
          <strong>{{result.term}} year</strong>, {{ result.rate }} Fee: <strong>{{result.programFee}}</strong>
          <div v-if="result.sub650Id">
            <strong>sub650ID</strong>: {{ result.sub650Id }}
          </div>
          <br>
          <div v-if="result.isSub650">
          <strong> isSub650:</strong>{{result.isSub650}}
          </div>
        </li>
      </ul>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
    }
  }
}
</script>

<style scoped>
</style>