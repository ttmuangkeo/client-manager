  <!-- <div>
    <h2>Login</h2>
    <form @submit.prevent="login">
      <label for="username">Username:</label>
      <input type="text" v-model="username" id="username" required />

      <label for="password">Password:</label>
      <input type="password" v-model="password" id="password" required />

      <button type="submit">Login</button>
    </form>
  </div> -->
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
      password: ''
    };
  },
  methods: {
    async login() {
      try {
        const token = await this.fetchToken();
      } catch(err) {
        console.log(err)
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
        throw new Error('Invalid Creds')
      }
    }
  }
}
</script>

<style scoped>
/* Component styles... */
</style>
      //   async login() {
      //     try {
      //       const token = await this.fetchToken();
      //       console.log('Access Token:', token);
      //       // Handle the token as needed (e.g., store it, redirect, etc.)
      //     } catch (error) {
      //       console.error('Error during login:', error);
      //     }
      //   },
      //   async fetchToken() {
      //     const response = await fetch('http://localhost:3000/authenticate', {
      //       method: 'POST',
      //       headers: {
      //         'Content-Type': 'application/json',
      //       },
      //       body: JSON.stringify({
      //         username: this.username,
      //         password: this.password,
      //       }),
      //     });
    
      //     // if (!response.ok) {
      //     //   throw new Error('Invalid credentials');
      //     // }
    
      //     const data = await response.json();
      //     return data.access_token;
      //   },
      // },
