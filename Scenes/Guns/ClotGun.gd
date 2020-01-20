extends Gun

export var amount = 5

remotesync func shoot(id:int, poolIndex:int):
	
	for b in range(amount):
		createBullet(id, poolIndex+b)
		if not b == amount-1:
			$FireDelay.start()
			yield($FireDelay, "timeout")

	pass


