Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9869A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfCKKyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:54:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfCKKyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:54:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AAA61688;
        Mon, 11 Mar 2019 03:54:31 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CFCB3F703;
        Mon, 11 Mar 2019 03:54:29 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
To:     Lina Iyer <ilina@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <20190222221850.26939-7-ilina@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <6452d538-5714-7e3a-1537-2dd1c4976653@arm.com>
Date:   Mon, 11 Mar 2019 10:54:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222221850.26939-7-ilina@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2019 22:18, Lina Iyer wrote:
> To allow GPIOs to wakeup the system from suspend or deep idle, the
> wakeup capable GPIOs are setup in hierarchy with interrupts from the
> wakeup-parent irqchip.
> 
> In older SoC's, the TLMM will handover detection to the parent irqchip
> and in newer SoC's, the parent irqchip may also be active as well as the
> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
> duplicate interrupts. To enable both these configurations to exist,
> allow the parent irqchip to dictate the TLMM irqchip's behavior when
> masking/unmasking the interrupt.
> 
> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v4:
> 	- Use of_irq_domain_map() and pass PDC pin to parent irqdomain
> Changes in v3:
> 	- Call parent mask when masking GPIO interrupt
> Changes in v2:
> 	- Fix bug when unmasking PDC interrupt
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 141 ++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index ee8119879c4c..83053b45982e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -27,6 +28,7 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/spinlock.h>
> +#include <linux/soc/qcom/irq.h>
>  #include <linux/reboot.h>
>  #include <linux/pm.h>
>  #include <linux/log2.h>
> @@ -69,6 +71,7 @@ struct msm_pinctrl {
>  
>  	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
>  	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
> +	DECLARE_BITMAP(wakeup_masked_irqs, MAX_NR_GPIO);
>  
>  	const struct msm_pinctrl_soc_data *soc;
>  	void __iomem *regs[MAX_NR_TILES];
> @@ -703,6 +706,13 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>  
>  	g = &pctrl->soc->groups[d->hwirq];
>  
> +	if (d->parent_data)
> +		irq_chip_mask_parent(d);
> +
> +	/* Monitored by parent wakeup controller?*/
> +	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
> +		return;
> +
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = msm_readl_intr_cfg(pctrl, g);
> @@ -747,6 +757,13 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>  
>  	g = &pctrl->soc->groups[d->hwirq];
>  
> +	if (d->parent_data)
> +		irq_chip_unmask_parent(d);
> +
> +	/* Monitored by parent wakeup controller? Keep masked */
> +	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
> +		return;
> +
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = msm_readl_intr_cfg(pctrl, g);
> @@ -767,6 +784,10 @@ static void msm_gpio_irq_ack(struct irq_data *d)
>  	unsigned long flags;
>  	u32 val;
>  
> +	/* Handled by parent wakeup controller? Do nothing */
> +	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
> +		return;
> +
>  	g = &pctrl->soc->groups[d->hwirq];
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
> @@ -794,6 +815,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  
>  	g = &pctrl->soc->groups[d->hwirq];
>  
> +	if (d->parent_data)
> +		irq_chip_set_type_parent(d, type);
> +
> +	/* Monitored by parent wakeup controller? Keep masked */
> +	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
> +		return 0;
> +
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	/*
> @@ -890,6 +918,9 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  
> +	if (d->parent_data)
> +		irq_chip_set_wake_parent(d, on);
> +
>  	return 0;
>  }
>  
> @@ -967,11 +998,87 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>  	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>  }
>  
> +static int msm_gpio_domain_translate(struct irq_domain *d,
> +				     struct irq_fwspec *fwspec,
> +				     unsigned long *hwirq, unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count < 2)
> +			return -EINVAL;
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *arg)
> +{
> +	int ret;
> +	irq_hw_number_t hwirq;
> +	struct gpio_chip *gc = domain->host_data;
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	struct irq_fwspec *fwspec = arg;
> +	struct qcom_irq_fwspec parent = { };
> +	unsigned int type;
> +
> +	ret = msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> +					    &pctrl->irq_chip, gc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!domain->parent)
> +		return 0;
> +
> +	ret = of_irq_domain_map(fwspec, &parent.fwspec);
> +	if (ret)
> +		return ret;
> +
> +	parent.fwspec.fwnode = domain->parent->fwnode;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent);
> +	if (ret)
> +		return ret;
> +
> +	if (parent.mask)
> +		set_bit(hwirq, pctrl->wakeup_masked_irqs);
> +
> +	return 0;
> +}
> +
> +/*
> + * TODO: Get rid of this and push it into gpiochip_to_irq()
> + */
> +static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct irq_fwspec fwspec;
> +
> +	fwspec.fwnode = of_node_to_fwnode(chip->of_node);
> +	fwspec.param[0] = offset;
> +	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
> +	fwspec.param_count = 2;
> +
> +	return irq_create_fwspec_mapping(&fwspec);
> +}
> +
> +static const struct irq_domain_ops msm_gpio_domain_ops = {
> +	.translate = msm_gpio_domain_translate,
> +	.alloc     = msm_gpio_domain_alloc,
> +	.free      = irq_domain_free_irqs_top,
> +};
> +
>  static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  {
>  	struct gpio_chip *chip;
>  	int ret;
>  	unsigned ngpio = pctrl->soc->ngpios;
> +	struct device_node *dn;
>  
>  	if (WARN_ON(ngpio > MAX_NR_GPIO))
>  		return -EINVAL;
> @@ -986,6 +1093,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
>  
>  	pctrl->irq_chip.name = "msmgpio";
> +	pctrl->irq_chip.irq_eoi	= irq_chip_eoi_parent;
>  	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
>  	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
>  	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
> @@ -994,6 +1102,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>  	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>  
> +	chip->irq.chip = &pctrl->irq_chip;
> +	chip->irq.domain_ops = &msm_gpio_domain_ops;
> +	chip->irq.handler = handle_edge_irq;
> +	chip->irq.default_type = IRQ_TYPE_NONE;

I know you're only moving this around, but can you explain why you're
setting IRQ_TYPE_NONE in combination with handle_edge_irq? The two
really should go together. If this doesn't work for some reason, please
document it.

> +
> +	dn = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
> +	if (dn) {
> +		chip->irq.parent_domain = irq_find_matching_host(dn,
> +						 DOMAIN_BUS_WAKEUP);
> +		of_node_put(dn);
> +		if (!chip->irq.parent_domain)
> +			return -EPROBE_DEFER;
> +
> +		chip->to_irq = msm_gpio_to_irq;
> +	}
> +
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Failed register gpiochip\n");
> @@ -1015,26 +1139,17 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  			dev_name(pctrl->dev), 0, 0, chip->ngpio);
>  		if (ret) {
>  			dev_err(pctrl->dev, "Failed to add pin range\n");
> -			gpiochip_remove(&pctrl->chip);
> -			return ret;
> +			goto fail;
>  		}
>  	}
>  
> -	ret = gpiochip_irqchip_add(chip,
> -				   &pctrl->irq_chip,
> -				   0,
> -				   handle_edge_irq,
> -				   IRQ_TYPE_NONE);
> -	if (ret) {
> -		dev_err(pctrl->dev, "Failed to add irqchip to gpiochip\n");
> -		gpiochip_remove(&pctrl->chip);
> -		return -ENOSYS;
> -	}
> -
>  	gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
>  				     msm_gpio_irq_handler);
>  
>  	return 0;
> +fail:
> +	gpiochip_remove(&pctrl->chip);
> +	return ret;
>  }
>  
>  static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
