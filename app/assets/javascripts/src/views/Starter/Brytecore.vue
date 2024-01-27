<!-- frontend/src/components/LoginForm.vue -->

<template>
  <div>
    <h2>Login</h2>
    <form @submit.prevent="login">
      <label for="username">Username:</label>
      <input type="text" v-model="username" id="username" required />

      <label for="password">Password:</label>
      <input type="password" v-model="password" id="password" required />

      <button type="submit">Login</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
    };
  },
  methods: {
    async login() {
      try {
        const token = await this.fetchToken();
        console.log('Access Token:', token);
        // Handle the token as needed (e.g., store it, redirect, etc.)
      } catch (error) {
        console.error('Error during login:', error);
      }
    },
    async fetchToken() {
      const response = await fetch('http://localhost:3000/authenticate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: this.username,
          password: this.password,
        }),
      });

      // if (!response.ok) {
      //   throw new Error('Invalid credentials');
      // }

      const data = await response.json();
      return data.access_token;
    },
  },
};
</script>

<style scoped>
/* Component styles... */
</style>
