<template>
  <div class="search">
    <div class="icon-container">
      <img src="./icons/IconSearch.svg" alt="search" class="search-icon">
    </div>
    <input type="text" class="search-input" placeholder="新しい興味の扉をオープンする" :v-model="searchInput">
    <button class="submit-button" @click="onClick">
      <img src="./icons/IconSearch.svg" alt="search" class="search-icon">
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const searchInput = ref("")

const onClick = async() => {
  const response = await fetch('http://localhost:8080/api/embed', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      texts: searchInput.value,
      input_type: "search_document"
    }),
  });

  console.log(response)
}
</script>

<style lang="scss" scoped>
$input-height: 60px;
$icon-height: 30px;
$icon-width: 30px;

.search {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 35vw;

  .search-icon {
    width: $icon-width;
    height: $icon-height;
  }

  .icon-container {
    background-color: #fff;
    height: $input-height;
    padding: 10px 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #aaa;
    border-right: none;
    border-radius: calc(#{$input-height} / 2) 0px 0px calc(#{$input-height} / 2);
  }

  .search-input {
    font-size: 1.5rem;
    width: 100%;
    padding: 10px 0px;
    height: $input-height;
    outline: none;
    border: 1px solid #aaa;
    border-right: none;
    border-left: none;
  }

  .submit-button {
    height: $input-height;
    border: 1px solid #aaa;
    padding: 10px 30px;
    border-radius: 0px calc(#{$input-height / 2}) calc(#{$input-height / 2}) 0px;
    cursor: pointer;
    &:hover {
      background-color: #ddd;
      transition: 0.5s;
    }
  }
}


</style>