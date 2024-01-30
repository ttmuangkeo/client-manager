import axios from "axios";
const BASE_URL = "/moxi";
const COMPANY_ENDPOINT = "/companies";

async function authenticate(username, password) {
    try {
        const response = await axios.get(`${BASE_URL}${COMPANY_ENDPOINT}`, {
            headers: {
                Authorization: `Basic ${btoa(`${username}:${password}`)}`,
                "Content-Type": 'application/x-www-form-urlencoded',
                Accept: 'application/vnd.moxi-platform+json;version=1'
            }
        })
        return {
            success: true,
            data: response.data
        }
    } catch(err) {
        console.log('auth error', err);
        return{
            success: false,
            error: 'failed to auth in'
        };
    }
}


export { authenticate };
