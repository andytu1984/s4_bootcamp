@AbapCatalog.sqlViewName: 'ZCI308747_VSCRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption view for SC root'

@VDM.viewType: #CONSUMPTION
@ObjectModel.transactionalProcessingDelegated: true
@ObjectModel.compositionRoot: true
@ObjectModel.updateEnabled: true
@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: true
@UI.headerInfo: {typeName: 'Shopping Cart' , 
                 typeNamePlural: 'Shopping Carts', 
                 title:{ label: 'SCART', value: 'Shopping cart'} }

@OData.publish: true
                 
define view ZC_I308747_SC_ROOT_TP as select from ZI308747_SC_ROOT_TP as root
association [0..*] to ZC_I308747_SC_ITEM_TP as _item on root.db_key = _item.parent_key
 {
 @UI.facet: [
       { label: 'General Information',
         id: 'GeneralInformation',
         type: #COLLECTION,
         position: 10
       },
       {
         label: 'Basic Data',
         id: 'BasicData',
         parentId: 'GeneralInformation',
         type: #IDENTIFICATION_REFERENCE,
         position: 10
       },
       {
         label: 'Items',
         id: 'Items',
         type: #LINEITEM_REFERENCE,
         position: 20,
         targetElement: '_item'
       } ]
   
   @UI.hidden: true 
   key db_key,
      @UI.identification.position: 10
       @UI.selectionField.position: 10
       @UI.lineItem.position: 10
       cart_id,
       @UI.identification.position: 20
      // @UI.selectionField.position: 30
       @UI.lineItem.position: 20
       document_type,
       @UI.identification.position: 30
       @UI.lineItem.position: 30
       curr_max_itm_no,
       @ObjectModel.readOnly: true
       @UI.identification.position: 40
       @UI.lineItem.position: 40
       itm_count,
       @ObjectModel.readOnly: true
       @UI.identification.position: 50
       @UI.lineItem.position: 50
       crea_date_time,
       @ObjectModel.readOnly: true
       @UI.identification.position: 60
       @UI.lineItem.position: 60
       crea_uname,
       @ObjectModel.readOnly: true
       @UI.identification.position: 70
       @UI.lineItem.position: 70
       lchg_date_time,
       @ObjectModel.readOnly: true
       @UI.identification.position: 80
       @UI.lineItem.position: 80
       lchg_uname,
       @ObjectModel.readOnly: true
       @UI.lineItem.position: 90
       @UI.identification.position: 90
       total_val_net,
       //@UI.identification.position: 100
       //@UI.lineItem.position: 100
       waers,
      
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _item //make association public
}
