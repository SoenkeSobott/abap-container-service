@EndUserText.label: 'Data model for containers'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define root view entity ZI_CONTAINER_918
  as select from zcontainer_918_1

  /* Associations */
  association [1..1] to ZI_WASTE_TYPE_918 as _Waste on $projection.WasteTypeId = _Waste.Id

{
  key container_uuid     as ContainerUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      waste_type_id      as WasteTypeId,
      _Waste.Name        as WasteType,
      _Waste.Description as Description,
      _Waste.PriceKg     as PriceKG,

      /*-- Admin data --*/
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,

      /* Associations */
      _Waste
}
