bleno = require('bleno')

prop = {
	"service": "0000180a00001000800000805f9b34fb",
	"characteristic": "00002a2900001000800000805f9b34fb"
}

Descriptor = bleno.Descriptor
desc = new Descriptor({
	uuid: '2901',
	value: 'company02'
})

Characteristic = bleno.Characteristic

chara = new Characteristic({
	uuid: prop.characteristic,
	properties: ["read","Broadcast"]
	value: "ff",
	descriptors: [desc]
})

PrimaryService = bleno.PrimaryService
primaryService = new PrimaryService({
	uuid: prop.service,
	characteristics: [chara]
})

service = [primaryService]


log = (msg) -> 
	console.log(msg)

acceptlog = (msg) ->
	console.log("accept: #{msg}")

disconlog = (msg) ->
	console.log("disconnect: #{msg}")

errorlog = (msg) ->
	console.log("error: #{msg}")



stateChange = (state) ->
	console.log("stateChanged: #{state}")
	if state is 'poweredOn'
		bleno.startAdvertising(prop.name,prop.uuid) 
		log("start")


advStart = (state) ->
	bleno.setServices(service)
	console.log("setServices #{service}")

bleno.on('stateChange',stateChange)
bleno.on('advertisingStartError',errorlog)
bleno.on('accept',acceptlog)
bleno.on('disconnect',disconlog) 
bleno.on('advertisingStart',advStart)
bleno.on('servicesSet',log)
