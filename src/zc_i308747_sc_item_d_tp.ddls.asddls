@AbapCatalog.sqlViewName: 'ZCI308747_VDSCI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for SC item'

@VDM.viewType: #CONSUMPTION
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.deleteEnabled: true

@ObjectModel.semanticKey: ['cart_id', 'item_id' ]

@UI.headerInfo:{
  typeName: 'Shopping Cart Item',
  typeNamePlural: 'Shopping Cart Items',
  title: { label: 'Items', value: 'scart_items' }
}
@Search.searchable: true
define view ZC_I308747_SC_ITEM_D_TP as select from ZI308747_SC_ITEM_D_TP as item
association[1..1] to ZC_I308747_SC_ROOT_D_TP as _root on item.parent_key = _root.db_key
{

@UI.facet: [
               { label: 'General Information',
                 id: 'GeneralInformation',
                 type: #COLLECTION,
                 purpose: #STANDARD,
                 position: 10
               },
               { label: 'Basic Data',
                 id: 'BasicData',
                 type: #IDENTIFICATION_REFERENCE,
                 parentId: 'GeneralInformation',
                 position: 10
               }]
               
@UI.hidden: true
    key db_key,
      @UI.hidden: true
      parent_key,
      @ObjectModel.readOnly: true
      _root.cart_id,
      @UI.lineItem.position: 20
      @UI.identification.position: 20
      item_id,
      @UI.lineItem.position: 30
      @UI.identification.position: 30
      @Search.defaultSearchElement: true
      matnr,
      @UI.lineItem.position: 40
      @UI.identification.position: 40
      txz01,
      @UI.lineItem.position: 50
      @UI.identification.position: 50
      quantity,
      @UI.lineItem.position: 60
      uom,
      @UI.lineItem.position: 70
      @UI.identification.position: 60
      netpr,
      @UI.lineItem.position: 80
      waers,
      @UI.lineItem.position: 90
      peinh,
      @UI.lineItem.position: 100
      @UI.identification.position: 70
      lifnr,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _root
    
}
