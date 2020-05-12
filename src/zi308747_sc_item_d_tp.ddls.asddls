@AbapCatalog.sqlViewName: 'ZI308747_VDSCITP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transaction view with draft for SC item'

@ObjectModel.writeActivePersistence: 'ZI308747_D_SC_I'
@ObjectModel.writeDraftPersistence: 'ZI308747_D_SC_ID'
@ObjectModel.draftEnabled: true

@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

@ObjectModel.semanticKey:  [ 'cart_id', 'item_id' ]

define view ZI308747_SC_ITEM_D_TP as select from ZI308747_SC_ITEM as item
association[1..1] to ZI308747_SC_ROOT_D_TP as _root on parent_key = _root.db_key
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
