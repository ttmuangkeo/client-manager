import vuex from 'vuex';
import Vue from 'vue';

Vue.use(vuex);
const savedAccessToken = localStorage.getItem('access_token')
export default new vuex.Store({
    state: {
        access_token: savedAccessToken || null,
        companies: []
    },
    mutations: {
        setAccessToken(state, token) {
            console.log('setting access_token', token)
            state.access_token = token;
            localStorage.setItem('access_token', token);
        },
        setCompanies(state, companies) {
            state.companies = companies;
        }
    },
    actions: {
        setAccessToken({commit}, token) {
            commit('setAccessToken', token);
        },
        setCompanies({commit}, companies) {
            commit('setCompanies', companies)
        }
    },
    getters: {
        getAccessToken:(state) => state.access_token,
        getCompanies:(state) => state.companies
    }
})