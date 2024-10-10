import { createRouter, createWebHistory } from 'vue-router';
const routes = [

    {
        path: '/home',
        name: 'Home',
        component: () => import("@/views/HomePage.vue"),
    },
    {
        path: '/about',
        name: 'About',
        component: () => import("@/views/AboutPage.vue")
    },
    {
        path: '/',
        name: 'Login',
        component: () => import("@/views/LoginPage.vue")
    },
    {
        path: '/moderation',
        name: 'Moderation',
        component: () => import("@/views/ModerationPage.vue")
    },
    {
        path: '/board',
        name: 'board',
        component: () => import("@/views/BoardPage.vue")
    },
    {
      path: '/chart',
      name: 'chart',
      component: () => import("@/views/ChartHours.vue")
  },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;