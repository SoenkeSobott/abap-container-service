@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for container mappings'
@Metadata.allowExtensions: true
define view entity ZC_CONT_MAP_918
  as projection on ZI_CONT_MAP_918
{
  key MapUUID,
      OrderUUID,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZC_CONTAINER_918', element: 'ContainerUUID'  } }]
      ContainerUUID,
      WeightKG,
      WasteType,
      
      /*-- Admin data --*/
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      
      _Order : redirected to parent ZC_ORDER_918_1
            
}
