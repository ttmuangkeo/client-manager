<template>
  <card class="container">
    <div class="row">
      <div class="col-sm">
        <base-input v-model="username" label="Partner Identifier" placeholder="2991d0d6-9681-11e8-84cf-0050569c54ad
" type="text"></base-input>
      </div>
      <div class="col-sm">
        <base-input v-model="password" label="Partner Secret" placeholder="123acb" type="password"></base-input>
      </div>
      <div class="row">
        <div class="col-12"></div>
        <div class="col-md-auto">
          <button @click="getData" class="btn btn-success">Get Data</button>
          <div v-if="error" class="danger">{{error}}</div>
        </div>
      </div>
    </div>
    <div class="col-12" v-if="companies.length">
      <ul>
        <card v-for="company in companies" :key="company.id">
            <p> <strong>Name:</strong> {{company.name}}</p>
            <p><strong>Numeric ID:</strong> {{company.numeric_id}}</p>
            <p><strong>Moxi Company ID:</strong> {{company.moxi_works_company_id}}</p>
        </card>
      </ul>
    </div>
  </card>
</template>

<script>
import {mapGetters} from 'vuex';
import { authenticate } from '@/services/AuthenticationService.js';
import StatsCard from '../../components/Cards/StatsCard.vue';


export default {
  components: {
    StatsCard
    },
  data() {
    return {
      username: '',
      password: '',
      error: '',
      companies: []
    };
  },
  computed: {
    ...mapGetters('company', ['getCompanies'])
  },
  methods: {
    async getData() {
      try {
        console.log('from vue comp', this.username, this.password)
        const result = await authenticate(this.username, this.password)
        if (result.success) {
          console.log('from moxicomaby', result)
          this.error = ''
          this.companies = result.data.data
          this.$store.dispatch('setCompanies', result.data.data)
        } else {
          this.error =result.error
        }
      } catch(err) {
        console.log(err)
        this.error = 'unexpected error'
      }
    }
  }
}
</script>

<style>

</style>