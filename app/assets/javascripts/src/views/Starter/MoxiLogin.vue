<template>
    <div class="login-container">
    <h2>Login</h2>
    <base-input v-model="username" label="Username" type="text"></base-input>
    <base-input v-model="password" label="Password" type="password"></base-input>
    <button @click="login">Login</button>
    <div v-if="error" class="danger">{{ error }}</div>
    </div>
</template>

<script>
import {login, logout} from '@/services/AuthenticationService.js'
export default {
    data() {
        return {
            username: '',
            password: '',
            error: ''
        }
    },
    computed: {
        // ...mapGetters("company", ["getCompanies"]),
    },    
    methods: {
        async login() {
            try {
                const result = await login(this.username, this.password)
                console.log(result.data)
                if(result.success) {
                    this.error = ''
                    this.$store.dispatch('setCompanies', result.data)
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
        }
    }
}
</script>

<style>

</style>