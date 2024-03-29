import vuex from 'vuex';
import Vue from 'vue';

Vue.use(vuex);
const savedAccessToken = localStorage.getItem('access_token')
export default new vuex.Store({
    state: {
        access_token: savedAccessToken || null,
        isLoggedIn: localStorage.getItem('isLoggedIn') !== null ? JSON.parse(localStorage.getItem('isLoggedIn')) : false,
        companies: [],
        companyBranding: null,
        token: null,
        pulledListingData: {}
    },
    mutations: {
        setAccessToken(state, token) {
            console.log('setting access_token', token)
            state.access_token = token;
            localStorage.setItem('access_token', token);
        },
        setLoggedIn(state, status) {
            state.isLoggedIn = status;
            localStorage.setItem('isLoggedIn', status);
        },
        setCompanies(state, companies) {
            state.companies = companies;
        },
        setCompanyBranding(state, branding) {
            state.companyBranding = branding
        },
        setToken(state, token) {
            state.token = token
        },
        setPulledListingData(state, listingData) {
            state.listingData = listingData
        }
    },
    actions: {
        setAccessToken({commit}, token) {
            commit('setAccessToken', token);
        },
        setLoggedIn({commit}, status) {
            commit('setLoggedIn', status)
        },
        setCompanies({commit}, companies) {
            commit('setCompanies', companies)
        },
        setCompanyBranding({commit}, branding) {
            commit('setCompanyBranding', branding)
        },
        setToken({commit}, token) {
            commit('setToken', token)
        },
        setPulledListingData({commit}, listingData) {
            commit('setPulledListingData', listingData)
        }
    },
    getters: {
        getAccessToken:(state) => state.access_token,
        getLoggedIn:(state) => state.isLoggedIn,
        getCompanies:(state) => state.companies,
        getCompanyBranding:(state) => state.branding,
        getToken:(state) => state.token,
        getPulledListingData:(state) => state.listingData
    }
})