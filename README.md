# Fabric-RTI-Demo
How to create a [Real Time Intelligence](https://learn.microsoft.com/en-us/fabric/real-time-intelligence/overview) demo with Fabric.

# Context
Real Time intelligence can be used to ingest, process, monitor events from multiple sources such as Plants and Machineries.
The idea is to simulate a set of plants each with multiple machineries 
Each Machinery from all the plants will emit their own KPIs and Errors (if needed). 
In this example an event will represent either a set of Kpis from a machinery or an Error thrown by a machinery.
All the event use Json format.

# How to simulate Kpi and Error
Plants, Machineries, KPIs and Errors can be simulated by using this [PlantSimulator](https://github.com/lucaferrari77/PlantSimulator).

# Proposed Solutions
PlantSimulator can emit simple Json with KPIs only or Json that might represent KPIs or Error.
For the sake of the demo we'll use 2 different approaches, the first for KPIs only and the second for KPIs and Errors

# KPIs only

## Events
This is an example of the Json doc that represent a generic KPI event:

```json
{
  "EventId":"a96e59d2-eb66-499f-919a-96c38e84d16b",
  "PlantId":8,
  "MachineryId":74,
  "Pressure":67,
  "Temperature":883,
  "Speed":4,
  "Torque":84,
  "PowerConsumption":111
}
```

## Fabric components

1. [Fabric SQL Database](https://learn.microsoft.com/en-us/fabric/database/sql/overview)
2. [Fabric EventStream with custom endpoint](https://learn.microsoft.com/en-us/fabric/real-time-intelligence/event-streams/overview?tabs=enhancedcapabilities)
3. [EventHouse](https://learn.microsoft.com/en-us/fabric/real-time-intelligence/eventhouse)
4. [Data Activator](https://learn.microsoft.com/en-us/fabric/real-time-intelligence/data-activator/activator-introduction)
5. [Real-time Dashboard](https://learn.microsoft.com/en-us/fabric/real-time-intelligence/dashboard-real-time-create)

![Fabric-RTI-Demo-Specialized](https://github.com/user-attachments/assets/292f9f78-a0ba-403d-8a44-2e29791885ae)

### Fabric SQL Database







