// frontend/src/main.js
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import './assets/tailwind.css';
import './interceptors/axios';


createApp(App)
    .use(router)
    .mount('#app');