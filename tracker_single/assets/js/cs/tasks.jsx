import React from 'react';
import Task from './task';

export default function Tasks(params) {
  let tasks = _.map(params.tasks, (pp) => <Task key={pp.id} task={pp} />);
  return <table className="table">
      <tbody>
      <tr>
        <th>User</th>
        <th>Title</th>
        <th>Description</th>
        <th>Minutes</th>
        <th>Completed</th>
      </tr>
      { tasks }
   </tbody>
  </table>;
}
