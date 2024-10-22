<template>
  <div class="login-container">
    <img src="../../assets/fondEcran.webp" alt="Arkham Tracker Logo" class="background-image">
    <div class="overlay"></div>
    <h1 class="text-6xl font-bold leading-none mr-10">
      <span class="block text-white">Arkham</span>
      <span class="block ml-12 text-white">Tracker</span>
    </h1>

    <div class="login-card">
      <img src="../../assets/iconeApp.webp" alt="Arkham Tracker Logo" class="h-24 w-24 rounded-2xl mx-auto mb-2">

      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="userType">Type d'utilisateur</label>
          <select id="userType" v-model="userType" required>
            <option value="admin">Admin</option>
            <option value="user">Utilisateur</option>
          </select>
        </div>
        <div class="form-group">
          <label for="email">Adresse mail</label>
          <input type="text" id="email" v-model="email" required />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input type="password" id="password" v-model="hash_password" required />
        </div>
        <button type="submit">Se connecter</button>
        <p class="error-message" v-if="errorMessage">{{ errorMessage }}</p>
        <p class="register-link">
          <router-link to="/register">Pas encore membre ?</router-link>
        </p>
      </form>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

export default {
  setup() {
    const router = useRouter();
    const email = ref('');
    const hash_password = ref('');
    const errorMessage = ref('');

    const handleLogin = async () => {
      if (!email.value || !hash_password.value) {
        errorMessage.value = 'Veuillez remplir tous les champs.';
        return;
      }

      try {
        const { data } = await axios.post('http://localhost:4000/api/login', {
          user: {
            email: email.value,
            password: hash_password.value
          }
        }, { withCredentials: true });

        axios.defaults.headers.common['Authorization'] = `Bearer ${data.token}`;
        localStorage.setItem('token', data.token); // Store the token in localStorage
        router.push('/home'); // Redirect to home page
      } catch (error) {
        errorMessage.value = error.response?.data?.error || 'Nom d\'utilisateur ou mot de passe incorrect.';
      }
    };

    return {
      email,
      hash_password,
      errorMessage,
      handleLogin
    };
  }
};
</script>


<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  position: relative;
  color: #f5f5f5;
  overflow: hidden;
}

.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: 0;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 1;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  position: relative;
  z-index: 2;
}

.login-card {
  background-color: #282828;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
  width: 400px;
  position: relative;
  z-index: 2;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
}

select {
  width: 100%;
  padding: 10px;
  border: 1px solid #444;
  border-radius: 4px;
  background-color: #3b3b3b;
  color: #000;
}

select:hover,
select:focus {
  background-color: #444;
  color: #ffffff;
}

input {
  width: 100%;
  padding: 10px;
  border: 1px solid #444;
  border-radius: 4px;
  background-color: #3b3b3b;
  color: #f5f5f5;
}

input:focus {
  outline: none;
  border-color: #007bff;
}

button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #ffffff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

button:hover {
  background-color: #0056b3;
}

.error-message {
  color: #ff0000;
  text-align: center;
  margin-top: 10px;
}

.register-link {
  text-align: center;
  margin-top: 10px;
}

.register-link a {
  color: #007bff;
  text-decoration: underline;
}
</style>
