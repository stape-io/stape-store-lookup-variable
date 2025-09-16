# Stape Store Lookup Variable for Google Tag Manager Server Container

The **Stape Store Lookup Variable** for Google Tag Manager Server-Side allows you to retrieve data from **Stape Store**. You can look up a specific document by its ID or query a collection to find a document that matches certain criteria.

This is useful for retrieving user data, product information, or any other data you've previously stored.

## How to use

1.  Add the **Stape Store Lookup Variable** to your server container from the GTM Template Gallery.
2.  Select a **Lookup Type**:
    - **Document ID**: Provide the unique key of the document you want to retrieve.
    - **Query**: Specify conditions to search for a document. The first match is returned.
3.  (Optional) Provide a **Key Path** (e.g., `user.address.city`) to retrieve a specific nested value from the document. If left empty, the entire document data is returned.
4.  (Optional) Enable **Store the result in cache** to improve performance by caching the response.
5.  (Optional) Specify a **Stape Store Collection Name**. Defaults to `default`.
6.  Use the variable in your tags, triggers, or other variables.

## Useful Resources
- [How to use the Stape Store Lookup variable](https://stape.io/helpdesk/documentation/stape-store-feature#stape-store-lookup-variable)

## Open Source

The **Stape Store Lookup Variable for Google Tag Manager Server Container** is developed and maintained by [Stape Team](https://stape.io/) under the Apache 2.0 license.
