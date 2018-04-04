import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Link } from 'react-router-dom';

export default function Task(params) {
  let task = params.task;
  console.log(task);
  return <tr>
        <td><b>{ task.user.name }</b></td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        <td>{ task.minutes }</td>
        <td>{ task.is_completed.toString() }</td>
        <td className="text-right">
          <span><Link className="btn btn-default btn-xs" to="/">Edit</Link></span>
        </td>
      </tr>;
}
