@AbapCatalog.sqlViewName: 'ZI308747_VSCRE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'enhancement for sc root CDS'
@VDM.viewType: #EXTENSION

define view ze_i308747_sc_root as select from zi308747_d_sc_r as Persistence
{
    key Persistence.db_key,
    Persistence.test_field
}
