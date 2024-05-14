import { Controller } from 'stimulus';
import consumer from '../channels/consumer';

export default class extends Controller {
    static targets = [];

    connect() {
        this.channel = consumer.subscriptions.create(
            { channel: 'OfferingFormChannel', offering_id: this.element.dataset.offeringId },
            {
                received: (data) => {
                    this.element.innerHTML = data.form_partial;
                },
            }
        );
    }

    disconnect() {
        this.channel.unsubscribe();
    }

    addProduct() {
        this.channel.perform('add_product');
    }

    removeProduct() {
        this.channel.perform('remove_product');
    }
}
