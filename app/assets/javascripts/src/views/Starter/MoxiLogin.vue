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
          <button @click="login" class="btn btn-success">Login</button>
          <div v-if="error" class="danger">{{error}}</div>
        </div>
      </div>
    </div>
  </card>
</template>

<script>
import {login, logout} from '@/services/AuthenticationService.js'
import {mapGetters, mapActions} from 'vuex'
export default {
    data() {
        return {
            username: '',
            password: '',
            error: '',
            companies: null
        }
    },
    computed: {
        ...mapGetters(['getToken'])
    },    
    methods: {
        async login() {
            try {
                const result = await login(this.username, this.password)
                console.log('result from login compo', result)
                if(result.success) {
                    this.error = ''
                    this.$store.dispatch('setCompanies', result.data)
                    localStorage.setItem('companies', JSON.stringify(result.data))
                    console.log('Companies stored:', result.data);

                    this.$store.dispatch('setLoggedIn', true)
                    this.$router.push({
                        name: 'moxiCompany', 
                        params: {
                            username: this.username,
                            companies: result.data
                            }
                        })
                } else {
                    this.error = result.error
                }
            } catch (error) {
                console.log("unexpected error", error)
            }
        },
        async logout() {
            try {
                const result = await logout()
                console.log(result)
                if(result.success) {
                    this.username = '',
                    this.password = '',
                    this.error= ''
                    this.$store.dispatch('setLoggedIn', false)
                    this.$router.push({name: 'moxiLogin'})
                } else {
                    console.log(result.error)
                }
            } catch (error) {
                
            }
        },
        ...mapActions(['setToken'])
    }
}
</script>

<style>

</style>