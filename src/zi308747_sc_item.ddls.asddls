@AbapCatalog.sqlViewName: 'ZI308747_VSCI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Shopping cart item CDS'
define view ZI308747_SC_ITEM as select from zi308747_d_sc_i as item
association [1..1] to ZI308747_SC_ROOT  as _root on item.parent_key = _root.db_key
{
    key db_key,
  @ObjectModel.foreignKey.association: '_root'
      parent_key,
      cart_id,
      item_id,
      matnr,
    @EndUserText.label: 'Description'
      txz01,
    @Semantics.quantity.unitOfMeasure: 'uom'
    @EndUserText.label: 'Quantity'
      quantity,
      uom,
    @Semantics.amount.currencyCode: 'waers'
      netpr,
      waers,
      peinh,
      lifnr,
    @ObjectModel.association.type:[ #TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT ]
      _root // Make association public
}
