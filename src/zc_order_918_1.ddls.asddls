@EndUserText.label: 'Projection view for orders'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['OrderUUID']
define root view entity ZC_ORDER_918_1
  as projection on ZI_ORDER_918_1
{
  key OrderUUID,
      Id,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_CUSTOMER_918', element: 'CustomerUUID'  } }]
      CustomerId,
      CustomerName,
      Description,
      DeliveryDate,
      PickUpDate,
      Status, // Open, On-Site, Closed

      /*-- Admin data --*/
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,
      
      _Map : redirected to composition child ZC_CONT_MAP_918
            
      
}
