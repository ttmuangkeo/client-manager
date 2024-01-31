import axios from "axios";

async function authenticate(username, password) {
  console.log("from my auth service in vue", username, password);
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
    console.log('response back ', response)
    return {
      success: true,
      data: response.data,
    };
  } catch (err) {
    console.log("auth error", err);
    return {
      success: false,
      error: "failed to auth in",
    };
  }
}

export { authenticate };
