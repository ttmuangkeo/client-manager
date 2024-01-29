<template>
  <card class="container">
    <div class="row">
      <div class="col-sm">
        <base-input v-model="username" label="Username" placeholder="Username" type="text"></base-input>
      </div>
      <div class="col-sm">
        <base-input v-model="password" label="Password" placeholder="password" type="password"></base-input>
      </div>
      <div class="row">
        <div class="col-12"></div>
        <div class="col-md-auto">
          <button @click="getData" class="btn btn-success">Get Data</button>
          <div v-if="error" class="danger">{{error}}</div>
        </div>
      </div>
    </div>
  </card>
</template>

<script>
import { authenticate } from '@/services/AuthenticationService.js'


export default {
  data() {
    return {
      username: '',
      password: '',
      error: ''
    };
  },
  methods: {
    async getData() {
      try {
        const result = await authenticate(this.username, this.password)
        if (result.success) {
          this.error = ''
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