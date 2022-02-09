import { defineStore } from 'pinia'

export const useStore = defineStore({
  id: '1',
  state: () => ({
    asideOpen: true,
  }),
  actions: {
    changAsideOpen() {
      this.asideOpen = !this.asideOpen
    },
  },
})
