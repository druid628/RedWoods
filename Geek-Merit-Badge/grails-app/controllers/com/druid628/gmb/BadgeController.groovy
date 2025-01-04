package com.druid628.gmb

class BadgeController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}
	def image= {
		def badge = Badge.get( params.id )
		byte[] image = badge.image
		response.outputStream << image
	}
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[badgeInstanceList: Badge.list(params), badgeInstanceTotal: Badge.count()]
	}

	def create = {
		def badgeInstance = new Badge()
		badgeInstance.properties = params
		return [badgeInstance: badgeInstance]
	}

	def save = {
		def badgeInstance = new Badge(params)
		if (badgeInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'badge.label', default: 'Badge'), badgeInstance.id])}"
			redirect(action: "show", id: badgeInstance.id)
		}
		else {
			render(view: "create", model: [badgeInstance: badgeInstance])
		}
	}

	def show = {
		def badgeInstance = Badge.get(params.id)
		if (!badgeInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
			redirect(action: "list")
		}
		else {
			[badgeInstance: badgeInstance]
		}
	}

	def edit = {
		def badgeInstance = Badge.get(params.id)
		if (!badgeInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [badgeInstance: badgeInstance]
		}
	}

	def update = {
		def badgeInstance = Badge.get(params.id)
		if (badgeInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (badgeInstance.version > version) {
                    
					badgeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'badge.label', default: 'Badge')] as Object[], "Another user has updated this Badge while you were editing")
					render(view: "edit", model: [badgeInstance: badgeInstance])
					return
				}
			}
			badgeInstance.properties = params
			if (!badgeInstance.hasErrors() && badgeInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'badge.label', default: 'Badge'), badgeInstance.id])}"
				redirect(action: "show", id: badgeInstance.id)
			}
			else {
				render(view: "edit", model: [badgeInstance: badgeInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def badgeInstance = Badge.get(params.id)
		if (badgeInstance) {
			try {
				badgeInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'badge.label', default: 'Badge'), params.id])}"
			redirect(action: "list")
		}
	}
}
