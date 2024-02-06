import axios from "axios";

async function login(username, password) {
  try {
    const response = await axios.post(
      "moxi/authenticate",
      {
        username: username,
        password: password,
      },
      {
        withCredentials: true,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/vnd.moxi-platform+json;version=1",
        },
      }
    );
    console.log('from auth service', response)
    if (response.status === 200) {
      storeToken(response.token)
      console.log(storeToken)
      return {
        success: true,
        data: response.data.data,
      }
    }
  } catch (err) {
    return {
      success: false,
      error: "failed to auth in",
    };
  }
}
function storeToken(token) {
  document.cookie = `authToken=${token}; Secure; SameSite=None; Path=/;`;
}
async function logout() {
  try {
    const response = await axios.post("/logout")
    return {
      success: true,
      message: response.data.message
    }
  } catch (error) {
    return {
      success: false,
      error: 'failed to logout'
    }
  }
}

async function fetchBrandingData(moxi_works_company_id) {
  try {
    const response = await axios.get(`/moxi/company/branding/${moxi_works_company_id}`, {
      headers: {
        Accept: 'application/vnd.moxi-platform+json;version=1'
      }
    });
    console.log('from auth svc', response)
    return {
      success: true,
      data: response.data
    };
  } catch(err) {
    console.log(err)
  }
}
async function fetchListingData(moxi_works_company_id) {
  try {
    const response = await axios.get(`/moxi/company/listing/${moxi_works_company_id}`, {
      headers: {
        Accept: 'application/vnd.moxi-platform+json;version=1'
      }
    });
    console.log('from auth svc', response)
    return {
      success: true,
      data: response.data
    };
  } catch(err) {
    console.log(err)
  }
}
async function fetchListingId(moxi_works_listing_id, moxi_works_company_id) {
  try {
    const response = await axios.get(`/moxi/company/listing/${moxi_works_listing_id}/${moxi_works_company_id}`, {
      headers: {
        Accept: 'application/vnd.moxi-platform+json;version=1'
      }
    });
    console.log('from auth svc', response)
    return {
      success: true,
      data: response.data
    };
  } catch(err) {
    console.log(err)
  }
}
async function fetchAgentData(agent_uuid, moxi_works_company_id) {
  try {
    const response = await axios.get(`/moxi/company/agent/${agent_uuid}/${moxi_works_company_id}`, {
      headers: {
        Accept: 'application/vnd.moxi-platform+json;version=1'
      }
    });
    console.log('from auth svc', response)
    return {
      success: true,
      data: response.data
    };
  } catch(err) {
    console.log(err)
  }
}

export { login, logout, fetchBrandingData, fetchListingData, fetchListingId, fetchAgentData};
