import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import KazaView from '../views/KazaView.vue'
import InsView from '../views/InsView.vue'
import YerView from '../views/YerView.vue'
import ZanView from '../views/ZanView.vue'
import MadView from '../views/MadView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
  },
  {
    path: '/kaza',
    name: 'kaza',
    component: KazaView,
  },
  {
    path: '/ins',
    name: 'ins',
    component: InsView,
  },
  {
    path: '/yer',
    name: 'yer',
    component: YerView,
  },
  {
    path: '/zan',
    name: 'zan',
    component: ZanView,
  },
  {
    path: '/mad',
    name: 'mad',
    component: MadView,
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
