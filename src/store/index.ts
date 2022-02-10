import { defineStore } from 'pinia'

export const useStore = defineStore({
  id: 'indexStore',
  state: () => ({
    asideOpen: true,
    path: '',
  }),
  actions: {
    changAsideOpen() {
      this.asideOpen = !this.asideOpen
    },
    changPath() {
      this.path = window.sessionStorage.getItem('path') as string
    },
  },
})
