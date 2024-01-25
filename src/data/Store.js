import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        programFee: [],
        eventsData: {},
        eventsType: '',
        partnerData: {},
        newPartnerData: {},
        loanOptionsMap: [],
        optionList: [],
        uniqueTerms: [],
        user: {},
        organzation: {},
        organzationUsers: {},
        bearerToken: ''
    },
    mutations: {
        updateEventsData(store, val) {
            store.eventsData = val
        },
        updateProgramFee(store, val) {
            store.programFee = val
        },
        updateEventsType(store, val) {
            store.eventsType = val
        },
        updatePartnerData(store, val) {
            store.partnerData = val
        },
        updateLoanOptionsMap(store, val) {
            store.loanOptionsMap = val
        },
        updateOptionList(store, val) {
            store.optionList = val
        },
        updateNewPartnerData(store, val) {
            store.newPartnerData = val
        },
        updateUniqueTerms(store, val) {
            store.uniqueTerms = val
        },
        updateUser(store, val) {
            store.user = val
        },
        updateOrganization(store, val) {
            store.organzation = val
        },
        updateOrganizationUsers(store, val) {
            store.organzationUsers = val
        },
        updateBearerToken(store, val) {
            store.bearerToken = val
        }
    },
    getters: {
        eventsType: (store) => store.eventsType,
        eventsData: (store) => store.eventsData,
        partnerData: (store) => store.partnerData,
        loanOptionsMap: (store) => store.loanOptionsMap,
        optionList: (store) => store.optionList,
        newPartnerData: (store) => store.newPartnerData,
        programFee: (store) => store.programFee,
        uniqueTerms: (store) => store.uniqueTerms,
        user: (store) => store.user,
        organzation: (store) => store.organzation,
        organzationUsers: (store) => store.organzationUsers,
        bearerToken: (store) => store.bearerToken
    },

})