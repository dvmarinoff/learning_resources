//
// 02. Desinging Classes with Single Responsibiliy
//

// Gear v1
function Gear (spec) {
    let chainring = _ => spec.chainring;
    let cog = _ => spec.cog;
    let ratio = _ => chainring() / cog();
    return { ratio: ratio };
}

Gear({chainring: 48, cog: 11}).ratio();
Gear({chainring: 34, cog: 28}).ratio();

// Gear v2
function Wheel (spec) {
    let rim = _ => spec.rim;
    let tire = _ => spec.tire;
    let diameter = _ => rim() + (tire() * 2);
    let cicumference = _ => Math.PI * diameter();
    return { diameter: diameter, cicumference: cicumference };
}

function Gear (spec) {
    let chainring = _ => spec.chainring;
    let cog = _ => spec.cog;
    let ratio = _ => chainring() / cog();
    let gearInches = _ => ratio() * spec.wheel.diameter();
    return { ratio: ratio, gearInches: gearInches };
}

var w1 = Wheel({rim: 28, tire: 38});
Gear({chainring: 48, cog: 11, wheel: w1}).gearInches();
Gear({chainring: 34, cog: 28, wheel: w1}).gearInches();

//
// 3. Managing Dependancies
//

// Gear v3
// Case of Isolating Dependency and Default Values
function Gear(spec) {
    let chainring = _ => spec.chainring || 48;
    let cog = _ => spec.cog || 11;
    let wheel = spec.wheel;

    let ratio = _ => chainring() / cog();
    let gearInches = _ => ratio() * wheel.diameter();
}

// Case of external Framework Dependency and Factories
var SomeFramework = (function () {
    function Gear(chainring, cog, wheel) {
        let self = this;
        self.chainring = chainring;
        self.cog = cog;
        self.wheel = wheel;
    }
    Gear.prototype.ratio = function () {
        return this.chainring / this.cog;
    };
    Gear.prototype.gear_inches = function () {
        return this.ratio() * this.wheel.diameter();
    };
    return { Gear: Gear };
}());

function GearWrapper (spec) {
    return new SomeFramework.Gear(spec.chainring, spec.cog, spec.wheel);
}

GearWrapper({chainring: 48, cog: 11, wheel: w1}).gear_inches();

//
// 4.
//

// Attempt 1 (HtDP approach):

// Customer ({ Number, Number })
// Customer({ technical, aerobic })
function Customer (spec) {
    let technical = _ => spec.technical || 0;
    let aerobic = _ => spec.aerobic || 0;
    return { technical: technical,
             aerobic: aerobic };
}

// Trip({ String, Number, Number })
// Trip({ terrain, technical, aerobic })
function Trip (spec) {
    let terrain = _ => spec.terrain || "unknown";
    let technical = _ => spec.technical || 0;
    let aerobic = _ => spec.aerobic || 0;
    return { terrain: terrain,
             technical: technical,
             aerobic: aerobic };
}

// Bike({ String, Number })
// Bike({ type, size })
Bike({type: "mtb", size: 56});
Bike({type: "road", size: 54});
function Bike (spec) {
    let type = _ => spec.type;
    let size = _ => spec.size;
    return { type: type,
             size: size };
}

// A List-of-Bikes is one of:
// - []
// - List-of-Bikes.push(Bike)
//
// []
// [Bike({type: "mtb", size: 54})]
// [Bike({type: "mtb", size: 54}),
//  Bike({type: "road", size: 56}),
//  Bike({type: "road", size: 54})]

// Mechanic({  })

// A List-of-Trips is on of:
// - []
// - List-of-trips.push(Trip)
//
// []
// [Trip({terrain: "Mountain", technical: 4, aerobic: 1})]
// [Trip({terrain: "Mountain", technical: 4, aerobic: 1}),
//  Trip({terrain: "Road", technical: 1, aerobic: 3}),
//  Trip({terrain: "Road", technical: 1, aerobic: 5})]

var Moe = Customer({aerobic: 3, technical: 4});
// suitable_trip :: List-of-trips, Customer -> List-of-trips
suitable_trip([], Moe);
suitable_trip([Trip({terrain: "mountain", technical: 4, aerobic: 1})], Moe);
suitable_trip([Trip({terrain: "mountain", technical: 4, aerobic: 1}),
               Trip({terrain: "road", technical: 1, aerobic: 3}),
               Trip({terrain: "road", technical: 1, aerobic: 5})], Moe);

