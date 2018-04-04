import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';

export default function TaskForm(params) {
  let users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  return <div style={{padding: "4ex"}}>
    <h2>New Task</h2>
    <FormGroup>
      <Label for="user_id">User</Label>
      <Input type="select" name="user_id">
        { users }
      </Input>
    </FormGroup>
    <FormGroup>
      <Label for="title">title</Label>
      <Input type="text" name="title" />
			<Label for="description">title</Label>
      <Input type="text" name="description" />
			<Label for="minutes">title</Label>
      <Input type="text" name="minutes" />
    </FormGroup>
    <Button onClick={() => alert("TODO: Manage State")}>Task</Button>
  </div>;
}
