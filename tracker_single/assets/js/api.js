import store from './store';

class TheServer {
  request_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
    });
  }

  request_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'USERS_LIST',
          users: resp.data,
        });
      },
    });
  }

  submit_task(data) {
    $.ajax("/api/v1/tasks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ token: data.token, task: data }),
      success: (resp) => {
        store.dispatch({
          type: 'ADD_TASK',
          task: resp.data,
        });
      },
    });
  }

  submit_login(data) {
    let cur_obj = this;
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
        cur_obj.request_users();
      },
      error: (resp) => {
        alert("Name and Password are mandatory for login");
      }
    });
  }
  
  logout() {
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({}),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
        window.location.reload();
      },
      error: (resp) => {
        alert("Name and Password are mandatory for login");
      }
    });
  }
  
  submit_register(data) {
    let user = JSON.stringify({
      user: {
        name: data.name,
        password_hash: data.pass,
        email: data.email 
      },
    });
    let cur_obj = this;
    
    $.ajax("/api/v1/users", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: user,
      success: (resp) => {
        cur_obj.submit_login(data);
      },
      error: (resp) => {
	alert("Name, Password and Email are mandatory for registration");
      }
    });
  }

  update_task(data) {
    let task = JSON.stringify({
      task: data
    });
    let cur_obj = this;
     $.ajax("/api/v1/tasks/" + data.id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: task,
      success: (resp) => {
        cur_obj.request_tasks();
      },
      error: (resp) => {
        alert("error", resp);
      }
    });
  }

  delete_task(data) {
    console.log(data);
    let cur_obj = this;
    $.ajax("/api/v1/tasks/" + data, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        cur_obj.request_tasks();
      },
      error: (resp) => {
        alert("error", resp);
      }
    });
  }
}

export default new TheServer();
