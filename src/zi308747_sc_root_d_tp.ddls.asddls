@AbapCatalog.sqlViewName: 'ZI308747_VDSCRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transaction view with draf enable for SC'

@ObjectModel.compositionRoot: true
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.writeActivePersistence: 'ZI308747_D_SC_R'

@ObjectModel.draftEnabled: true
@ObjectModel.writeDraftPersistence: 'ZI308747_D_SC_RD'

@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

@ObjectModel.semanticKey: ['cart_id']


define view ZI308747_SC_ROOT_D_TP as select from ZI308747_SC_ROOT as root
  association[0..*] to ZI308747_SC_ITEM_D_TP as _item on root.db_key = _item.parent_key
 // association[1..1] to ze_i308747_sc_root as _extension on root.db_key = _extension.db_key
  
{
  key db_key,
      cart_id,
      document_type,
      curr_max_itm_no,
      itm_count,
      crea_date_time,
      crea_uname,
      lchg_date_time,
      lchg_uname,
      total_val_net,
      waers,
      @ObjectModel.association.type: #TO_COMPOSITION_CHILD
      _item //make the association public
 //     _extension
}
