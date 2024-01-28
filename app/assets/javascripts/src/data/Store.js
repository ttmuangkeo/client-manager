import vuex from 'vuex';
import Vue from 'vue';

Vue.use(vuex);

export default new vuex.Store({
    state: {
        access_token: null
    },
    mutations: {
        setAccessToken(state, token) {
            state.access_token = token;
        }
    },
    actions: {
        setAccessToken({commit}, token) {
            commit('setAccessToken', token);
        }
    },
    getters: {
        getAccessToken:(state) => state.access_token
    }
})