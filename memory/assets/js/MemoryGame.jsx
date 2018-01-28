import React from 'react';
import ReactDOM from 'react-dom';

export default function game_init(root) {
  	ReactDOM.render(<MemoryGame />, root);
}

class MemoryGame extends React.Component {
  	constructor(props) {
    	super(props);
    	this.state = { 
			tiles: [{
				id: "t1", letter: 'D', hidden: true, matched: false
			}, {
	  			id: "t2", letter: 'H', hidden: true, matched: false
	 	  	}, {
	  			id: "t3", letter: 'B', hidden: true, matched: false
	  		}, {
	  			id: "t4", letter: 'E', hidden: true, matched: false
	  		}, {
	  			id: "t5", letter: 'C', hidden: true, matched: false
	  		}, {
	  			id: "t6", letter: 'C', hidden: true, matched: false
	  		}, {
	  			id: "t7", letter: 'E', hidden: true, matched: false
	  	  	}, {
	  			id: "t8", letter: 'G', hidden: true, matched: false
	  	  	}, {
				id: "t9", letter: 'F', hidden: true, matched: false
	  	  	}, {
	  			id: "t10", letter: 'G', hidden: true, matched: false
	  	  	}, {
	  	  		id: "t11", letter: 'H', hidden: true, matched: false
	  	  	}, {
	  			id: "t12", letter: 'F', hidden: true, matched: false
	  	  	}, {
	  			id: "t13", letter: 'D', hidden: true, matched: false
	 	   	}, {
	  			id: "t14", letter: 'A', hidden: true, matched: false
	  	  	}, {
	  			id: "t15", letter: 'B', hidden: true, matched: false
	  	  	}, {
	  			id: "t16", letter: 'A', hidden: true, matched: false
	  	  	}
		]
    }
  }
  
  toggleVisibility(id) {
	  let xs = _.map(this.state.tiles, (tile) => {
	  	if (tile.id == id) {
	    	return _.extend(tile, {hidden: false});
	    } else {
			return tile;
	    }
	 });
	 this.setState({ tiles: xs });
  }
    
  render() {
    let tile_list = _.map(this.state.tiles, (tile, ii) => {
	        return <Tile tile={tile} toggleVisibility={this.toggleVisibility.bind(this)} key={ii} />;
	});
    return (
	  <div className="row game-row">
	    { tile_list }  
	  </div>
    )
  }
}

function Tile(params) {
  let item = params.tile;
  if (item.matched) {
    return (
	  <div className="col-3 game-col-matched">
	    <p id = {item.id}></p>
      </div>
	)
  } else if (item.hidden) {
    return (
	  <div className="col-3 game-col" onClick={() => params.toggleVisibility(item.id)}>
	    <p id = {item.id}></p>
      </div>
    ) 
  } else {
      return (
  	  <div className="col-3 game-col">
  	    <p id = {item.id}>{item.letter}</p>
      </div>
    )
  }
}

