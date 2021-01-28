@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for container mappings'
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define view entity ZI_CONT_MAP_918
  as select from zcont_map_918

  /* Associations */
  association        to parent ZI_ORDER_918_1 as _Order     on $projection.OrderUUID = _Order.OrderUUID
  association [1..1] to ZI_CONTAINER_918      as _Container on $projection.ContainerUUID = _Container.ContainerUUID

{
  key map_uuid               as MapUUID,
      order_uuid             as OrderUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      container_uuid         as ContainerUUID,
      weight_kg              as WeightKG,
      _Container.WasteType   as WasteType,
      _Container.Description as Description,
      _Container.PriceKG     as PriceKG,
      created_by             as CreatedBy,
      created_at             as CreatedAt,
      last_changed_by        as LastChangedBy,
      last_changed_at        as LastChangedAt,

      /* Associations */
      _Container,
      _Order
}
