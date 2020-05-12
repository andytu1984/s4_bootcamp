@AbapCatalog.sqlViewName: 'ZI308747_VSCR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Shopping cart root CDS'
//@OData.publish: true

define view ZI308747_SC_ROOT as select from zi308747_d_sc_r as root
association[0..*] to ZI308747_SC_ITEM as _item on root.db_key = _item.parent_key
 {
   key db_key,
       cart_id,
       document_type,
       curr_max_itm_no,
        itm_count,
     @Semantics.systemDateTime.createdAt: true  
     @EndUserText.label: 'Create At'
       crea_date_time,
     @Semantics.user.createdBy: true
     @EndUserText.label: 'Create By'
       crea_uname,
     @Semantics.systemDateTime.lastChangedAt: true
     @EndUserText.label: 'Last Change At'
       lchg_date_time,
     @Semantics.user.lastChangedBy: true
     @EndUserText.label: 'Last Change By'
       lchg_uname,
     @Semantics.amount.currencyCode: 'WAERS'
       total_val_net,
     @ObjectModel.mandatory: true
       waers,
     @ObjectModel.association.type: #TO_COMPOSITION_CHILD
       _item //make the association public
}
