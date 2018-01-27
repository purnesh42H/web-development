import React from 'react';
import ReactDOM from 'react-dom';

export default function init(root) {
  ReactDOM.render(<MemoryGame />, root);
}

class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.state = { 
	 tiles: [{
		letter: 'D', hidden: true, matched: false
	  }, {
	  	letter: 'H', hidden: true, matched: false
	  }, {
	  	letter: 'B', hidden: true, matched: false
	  }, {
	  	letter: 'E', hidden: true, matched: false
	  }, {
	  	letter: 'C', hidden: true, matched: false
	  }, {
	  	letter: 'C', hidden: true, matched: false
	  }, {
	  	letter: 'E', hidden: true, matched: false
	  }, {
	  	letter: 'G', hidden: true, matched: false
	  }, {
		letter: 'F', hidden: true, matched: false
	  }, {
	  	letter: 'G', hidden: true, matched: false
	  }, {
	  	letter: 'H', hidden: true, matched: false
	  }, {
	  	letter: 'F', hidden: true, matched: false
	  }, {
	  	letter: 'D', hidden: true, matched: false
	  }, {
	  	letter: 'A', hidden: true, matched: false
	  }, {
	  	letter: 'B', hidden: true, matched: false
	  }, {
	  	letter: 'A', hidden: true, matched: false
	  }
	]
    }
  }
  
  render() {
	  return (
	        <div className="row">
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	        </div>
	        <div className="row">
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	        </div>
	        <div className="row">
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	        </div>
	        <div className="row">
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	          <div className="col-3 game-col">
	            <p>A</p>
	          </div>
	        </div>
	 	);
  }
}

