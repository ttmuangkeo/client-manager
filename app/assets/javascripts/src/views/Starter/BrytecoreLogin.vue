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
export default {
  data() {
    return {
      username: '',
      password: '',
      error: ''
    };
  },
  methods: {
    async login() {
      try {
        const token = await this.fetchToken();
        this.$store.dispatch('setAccessToken', token)
        this.error = '';
        this.$router.push('/brytecore/companies');
      } catch(err) {
        console.log(err)
        this.error = err.message
      }
    },
    async fetchToken() {
      const res = await fetch('http://localhost:3000/authenticate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          username: this.username,
          password: this.password
        }),
      });

      if(!res.ok) {
        throw new Error('Username or Password is incorrect')
      }

      const data = await res.json();
      console.log(data);
      return data.access_token
    }
  }
}
</script>

<style scoped>
/* Component styles... */
</style>
