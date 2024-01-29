const BASE_URL = '/api';
const COMPANY_ENDPOINT = '/companies';

async function authenticate(username, password) {
    try {
        const res = await fetch(`${BASE_URL}${COMPANY_ENDPOINT}`, {
            method: 'GET',
            headers: {
                'Authorization': `Basic ${btoa(`${username}:${password}`)}`,
                'Content-type': 'application/x-www-form-urlencoded',
                'Accept': 'application/vnd.moxi-platform+json;version=1'
            }
        });

        console.log(res)
        if(!res.ok) {
            const errorData = await res.json();
            throw new Error(`authen fails: ${errorData.message || 'invald creds'}`);
        }
        const data = await res.json();
        return {success: true};
    } catch(err) {
        console.log(err)
        return {success: false, error: 'failed to auth in'}
    }
}

export {authenticate};