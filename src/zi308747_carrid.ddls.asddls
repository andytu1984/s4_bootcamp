@AbapCatalog.sqlViewName: 'ZI308747_VCARID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Carrier ID'
@Search.searchable: true
define view ZI308747_CARRID as select from /dmo/carrier {
    ///dmo/carrier 
    key carrier_id as carrid, 
    @Semantics.text: true
    name, 
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    currency_code
}
