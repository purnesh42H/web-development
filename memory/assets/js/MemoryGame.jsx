import React from 'react';
import ReactDOM from 'react-dom';

export default function game_init(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel} />, root);
}

class MemoryGame extends React.Component {
	constructor(props) {
  	super(props);
        this.channel = props.channel;
  	this.state = {
      tiles: [],
      clicks: 0
    }
    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotView(view) {
    this.setState({
        tiles: view.game.tiles,
        clicks: view.game.clicks
    });
  }

  reset() {
    this.setState({
      tiles: _.shuffle([{
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
  	  }]),
      clicks: 0
    });
  }

  sendGuess(id) {
    this.toggleVisibility(id);
    setTimeout(function() {
      this.channel.push("guess", { id: id })
        .receive("ok", this.gotView.bind(this));
    }.bind(this), 1000);
  }

  toggleVisibility(id) {
    this.channel.push("flip", { id: id })
      .receive("ok", this.gotView.bind(this));
  }

  render() {
    let tile_list = _.map(this.state.tiles, (tile, ii) => {
      return <Tile tile={tile} sendGuess={this.sendGuess.bind(this)} key={ii} />;
	});

  return (
	    <div className="row game-row">
	      { tile_list }
        <ClickCount clicks={this.state.clicks} />
        <Reset reset={this.reset.bind(this)} />
	    </div>
   )
  }
}

function ClickCount(params) {
   return (
    <div className="col-6">
      <p><b>No. of clicks: </b>{params.clicks}</p>
    </div>
  )
}

function Reset(params) {
  return (
    <div className="col-6">
      <button id="reset" onClick={params.reset}>Restart</button>
    </div>
  )
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
	  // <div className="col-3 game-col" onClick={() => params.matchTile(item.id, item.letter)}>
    <div className="col-3 game-col" onClick={() => params.sendGuess(item.id)}>
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
