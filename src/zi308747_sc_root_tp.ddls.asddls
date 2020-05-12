@AbapCatalog.sqlViewName: 'ZI308747_VSCRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction view of shopping cart root'

@ObjectModel.compositionRoot: true
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.writeActivePersistence: 'ZI308747_D_SC_R'
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

define view ZI308747_SC_ROOT_TP as select from ZI308747_SC_ROOT as root
  association[0..*] to ZI308747_SC_ITEM_TP as _item on root.db_key = _item.parent_key
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
}
