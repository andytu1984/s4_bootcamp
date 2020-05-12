@AbapCatalog.sqlViewName: 'ZI308747_VSCITP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction view of shopping cart item'

@ObjectModel.writeActivePersistence: 'ZI308747_D_SC_I'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

define view ZI308747_SC_ITEM_TP as select from ZI308747_SC_ITEM as item
association[1..1] to ZI308747_SC_ROOT_TP as _root on parent_key = _root.db_key
{
   key db_key,
      parent_key,
      cart_id,
      item_id,
      matnr,
      txz01,
      quantity,
      uom,
      netpr,
      waers,
      peinh,
      lifnr,
      @ObjectModel.association.type:[#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _root
}
