import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';
import { LOCATION_CHANGE } from 'react-router-redux';

function route_change(state = [], action) {
  switch (action.type) {
    case LOCATION_CHANGE:
      return state;
    default:
      return state;
  }
}

function tasks(state = [], action) {
  switch (action.type) {
  case 'TASKS_LIST':
    return [...action.tasks];
  case 'ADD_TASK':
    return [action.task, ...state];
  default:
    return state;
  }
}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return [...action.users];
  default:
    return state;
  }
}

let empty_form = {
  user_id: "",
  title: "",
  description: "",
  minutes: 0,
  token: ""
};

function form(state = empty_form, action) {
  switch (action.type) {
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_FORM':
      let new_state = {
        user_id: "",
        title: "",
        description: "",
        minutes: 0,
        token: state.token
      }
      return new_state;
    case 'SET_TOKEN':
      return Object.assign({}, state, action.token);
    default:
      return state;
  }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    default:
      return state;
  }
}

let empty_login = {
  name: "",
  pass: "",
  email: "",
};

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

function root_reducer(state0, action) {
  // {posts, users, form} is ES6 shorthand for
  // {posts: posts, users: users, form: form}
  let reducer = combineReducers({tasks, users, form, token, login, route_change});
  let state1 = reducer(state0, action);
  return deepFreeze(state1);
};


let store = createStore(root_reducer);
export default store;