function suitable_trip (lot, customer) {
    return lot.filter( trip => (trip.aerobic()   <= customer.aerobic() &&
                                trip.technical() <= customer.technical()));
}

// suitable_bike :: List-of-Bikes Trip -> List-of-Bikes
var mtb_trip = Trip({terrain: "mountain", technical: 4, aerobic: 1});
var road_trip = Trip({terrain: "road", technical: 4, aerobic: 1});
suitable_bike([], mtb_trip);
suitable_bike([Bike({type: "mtb", size: 54})], mtb_trip);
suitable_bike([Bike({type: "mtb", size: 54}),
               Bike({type: "road", size: 56}),
               Bike({type: "road", size: 54})], road_trip);

function suitable_bike(lob, trip) {
    return lob.filter(function (bike) {
        if(trip.terrain() === "mountain" && bike.type() === "mtb") { return true; }
        else if(trip.terrain() === "road" && bike.type() === "road") { return true; }
        else { return false; };
    });
}

// Attempt 2 (oop):
function Customer (spec) {
    let technical = _ => spec.technical || 0;
    let aerobic = _ => spec.aerobic || 0;
    return { technical: technical, aerobic: aerobic };
}
function Trip (spec) {
    let terrain = _ => spec.terrain || "unknown";
    let technical = _ => spec.technical || 0;
    let aerobic = _ => spec.aerobic || 0;
    let bikes = () => {};
    return { terrain: terrain,
             technical: technical,
             aerobic: aerobic,
             bikes: bikes };
}
function TripFinder (spec) {
    let suitable_trip = () => { return {}; };
    return { suitable_trip: suitable_trip };
}
function Bike (spec) {
    let type = _ => spec.type;
    let size = _ => spec.size;

    let suitable_bike = (trip) => { return {};};
    return { type: type, size: size };
}
function Mechanic (spec) {
    let clean_bike = (bike) => { return bike; };
    let pump_tires = (bike) => { return bike; };
    let lube_chain = (bike) => { return bike; };
    let check_brakes = (bike) => { return bike; };

    let prepare_trip = trip => { return trip; };
    let prepare_bike = bike => {
        return check_brakes(lube_chain(pump_tires(clean_bike(bike))));
    };
    let prepare_bikes = lob => { return lob.map(prepare_bike); };
    return { prepare_trip: prepare_trip,
             prepare_bike: prepare_bike };
}
// suitable_trip :: List-of-trips, Customer -> List-of-trips
// suitable_bike :: List-of-Bikes Trip -> List-of-Bikes


//
// 5. Reducing Costs With Duck Typing
//

function Trip(spec) {
    let bikes = () => { return []; };
    let customers = () => { return []; };
    let vehicles = () => { return []; };

    let prepare_trip = () => {
        spec.mechanic.prepare_trip(self);
        spec.trip_coordinator.prepare_trip(customers());
        spec.driver.prepare_trip(vehicles());
    };

    return { prepare_trip: prepare_trip,
             bikes: bikes,
             customers: customers,
             vehicles: vehicles };
}

function Mechanic(spec) {
    let prepare_trip = (trip) => prepare_bikes(trip.bikes);

    let prepare_bikes = (bikes) => bikes.map(prepare_bike);
    let prepare_bike = (bike) => index_gears(pump_tires(bike));
    let pump_tires = (bike) => { return bike; };
    let index_gears = (bike) => { return bike; };

    return { prepare_trip: prepare_trip };
}

function Trip_Coordinator(spec) {
    let prepare_trip = (customers) => prepare_customers(customers);

    let prepare_customers = (customers) => {return customers; };
    return { prepare_trip: prepare_trip };
}

function Driver(spec) {
    let prepare_trip = (vehicles) => prepare_vehicles(vehicles);

    let prepare_vehicles = (vehicles) => fill_water_tank(gas_up(vehicles));
    let gas_up = (vehicle) => { return vehicle; };
    let fill_water_tank = (vehicle) => { return vehicle; };

    return { prepare_trip: prepare_trip };
}



//
//  6. Aquiring Behavior Through Inheritance
//
function Bike(spec) {
}

function RoadBike(spec) {
}

function MTB(spec) {
}




