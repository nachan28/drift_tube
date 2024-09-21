<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <header class="global-header">
  </header>
  <RouterView />
</template>

<style scoped lang="scss">
.global-header {
  background-color: #E0F4FF;
  padding:16px 16px;
}

</style>
