<template>
  <b-card no-body class="card-profile" alt="Image placeholder" img-top>
    <b-row class="justify-content-center">
      <b-col lg="2" class="order-md-2">
        <div class="card-profile-image">
          <a href="#">
            <b-img :src="agent.profile_image_url" rounded="square" />
          </a>
        </div>
      </b-col>
    </b-row>

    <b-card-header class="text-center border-0 pt-8 pt-md-4 pb-0 pb-md-4">
      <div class="d-flex justify-content-between">
        <a href="#" class="btn btn-sm btn-info mr-4">Connect</a>
        <a href="#" class="btn btn-sm btn-default float-right">Message</a>
      </div>
    </b-card-header>

    <b-card-body class="pt-0">
      <b-row>
        <b-col >
          <div class="card-profile-stats d-flex justify-content-center mt-md-5">
            <!-- <div>
              <span class="heading">{{agent.instagram}}</span>
              <span class="description">Friends</span>
            </div>
            <div>
              <span class="heading">{{agent.facebook}}</span>
              <span class="description">Photos</span>
            </div>
            <div>
              <span class="heading">{{agent.linked_in}}</span>
              <span class="description">Comments</span>
            </div> -->
          </div>
        </b-col>
      </b-row>
      <div class="text-center">
        <h5 class="h3">
          {{agent.name}}<span class="font-weight-light"> {{agent.nickname}}</span>
        </h5>
        <div class="h5 font-weight-300">
          <i class="ni location_pin mr-2"></i>MLS Agent ID: {{agent.mls_agent_id}}
        </div>
        <div class="h5 mt-4">
          <i class="ni business_briefcase-24 mr-2"></i>{{agent.title}}
        </div>
        <div>
          <i class="ni education_hat mr-2"></i>{{agent.mls_name}}
        </div>
        <hr class="my-4">
        <p v-html="agent.bio[0].body"></p>
        <a>Show more</a>


      </div>
    </b-card-body>
  </b-card>
</template>
<script>
import {fetchAgentData} from '@/services/AuthenticationService.js'
export default {
  data() {
    return {
      agent: null
    }
  },
    props: {
      agentUuid: String
    },
  mounted() {
    this.getAgentData()
  },
  methods: {
    async getAgentData() {
      const companyId = this.$route.params.moxi_works_company_id
      try {
        const res = await fetchAgentData(this.agentUuid, companyId)
        this.agent = res.data.data
      } catch (error) {
        console.log(error)
      }
    }
  }
};
</script>
<style></style>
