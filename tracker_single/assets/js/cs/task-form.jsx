import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';

function TaskForm(params) {
  console.log("params@PostForm", params);

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

  function submit(ev) {
    api.submit_task(params.form);
    console.log("Should create task");
    console.log(params.form);
  }

  function clear(ev) {
    param.dispatch({
      type: 'CLEAR_FORM',
    });
  }

  let users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
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
      <Input type="text" name="title" value={params.form.minutes} onChange={update} />
    </FormGroup>
    <Button onClick={submit} color="primary">Task</Button>
  </div>;
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
