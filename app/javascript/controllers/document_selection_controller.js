import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateCount()
  }

  updateCount() {
    const checkedBoxes = this.element.querySelectorAll('input[name="document_ids[]"]:checked')
    const countElement = document.getElementById('document-selected-count')
    
    if (countElement) {
      const baseCount = parseInt(countElement.dataset.baseCount || countElement.textContent)
      const additionalCount = checkedBoxes.length
      countElement.textContent = baseCount + additionalCount
    }
  }
}
