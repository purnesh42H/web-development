import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Link } from 'react-router-dom';
import { Button } from 'reactstrap';
import api from '../api';

export default function Task(params) {
  let task = params.task;

  function delete_task(ev) {
    api.delete_task(task.id);
  }

  function update_task(ev) {
    let data = {};
    data.id = task.id;
    data.is_completed = !task.is_completed;
    api.update_task(data);
  }
  
  if (!task.is_completed) {
    return <tr>
        <td><b>{ task.user.name }</b></td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        <td>{ task.minutes }</td>
        <td>{ task.is_completed.toString() }</td>
        <td className="text-right">
          <span>
            <Link className="btn btn-default btn-xs" to={"/tasks/" + task.id}>Edit</Link>
            <Button className="btn btn-danger" onClick={delete_task}>Delete</Button>&nbsp;
            <Button className="btn btn-primary" onClick={update_task}>Mark Complete</Button>
          </span>
        </td>
      </tr>;
   } else {
     return <tr>
        <td><b>{ task.user.name }</b></td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        <td>{ task.minutes }</td>
        <td>{ task.is_completed.toString() }</td>
        <td className="text-right">
          <span>
            <Link className="btn btn-default btn-xs" to={"/tasks/" + task.id}>Edit</Link>
            <Button className="btn btn-danger" onClick={delete_task}>Delete</Button>&nbsp;
            <Button className="btn btn-success" onClick={update_task}>Resume Again</Button>
          </span>
        </td>
      </tr>;
   }
}
