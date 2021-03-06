import { createApp } from 'vue'
import App from './App.vue'
import router from '@/router/index'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ELIcons from '@element-plus/icons-vue'
import '@/style/base.css'

const app = createApp(App)
for (const iconName in ELIcons) {
  app.component(iconName, (ELIcons as any)[iconName])
}
app.use(ElementPlus)
app.use(router)
app.use(createPinia())
app.mount('#app')
