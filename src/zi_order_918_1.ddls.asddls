@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for orders'
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define root view entity ZI_ORDER_918_1
  as select from zorder_918 as Orders

  /* Compositions */
  composition [0..*] of ZI_CONT_MAP_918 as _Map

  /* Associations */
  association [1..1] to ZI_CUSTOMER_918 as _Customer on $projection.CustomerId = _Customer.CustomerUUID

{
  key order_uuid                                                    as OrderUUID,
      @Search.defaultSearchElement: true
      id                                                            as Id,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      customer_id                                                   as CustomerId,
      concat_with_space(_Customer.FirstName, _Customer.LastName, 1) as CustomerName,
      description                                                   as Description,
      delivery_date                                                 as DeliveryDate,
      pick_up_date                                                  as PickUpDate,
      status                                                        as Status,

      /*-- Admin data --*/
      @Semantics.user.createdBy: true
      created_by                                                    as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                    as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                               as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                               as LastChangedAt,

      /* Associations & Compositions */
      _Map,
      _Customer
}
