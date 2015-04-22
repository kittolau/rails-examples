//d3 array method
  d3.min(json, function(d) { return d.Datetime; }
  d3.max(json, function(d) { return d.Datetime; }
  d3.extent(json, function(d) { return d.Datetime; }
  d3.sum(json, function(d) { return d.Datetime; }
  d3.mean(json, function(d) { return d.Datetime; }
  d3.median(json, function(d) { return d.Datetime; }
  data.sort(d3.descending)

//creating a scaling function with domain range
  //linear
    var y = d3.scale.linear()
      .domain([0, d3.max(json, function(d) { return d.count; })]); //the input domain
      .range([height, 0]) //the output range
  //time
    var x = d3.time.scale()
    .domain(d3.extent(json, function(d) { return d.Datetime; }));
    .range([0, width])
  //category
  ////ten categor
    var color d3.scale.category10();
  //ordinal
    //domain is not continous
    var color d3.scale.ordinal().range["red","blue","orange"];

// Define the axes
  var xAxis = d3.svg.axis().scale(x)
      .orient("bottom").ticks(json.length);

  var yAxis = d3.svg.axis().scale(y)
      .orient("left").ticks(5);

  // Add the X Axis
  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  // Add the Y Axis
  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis);
  }

//d3 svg elememnt generator
  // <path>
    //generate <path with d attribute which is where the data of path is stored
    // Define the line
    var priceline = d3.svg.line()
        .x(function(d) { return x(d.Datetime); })
        .y(function(d) { return y(d.count); });

     svg.append("path")
                .attr("class", "line")
                .style("stroke", function() { // Add the colours dynamically
                    return d.color = color(d.key); })
                .attr("d", priceline(d.values));
  //arc
  //diagonal
  //
//dom data binding
  d3.select("path")
    .data(data)
    .enter() / .exit() /.update()
      .append("")
