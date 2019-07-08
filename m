Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3FC606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964920651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfGHJgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:36:19 -0400
Received: from foss.arm.com ([217.140.110.172]:43164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbfGHJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:36:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E180E360;
        Mon,  8 Jul 2019 02:36:16 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A99D3F246;
        Mon,  8 Jul 2019 02:36:15 -0700 (PDT)
Subject: Re: [PATCH 2/6] irqchip: Add Realtek RTD129x intc driver
To:     Aleix Roca Nonell <kernelrocks@gmail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707132256.GC13340@arks.localdomain>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <5efa2ccb-9659-443c-7986-8ceb01aa64b9@arm.com>
Date:   Mon, 8 Jul 2019 10:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707132256.GC13340@arks.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2019 14:22, Aleix Roca Nonell wrote:
> This driver adds support for the RTD1296 and RTD1295 interrupt
> controller (intc). It is based on both the BPI-SINOVOIP project and
> Andreas Färber's previous attempt to submit a similar driver.
> 
> There is currently no publicly available datasheet on this SoC and the
> exact behaviour of the registers controlling the intc remain uncertain.
> 
> This driver controls two intcs: "iso" and "misc". Each intc has its own
> Interrupt Enable Register (IER) and Interrupt Status Resgister (ISR).

Register

> However, not all "misc" intc irqs have the same offsets for both ISR and
> IER. For this reason an ISR to IER offsets table is defined.
> 
> The driver catches the IER value to reduce accesses to the table inside the
> interrupt handler. Actually, the driver stores the ISR offsets of currently
> enabled interrupts in a variable.
> 
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>

I expect Andreas and you to sort the attribution issue. I'm certainly
not going to take this in if things are unclear.

> ---
>  drivers/irqchip/Makefile      |   1 +
>  drivers/irqchip/irq-rtd129x.c | 371 ++++++++++++++++++++++++++++++++++
>  2 files changed, 372 insertions(+)
>  create mode 100644 drivers/irqchip/irq-rtd129x.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 606a003a0000..0689c3956250 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -100,3 +100,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
> +obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd129x.o
> diff --git a/drivers/irqchip/irq-rtd129x.c b/drivers/irqchip/irq-rtd129x.c
> new file mode 100644
> index 000000000000..76358ca50f10
> --- /dev/null
> +++ b/drivers/irqchip/irq-rtd129x.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/irqchip.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/irqchip.h>
> +#include <linux/bits.h>
> +#include <linux/irqchip/chained_irq.h>
> +
> +#define RTD129X_INTC_NR_IRQS 32
> +#define DEV_NAME "RTD1296_INTC"
> +
> +/*
> + * This interrupt controller (hereinafter intc) driver controls two intcs: "iso"
> + * and "misc". Each intc has its own Interrupt Enable Register (IER) and
> + * Interrupt Status Resgister (ISR). However, not all "misc" intc irqs have the
> + * same offsets for both ISR and IER. For this reason an ISR to IER offsets
> + * table is defined. Also, to reduce accesses to this table in the interrupt
> + * handler, the driver stores the ISR offsets of currently enabled interrupts in
> + * a variable.
> + */
> +
> +enum misc_int_en {
> +	MISC_INT_FAIL		= 0xFF,
> +	MISC_INT_RVD		= 0xFE,
> +	MISC_INT_EN_FAN		= 29,
> +	MISC_INT_EN_I2C3	= 28,
> +	MISC_INT_EN_GSPI	= 27,
> +	MISC_INT_EN_I2C2	= 26,
> +	MISC_INT_EN_SC0		= 24,
> +	MISC_INT_EN_LSADC1	= 22,
> +	MISC_INT_EN_LSADC0	= 21,
> +	MISC_INT_EN_GPIODA	= 20,
> +	MISC_INT_EN_GPIOA	= 19,
> +	MISC_INT_EN_I2C4	= 15,
> +	MISC_INT_EN_I2C5	= 14,
> +	MISC_INT_EN_RTC_DATA	= 12,
> +	MISC_INT_EN_RTC_HOUR	= 11,
> +	MISC_INT_EN_RTC_MIN	= 10,
> +	MISC_INT_EN_UR2		= 7,
> +	MISC_INT_EN_UR2_TO	= 6,
> +	MISC_INT_EN_UR1_TO	= 5,
> +	MISC_INT_EN_UR1		= 3,
> +};
> +
> +enum iso_int_en {
> +	ISO_INT_FAIL		= 0xFF,
> +	ISO_INT_RVD		= 0xFE,
> +	ISO_INT_EN_I2C1_REQ	= 31,
> +	ISO_INT_EN_GPHY_AV	= 30,
> +	ISO_INT_EN_GPHY_DV	= 29,
> +	ISO_INT_EN_GPIODA	= 20,
> +	ISO_INT_EN_GPIOA	= 19,
> +	ISO_INT_EN_RTC_ALARM	= 13,
> +	ISO_INT_EN_RTC_HSEC	= 12,
> +	ISO_INT_EN_I2C1		= 11,
> +	ISO_INT_EN_I2C0		= 8,
> +	ISO_INT_EN_IRDA		= 5,
> +	ISO_INT_EN_UR0		= 2,
> +};
> +
> +unsigned char rtd129x_intc_enable_map_misc[RTD129X_INTC_NR_IRQS] = {
> +	MISC_INT_FAIL,		/* Bit0 */
> +	MISC_INT_FAIL,		/* Bit1 */
> +	MISC_INT_RVD,		/* Bit2 */
> +	MISC_INT_EN_UR1,	/* Bit3 */
> +	MISC_INT_FAIL,		/* Bit4 */
> +	MISC_INT_EN_UR1_TO,	/* Bit5 */
> +	MISC_INT_RVD,		/* Bit6 */
> +	MISC_INT_RVD,		/* Bit7 */
> +	MISC_INT_EN_UR2,	/* Bit8 */
> +	MISC_INT_RVD,		/* Bit9 */
> +	MISC_INT_EN_RTC_MIN,	/* Bit10 */
> +	MISC_INT_EN_RTC_HOUR,	/* Bit11 */
> +	MISC_INT_EN_RTC_DATA,	/* Bit12 */
> +	MISC_INT_EN_UR2_TO,	/* Bit13 */
> +	MISC_INT_EN_I2C5,	/* Bit14 */
> +	MISC_INT_EN_I2C4,	/* Bit15 */
> +	MISC_INT_FAIL,		/* Bit16 */
> +	MISC_INT_FAIL,		/* Bit17 */
> +	MISC_INT_FAIL,		/* Bit18 */
> +	MISC_INT_EN_GPIOA,	/* Bit19 */
> +	MISC_INT_EN_GPIODA,	/* Bit20 */
> +	MISC_INT_EN_LSADC0,	/* Bit21 */
> +	MISC_INT_EN_LSADC1,	/* Bit22 */
> +	MISC_INT_EN_I2C3,	/* Bit23 */
> +	MISC_INT_EN_SC0,	/* Bit24 */
> +	MISC_INT_FAIL,		/* Bit25 */
> +	MISC_INT_EN_I2C2,	/* Bit26 */
> +	MISC_INT_EN_GSPI,	/* Bit27 */
> +	MISC_INT_FAIL,		/* Bit28 */
> +	MISC_INT_EN_FAN,	/* Bit29 */
> +	MISC_INT_FAIL,		/* Bit30 */
> +	MISC_INT_FAIL		/* Bit31 */
> +};
> +
> +unsigned char rtd129x_intc_enable_map_iso[RTD129X_INTC_NR_IRQS] = {
> +	ISO_INT_FAIL,		/* Bit0 */
> +	ISO_INT_RVD,		/* Bit1 */
> +	ISO_INT_EN_UR0,		/* Bit2 */
> +	ISO_INT_FAIL,		/* Bit3 */
> +	ISO_INT_FAIL,		/* Bit4 */
> +	ISO_INT_EN_IRDA,	/* Bit5 */
> +	ISO_INT_FAIL,		/* Bit6 */
> +	ISO_INT_RVD,		/* Bit7 */
> +	ISO_INT_EN_I2C0,	/* Bit8 */
> +	ISO_INT_RVD,		/* Bit9 */
> +	ISO_INT_FAIL,		/* Bit10 */
> +	ISO_INT_EN_I2C1,	/* Bit11 */
> +	ISO_INT_EN_RTC_HSEC,	/* Bit12 */
> +	ISO_INT_EN_RTC_ALARM,	/* Bit13 */
> +	ISO_INT_FAIL,		/* Bit14 */
> +	ISO_INT_FAIL,		/* Bit15 */
> +	ISO_INT_FAIL,		/* Bit16 */
> +	ISO_INT_FAIL,		/* Bit17 */
> +	ISO_INT_FAIL,		/* Bit18 */
> +	ISO_INT_EN_GPIOA,	/* Bit19 */
> +	ISO_INT_EN_GPIODA,	/* Bit20 */
> +	ISO_INT_RVD,		/* Bit21 */
> +	ISO_INT_RVD,		/* Bit22 */
> +	ISO_INT_RVD,		/* Bit23 */
> +	ISO_INT_RVD,		/* Bit24 */
> +	ISO_INT_FAIL,		/* Bit25 */
> +	ISO_INT_FAIL,		/* Bit26 */
> +	ISO_INT_FAIL,		/* Bit27 */
> +	ISO_INT_FAIL,		/* Bit28 */
> +	ISO_INT_EN_GPHY_DV,	/* Bit29 */
> +	ISO_INT_EN_GPHY_AV,	/* Bit30 */
> +	ISO_INT_EN_I2C1_REQ	/* Bit31 */
> +};
> +
> +struct rtd129x_intc_data {
> +	void __iomem		*unmask;
> +	void __iomem		*isr;
> +	void __iomem		*ier;
> +	u32			ier_cached;
> +	u32			isr_en;
> +	raw_spinlock_t		lock;
> +	unsigned int		parent_irq;
> +	const unsigned char	*en_map;
> +};
> +
> +static struct irq_domain *rtd129x_intc_domain;
> +
> +static void rtd129x_intc_irq_handle(struct irq_desc *desc)
> +{
> +	struct rtd129x_intc_data *priv = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int local_irq;
> +	u32 status;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	raw_spin_lock(&priv->lock);
> +	status = readl_relaxed(priv->isr);
> +	status &= priv->isr_en;
> +	raw_spin_unlock(&priv->lock);

What is this lock protecting? isr_en?

> +
> +	while (status) {
> +		i = __ffs(status);
> +		status &= ~BIT(i);
> +
> +		local_irq = irq_find_mapping(rtd129x_intc_domain, i);
> +		if (likely(local_irq)) {
> +			if (!generic_handle_irq(local_irq))
> +				writel_relaxed(BIT(i), priv->isr);

What are the write semantics of the ISR register? Hot bit clear? How
does it work since mask() does the same thing? Clearly, something is
wrong here.

> +		} else {
> +			handle_bad_irq(desc);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void rtd129x_intc_mask(struct irq_data *data)
> +{
> +	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
> +
> +	writel_relaxed(BIT(data->hwirq), priv->isr);
> +}
> +
> +static void rtd129x_intc_unmask(struct irq_data *data)
> +{
> +	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
> +
> +	writel_relaxed(BIT(data->hwirq), priv->unmask);

What effect does this have on the isr register? The whole mask/unmask
thing seems to be pretty dodgy...

> +}
> +
> +static void rtd129x_intc_enable(struct irq_data *data)
> +{
> +	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u8 en_offset;
> +
> +	en_offset = priv->en_map[data->hwirq];
> +
> +	if ((en_offset != MISC_INT_RVD) && (en_offset != MISC_INT_FAIL)) {
> +		raw_spin_lock_irqsave(&priv->lock, flags);
> +
> +		priv->isr_en |= BIT(data->hwirq);
> +		priv->ier_cached |= BIT(en_offset);
> +		writel_relaxed(priv->ier_cached, priv->ier);
> +
> +		raw_spin_unlock_irqrestore(&priv->lock, flags);
> +	} else if (en_offset == MISC_INT_FAIL) {
> +		pr_err("[%s] Enable irq(%lu) failed\n", DEV_NAME, data->hwirq);
> +	}
> +}
> +
> +static void rtd129x_intc_disable(struct irq_data *data)
> +{
> +	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u8 en_offset;
> +
> +	en_offset = priv->en_map[data->hwirq];
> +
> +	if ((en_offset != MISC_INT_RVD) && (en_offset != MISC_INT_FAIL)) {
> +		raw_spin_lock_irqsave(&priv->lock, flags);
> +
> +		priv->isr_en &= ~BIT(data->hwirq);
> +		priv->ier_cached &= ~BIT(en_offset);
> +		writel_relaxed(priv->ier_cached, priv->ier);
> +
> +		raw_spin_unlock_irqrestore(&priv->lock, flags);
> +	} else if (en_offset == MISC_INT_FAIL) {
> +		pr_err("[%s] Disable irq(%lu) failed\n", DEV_NAME, data->hwirq);
> +	}
> +}

So here's a thought: Why do we need all of this? If mask/unmask do their
job correctly, we could just enable all interrupts in one go (just a
32bit write) at probe time, and leave all interrupts masked until they
are in use. You could then drop all these silly tables that don't bring
much...

> +
> +static struct irq_chip rtd129x_intc_chip = {
> +	.name		= DEV_NAME,
> +	.irq_mask	= rtd129x_intc_mask,
> +	.irq_unmask	= rtd129x_intc_unmask,
> +	.irq_enable	= rtd129x_intc_enable,
> +	.irq_disable	= rtd129x_intc_disable,
> +};
> +
> +static int rtd129x_intc_map(struct irq_domain *d, unsigned int virq,
> +			    irq_hw_number_t hw_irq)
> +{
> +	struct rtd129x_intc_data *priv = d->host_data;
> +
> +	irq_set_chip_and_handler(virq, &rtd129x_intc_chip, handle_level_irq);
> +	irq_set_chip_data(virq, priv);
> +	irq_set_probe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops rtd129x_intc_domain_ops = {
> +	.xlate			= irq_domain_xlate_onecell,
> +	.map			= rtd129x_intc_map,
> +};
> +
> +static const struct of_device_id rtd129x_intc_matches[] = {
> +	{ .compatible = "realtek,rtd129x-intc-misc",
> +		.data = rtd129x_intc_enable_map_misc
> +	},
> +	{ .compatible = "realtek,rtd129x-intc-iso",
> +		.data = rtd129x_intc_enable_map_iso
> +	},
> +	{ }
> +};
> +
> +static int rtd129x_intc_of_init(struct device_node *node,
> +				struct device_node *parent)
> +{
> +	struct rtd129x_intc_data *priv;
> +	const struct of_device_id *match;
> +	u32 isr_tmp, ier_tmp, ier_bit;
> +	int ret, i;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	raw_spin_lock_init(&priv->lock);
> +
> +	priv->isr = of_iomap(node, 0);
> +	if (!priv->isr) {
> +		pr_err("unable to obtain status reg iomap address\n");
> +		ret = -ENOMEM;
> +		goto free_priv;
> +	}
> +
> +	priv->ier = of_iomap(node, 1);
> +	if (!priv->ier) {
> +		pr_err("unable to obtain enable reg iomap address\n");
> +		ret = -ENOMEM;
> +		goto iounmap_status;
> +	}
> +
> +	priv->unmask = of_iomap(node, 2);
> +	if (!priv->unmask) {
> +		pr_err("unable to obtain unmask reg iomap address\n");
> +		ret = -ENOMEM;
> +		goto iounmap_enable;
> +	}
> +
> +	priv->parent_irq = irq_of_parse_and_map(node, 0);
> +	if (!priv->parent_irq) {
> +		pr_err("failed to map parent interrupt %d\n", priv->parent_irq);
> +		ret = -EINVAL;
> +		goto iounmap_all;
> +	}
> +
> +	match = of_match_node(rtd129x_intc_matches, node);
> +	if (!match) {
> +		pr_err("failed to find matching node\n");
> +		ret = -ENODEV;
> +		goto iounmap_all;
> +	}
> +	priv->en_map = match->data;
> +
> +	// initialize enabled irq's map to its matching status bit in isr by
> +	// inverse walking the enable to status offsets map. Only needed for
> +	// misc

Why do we need any of this? The kernel is supposed to start from a clean
slate, not to inherit whatever has been set before, unless there is a
very compelling reason.

> +	priv->ier_cached = readl_relaxed(priv->ier);
> +	if (priv->en_map == rtd129x_intc_enable_map_misc) {
> +		ier_tmp = priv->ier_cached;
> +		isr_tmp = 0;
> +		while (ier_tmp) {
> +			ier_bit = __ffs(ier_tmp);
> +			ier_tmp &= ~BIT(ier_bit);
> +			for (i = 0; i < RTD129X_INTC_NR_IRQS; i++)
> +				if (priv->en_map[i] == ier_bit)
> +					isr_tmp |= BIT(i);
> +		}
> +		priv->isr_en = isr_tmp;
> +	} else {
> +		priv->isr_en = priv->ier_cached;
> +	}
> +
> +	rtd129x_intc_domain = irq_domain_add_linear(node, RTD129X_INTC_NR_IRQS,
> +						    &rtd129x_intc_domain_ops,
> +						    priv);
> +	if (!rtd129x_intc_domain) {
> +		pr_err("failed to create irq domain\n");
> +		ret = -ENOMEM;
> +		goto iounmap_all;
> +	}
> +
> +	irq_set_chained_handler_and_data(priv->parent_irq,
> +					 rtd129x_intc_irq_handle, priv);
> +
> +	return 0;
> +
> +iounmap_all:
> +	iounmap(priv->unmask);
> +iounmap_enable:
> +	iounmap(priv->ier);
> +iounmap_status:
> +	iounmap(priv->isr);
> +free_priv:
> +	kfree(priv);
> +err:
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(rtd129x_intc_misc, "realtek,rtd129x-intc-misc",
> +		rtd129x_intc_of_init);
> +IRQCHIP_DECLARE(rtd129x_intc_iso, "realtek,rtd129x-intc-iso",
> +		rtd129x_intc_of_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
