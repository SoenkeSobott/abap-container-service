@EndUserText.label: 'Projection view for containers'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_CONTAINER_918
  as projection on ZI_CONTAINER_918
{
  key ContainerUUID, 
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_WASTE_TYPE_918', element: 'Id'  } }]
      WasteTypeId,
      WasteType,
      Description,
      PriceKG,

      /*-- Admin data --*/
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt      
}
