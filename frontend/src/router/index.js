import { createRouter, createWebHistory } from 'vue-router';

const routes = [
    {
        path: '/home',
        name: 'Home',
        component: () => import("@/views/HomePage.vue"),
        meta: { requiresAuth: true }
    },
    {
        path: '/about',
        name: 'About',
        component: () => import("@/views/AboutPage.vue"),
        meta: { requiresAuth: true }
    },
    {
        path: '/',
        name: 'Login',
        component: () => import("@/views/LoginPage.vue")
    },
    {
        path: '/moderation',
        name: 'Moderation',
        component: () => import("@/views/ModerationPage.vue"),
        meta: { requiresAuth: true }
    },
    {
        path: '/board',
        name: 'board',
        component: () => import("@/views/BoardPage.vue"),
        meta: { requiresAuth: true }
    },
    {
        path: '/chart',
        name: 'chart',
        component: () => import("@/views/ChartHours.vue"),
        meta: { requiresAuth: true }
    },
    {
        path: '/register',
        name: 'register',
        component: () => import("@/views/RegisterPage.vue")
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
    const isAuthenticated = !!localStorage.getItem('token'); // Check if the user is authenticated
    if (to.matched.some(record => record.meta.requiresAuth) && !isAuthenticated) {
        next('/'); // Redirect to login page if not authenticated
    } else {
        next(); // Proceed to the route
    }
});

export default router;