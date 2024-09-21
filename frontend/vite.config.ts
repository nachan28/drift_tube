import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
import Components from 'unplugin-vue-components/vite'
import sass from 'sass'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
    Components({
      dirs: ['src/components', 'src/views'],
      dts: true,
    }),
  ],
  css: {
    preprocessorOptions: {
      scss: {
        implementation: sass,  // dart-sassを明示的に指定
      },
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
