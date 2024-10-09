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
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;