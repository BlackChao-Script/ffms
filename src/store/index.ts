import { defineStore } from 'pinia'

export const useStore = defineStore({
  id: 'indexStore',
  state: () => ({
    asideOpen: true,
  }),
  actions: {
    changAsideOpen() {
      this.asideOpen = !this.asideOpen
    },
  },
})
