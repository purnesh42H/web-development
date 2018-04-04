import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Task(params) {
  let post = params.task;
  return <Card>
    <CardBody>
      <div>
        <p>Task belong to <b>{ task.user.name }</b></p>
        <p>{ task.title }</p>
				<p>{ task.description }</p>
				<p>{ task.minutes }</p>
				<p>{ task.is_completed }</p>
      </div>
    </CardBody>
  </Card>;
}
