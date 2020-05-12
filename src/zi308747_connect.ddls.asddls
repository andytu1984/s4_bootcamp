@AbapCatalog.sqlViewName: 'ZI308747_VCNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection'
@UI.headerInfo: { typeName: 'connection', typeNamePlural: 'conns' }
@Search.searchable: true
@ObjectModel.semanticKey: ['AirlineId', 'ConnectionId']
define root view ZI308747_CONNECT as select from /dmo/connection as connection
association[1..1] to ZI308747_CARRID as _carrid on $projection.AirlineId = _carrid.carrid
{
@UI.facet: [{id: 'connection', 
             type: #COLLECTION,
             label: 'Single Connection',
             purpose: #STANDARD,
             position: 10
            },
            {id: 'Basic', 
             type: #IDENTIFICATION_REFERENCE,
             label: 'Basic info',
             purpose: #STANDARD,
             parentId: 'connection',
             position: 10
            },
            {id: 'testfacet',
             type: #URL_REFERENCE,
             label: 'test facet',
             position: 20,
             purpose: #STANDARD
            }
            ]
    @UI.lineItem: [{position: 10, label: 'Airline' }]
    @UI.selectionField: [{position: 10 }]
    @UI.identification: [{position: 10, label: 'Airline' }]
    @EndUserText.label: 'Airline ID'
    @EndUserText.quickInfo: 'Airline ID Number'
    @Consumption.valueHelpDefinition: [{entity:{name: 'ZI308747_CARRID', element: 'carrid'} }]
    @ObjectModel.text.association: '_carrid'
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    key connection.carrier_id as AirlineId, 
    @UI.lineItem: [{position: 20, label: 'Connection No.' }]
    @EndUserText.label: 'Connection Number'
    @UI.selectionField: [{position: 20 }]
    @UI.identification: [{position: 20, label: 'connection no.' }]
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    key connection.connection_id as ConnectionId, 
    @UI.lineItem: [{position: 30, label: 'Departure Airport' }]
    @UI.identification: [{position: 30, label: 'departure' }]
    connection.airport_from_id as DepAirport, 
    @UI.identification: [{position: 40, label: 'destination' }]
    @UI.lineItem: [{position: 40, label: 'Destination Airport' }]
    connection.airport_to_id as DesAirport, 
    @UI:{ lineItem: [{position: 50, label: 'Departure Time' },
                     { type: #FOR_ACTION, dataAction: 'suspend', label: 'Suspend' }],
           identification: [{position: 50, label: 'departure time' }]
        }
    connection.departure_time as DepTime, 
    @UI.lineItem: [{position: 60, label: 'Arrival Time' }]
    @UI.identification: [{position: 60, label: 'arrival time' }]
    connection.arrival_time as ArrTime, 
    @UI.lineItem: [{position: 70, label: 'Distance' }]
    @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
    @UI.identification: [{position: 70, label: 'Distance' }]
    connection.distance as Distance, 
    @UI.lineItem: [{position: 80, label: 'Unit of Distance' }]
    @Semantics.unitOfMeasure: true
    @UI.identification: [{position: 80, label: 'Unit' }]
    connection.distance_unit as DistanceUnit,
  
   @Search.defaultSearchElement: true
   @ObjectModel.association.type: [#TO_COMPOSITION_ROOT,#TO_COMPOSITION_PARENT]
    _carrid //make the association public
}
