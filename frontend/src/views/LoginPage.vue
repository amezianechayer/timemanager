<template>
  <div class="login-container">
    <div class="login-card">
      <h1>Arkham Tracker</h1>
      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="username">Nom d'utilisateur</label>
          <input type="text" id="username" v-model="username" required />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input type="password" id="password" v-model="password" required />
        </div>
        <button type="submit">Se connecter</button>
        <p class="error-message" v-if="errorMessage">{{ errorMessage }}</p>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
      errorMessage: ''
    };
  },
  methods: {
    handleLogin() {
      // Logique de connexion (exemple de simulation)
      if (this.username === 'admin' && this.password === 'password') {
        this.$router.push({ name: 'Home' }); // Redirige vers la page d'accueil
      } else {
        this.errorMessage = 'Nom d\'utilisateur ou mot de passe incorrect.';
      }
    }
  }
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #1d1d1d; /* Couleur sombre pour l'ambiance d'Arkham */
  color: #f5f5f5;
}

.login-card {
  background-color: #282828; /* Couleur du card */
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
  width: 300px;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
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
  border-color: #007bff; /* Couleur de survol */
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
  background-color: #0056b3; /* Couleur de survol du bouton */
}

.error-message {
  color: #ff0000; /* Couleur rouge pour les messages d'erreur */
  text-align: center;
  margin-top: 10px;
}
</style>
