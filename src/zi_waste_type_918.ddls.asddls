@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for waste types'
define root view entity ZI_WASTE_TYPE_918
  as select from zwaste_918_1 as Waste
{
  key id              as Id,
      name            as Name,
      description     as Description,
      price_kg        as PriceKg,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
