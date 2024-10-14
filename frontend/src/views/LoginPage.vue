
<template>
  <div class="login-container">
    <img src="@/assets/fondEcran.webp" alt="Arkham Tracker Logo" class="background-image">
    <div class="overlay"></div> <!-- Superposition sombre -->
    <h1 class="text-6xl font-bold leading-none mr-10">
      <span class="block text-white">Arkham</span>
      <span class="block ml-12 text-white">Tracker</span>
    </h1>

    <div class="login-card">
      <img src="@/assets/iconeApp.webp" alt="Arkham Tracker Logo" class="h-24 w-24 rounded-2xl mx-auto mb-2">

      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="userType">Type d'utilisateur</label>
          <select id="userType" v-model="userType" required>
            <option value="admin">Admin</option>
            <option value="user">Utilisateur</option>
          </select>
        </div>
        <div class="form-group">
          <label for="email">adresse mail</label>
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
import axios from 'axios';

export default {
  setup() {

   // const userType = ref('user'); // Valeur par défaut
    const email = ref('');
    const hash_password = ref('');
    const errorMessage = ref('');

    const handleLogin = async () => {
      if (!email.value || !hash_password.value) {
        errorMessage.value = 'Veuillez remplir tous les champs.';
        return;
      }

      try {
        const { data } = await axios.post('http://localhost:4000/api/users/login', {
          email: email.value,
          hash_password: hash_password.value
        }, { withCredentials: true });

        axios.defaults.headers.common['Authorization'] = `Bearer ${data.token}`;

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
  position: relative; /* Position relative pour que l'image de fond s'embrique correctement */
  color: #f5f5f5;
  overflow: hidden; /* Pour éviter le débordement */
}

.background-image {
  position: absolute; /* Positionne l'image en arrière-plan */
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover; /* Pour que l'image couvre tout l'espace */
  z-index: 0; /* S'assure que l'image est derrière le contenu */
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* Couleur noire avec opacité */
  z-index: 1; /* Assure que la superposition est au-dessus de l'image de fond */
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  position: relative; /* Positionne le texte par rapport à l'image de fond */
  z-index: 2; /* S'assure que le texte est au-dessus de l'image de fond */
}

.login-card {
  background-color: #282828; /* Couleur du card */
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
  width: 400px; /* Largeur ajustée pour correspondre à la page d'inscription */
  position: relative; /* Pour s'assurer que le card est au-dessus de l'image */
  z-index: 2; /* Assure que le card est au-dessus de l'image de fond */
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
  background-color: #3b3b3b; /* Couleur de fond */
  color: #000; /* Couleur du texte (noir) */
}

/* Styles supplémentaires */
select:hover, select:focus {
  background-color: #444; /* Couleur de fond au survol ou au focus */
  color: #ffffff; /* Couleur du texte au survol ou au focus */
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
  border-color: #007bff; /* Couleur de bordure au focus */
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

.register-link {
  text-align: center;
  margin-top: 10px;
}

.register-link a {
  color: #007bff; /* Couleur du lien */
  text-decoration: underline;
}
</style>