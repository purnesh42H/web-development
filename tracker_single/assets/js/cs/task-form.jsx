import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import { Link } from 'react-router-dom';
import api from '../api';

function TaskForm(params) {
  console.log("params@PostForm", params);
   
  function submit_update(ev) {
    let data = {
      title: params.form.title,
      description: params.form.description,
      id: params.form.id,
      user_id: params.form.user_id,
      minutes: params.form.minutes
    }
    api.update_task(data);
    clear();
  }
 
  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    };
    console.log(action);
    params.dispatch(action);
  }

  function update_task(task) {
    let data = task[0];
    console.log("Israel", data);
    let action = {
      type: 'UPDATE_FORM',
      data: {
        title: data.title,
        description: data.description,
        id: data.id,
        is_completed: data.is_completed,
        minutes: data.minutes,
        user_id: data.user.id
      },
    };
    console.log(action);
    params.dispatch(action);
  }

  function submit(ev) {
    api.submit_task(params.form);
    console.log("Should create task");
    console.log(params.form);
    clear(ev);
  }

  function clear(ev) {
    params.dispatch({
      type: 'CLEAR_FORM',
    });
  }
  
  if(params.form.token) {
    let temp_users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
    let users = _.union([<option key="" value="">Select an employee</option>], temp_users);
    let task = params.task;
    if(task) {
      if (params.form.title == "") { 
        update_task(task);
      }
      return <div style={ {padding: "4ex"} }>
      <h2>Edit Task</h2>
      <FormGroup>
        <Label for="user_id">User</Label>
        <Input type="select" name="user_id" value={params.form.user_id} onChange={update}>
          { users }
        </Input>
      </FormGroup>
      <FormGroup>
        <Label for="title">Title</Label>
        <Input type="text" name="title" value={params.form.title} onChange={update} />
        <Label for="description">Description</Label>
        <Input type="text" name="description" value={params.form.description} onChange={update} />
        <Label for="title">Minutes</Label>
        <Input type="text" name="minutes" value={params.form.minutes} onChange={update} />
      </FormGroup>
      <Link to="/" onClick={submit_update} className="btn btn-primary">Update</Link>
      </div>;
    } else { 
      return <div style={ {padding: "4ex"} }>
      <h2>New Task</h2>
      <FormGroup>
        <Label for="user_id">User</Label>
        <Input type="select" name="user_id" value={params.form.user_id} onChange={update}>
          { users }
        </Input>
      </FormGroup>
      <FormGroup>
        <Label for="title">Title</Label>
        <Input type="text" name="title" value={params.form.title} onChange={update} />
        <Label for="description">Description</Label>
        <Input type="text" name="description" value={params.form.description} onChange={update} />
        <Label for="title">Minutes</Label>
        <Input type="text" name="minutes" value={params.form.minutes} onChange={update} />
      </FormGroup>
      <Button onClick={clear} color="primary">Clear</Button>&nbsp;
      <Button onClick={submit} color="primary">Create</Button>
      </div>;
    }
  } else {
    return <div><b>Login to Create/Edit Task</b></div>;
  }
}

function state2params(state) {
  console.log("rerender@PostForm", state);
  return {
    form: state.form,
    users: state.users,
  };
}

// Export the result of a curried function call.
export default connect(state2params)(TaskForm);
