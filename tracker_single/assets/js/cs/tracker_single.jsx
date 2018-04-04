import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider, connect } from 'react-redux';

import Nav from './nav';
import Tasks from './tasks';
import Users from './users';
import TaskForm from './task-form';

export default function tracker_single_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <TrackerSingle state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  );
}

let TrackerSingle = connect((state) => state)((props) => {
  return (
    <Router>
      <div>
        <Nav />
        <Route path="/" exact={true} render={() =>
          <div>
            <TaskForm />
            <Tasks tasks={props.tasks} />
          </div>
        } />
        <Route path="/users" exact={true} render={() =>
          <Users users={props.users} />
        } />
        <Route path="/users/:user_id" render={({match}) =>
          <Tasks tasks={_.filter(props.tasks, (pp) =>
            match.params.user_id == pp.user.id )
          } />
        } />
      </div>
    </Router>
  );
});
