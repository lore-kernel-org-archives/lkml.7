Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D337214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393040AbfIXSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:11:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730328AbfIXSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:11:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OHqaUA092052;
        Tue, 24 Sep 2019 14:11:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7n2vrt25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 14:11:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OI9keN009051;
        Tue, 24 Sep 2019 18:11:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 2v5bg6xrnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 18:11:00 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OIAxlA53477786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 18:10:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84DB028065;
        Tue, 24 Sep 2019 18:10:59 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65EA28059;
        Tue, 24 Sep 2019 18:10:58 +0000 (GMT)
Received: from [9.80.233.40] (unknown [9.80.233.40])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 Sep 2019 18:10:58 +0000 (GMT)
Subject: Re: [PATCH 2/4] irqchip: Add Aspeed SCU interrupt controller
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, jason@lakedaemon.net, tglx@linutronix.de
References: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
 <1569341672-27632-3-git-send-email-eajames@linux.ibm.com>
 <3e866ea1-ee45-8067-09db-422d6c843fca@kernel.org>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <cc3af988-53a4-b241-a61e-b6bb4f964852@linux.ibm.com>
Date:   Tue, 24 Sep 2019 13:10:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3e866ea1-ee45-8067-09db-422d6c843fca@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/19 11:47 AM, Marc Zyngier wrote:
> Eddie,
>
> On 24/09/2019 17:14, Eddie James wrote:
>> The Aspeed SOCs provide some interrupts through the System Control
>> Unit registers. Add an interrupt controller that provides these
>> interrupts to the system.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   MAINTAINERS                         |   1 +
>>   drivers/irqchip/Makefile            |   2 +-
>>   drivers/irqchip/irq-aspeed-scu-ic.c | 199 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 201 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4a1687b..f3f6c3d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2655,6 +2655,7 @@ M:	Eddie James <eajames@linux.ibm.com>
>>   L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
>> +F:	drivers/irqchip/irq-aspeed-scu-ic.c
>>   F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
>>   
>>   ASPEED VIDEO ENGINE DRIVER
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index cc7c439..fce6b1d 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>>   obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>>   obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>>   obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>> -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>> +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
>>   obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>   obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>>   obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
>> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
>> new file mode 100644
>> index 0000000..a23802d
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
>> @@ -0,0 +1,199 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
>> + * Copyright 2019 IBM Corporation
>> + *
>> + * Eddie James <eajames@linux.ibm.com>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/io.h>
>> +
>> +#define ASPEED_SCU_IC_SHIFT		0
>> +#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
>> +#define ASPEED_SCU_IC_NUM_IRQS		7
>> +#define ASPEED_SCU_IC_STATUS_SHIFT	16
>> +
>> +#define ASPEED_AST2600_SCU_IC0_SHIFT	0
>> +#define ASPEED_AST2600_SCU_IC0_ENABLE	\
>> +	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
>> +#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
>> +
>> +#define ASPEED_AST2600_SCU_IC1_SHIFT	4
>> +#define ASPEED_AST2600_SCU_IC1_ENABLE	\
>> +	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>> +#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
>> +
>> +struct aspeed_scu_ic {
>> +	unsigned long irq_enable;
>> +	unsigned long irq_shift;
>> +	unsigned int num_irqs;
>> +	void __iomem *regs;
>> +	struct irq_domain *irq_domain;
>> +};
>> +
>> +static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>> +{
>> +	unsigned int irq;
>> +	unsigned long bit;
>> +	unsigned long enabled;
>> +	unsigned long max;
>> +	unsigned long status;
>> +	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	status = readl(scu_ic->regs);
> You may want to be easy on the interconnect and turn these readl/writel
> into their relaxed version. This will remove a number of unnecessary
> barriers.


Sure thing.


>
>> +	enabled = status & scu_ic->irq_enable;
>> +	status = (status >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> This masking looks weird. Does it mean that the status register is split
> in half, with the two half serving different purposes? This requires
> some documentation...


That's correct. The top half is the status bits and the bottom half is 
the enable bits. I'll add some comments.


>
>> +
>> +	bit = scu_ic->irq_shift;
>> +	max = scu_ic->num_irqs + bit;
>> +
>> +	for_each_set_bit_from(bit, &status, max) {
>> +		irq = irq_find_mapping(scu_ic->irq_domain,
>> +				       bit - scu_ic->irq_shift);
>> +		generic_handle_irq(irq);
>> +
>> +		writel(enabled | BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
>> +		       scu_ic->regs);
>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void aspeed_scu_ic_irq_mask(struct irq_data *data)
>> +{
>> +	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
>> +	unsigned long bit = BIT(data->hwirq + scu_ic->irq_shift);
>> +	unsigned long reg = readl(scu_ic->regs);
>> +
>> +	writel((reg & ~bit) & scu_ic->irq_enable, scu_ic->regs);
> What if you have another CPU masking or unmasking another interrupt at
> the same time? These RMW operations need to be protected.


Good point, thanks.


>
>> +}
>> +
>> +static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
>> +{
>> +	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
>> +	unsigned long bit = BIT(data->hwirq + scu_ic->irq_shift);
>> +	unsigned long reg = readl(scu_ic->regs);
>> +
>> +	writel((reg | bit) & scu_ic->irq_enable, scu_ic->regs);
>> +}
>> +
>> +struct irq_chip aspeed_scu_ic_chip = {
>> +	.name		= "aspeed-scu-ic",
>> +	.irq_mask	= aspeed_scu_ic_irq_mask,
>> +	.irq_unmask	= aspeed_scu_ic_irq_unmask,
> In an SMP system, you may want to provide an affinity callback returning
> -EINVAL.


OK.


>
>> +};
>> +
>> +static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
>> +			     irq_hw_number_t hwirq)
>> +{
>> +	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, domain->host_data);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops aspeed_scu_ic_domain_ops = {
>> +	.map = aspeed_scu_ic_map,
>> +};
>> +
>> +static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
>> +					struct device_node *node)
>> +{
>> +	int irq;
>> +	int rc = 0;
>> +
>> +	scu_ic->regs = of_iomap(node, 0);
>> +	if (!scu_ic->regs) {
>> +		rc = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +
>> +	irq = irq_of_parse_and_map(node, 0);
>> +	if (irq < 0) {
>> +		rc = irq;
>> +		goto err_iounmap;
>> +	}
>> +
>> +	scu_ic->irq_domain = irq_domain_add_linear(node, scu_ic->num_irqs,
>> +						   &aspeed_scu_ic_domain_ops,
>> +						   scu_ic);
>> +	if (!scu_ic->irq_domain) {
>> +		rc = -ENOMEM;
>> +		goto err_iounmap;
>> +	}
>> +
>> +	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
>> +					 scu_ic);
>> +
>> +	return 0;
>> +
>> +err_iounmap:
>> +	iounmap(scu_ic->regs);
>> +
>> +err_free:
>> +	kfree(scu_ic);
>> +
>> +	return rc;
>> +}
>> +
>> +static int __init aspeed_scu_ic_of_init(struct device_node *node,
>> +					struct device_node *parent)
>> +{
>> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
>> +
>> +	if (!scu_ic)
>> +		return -ENOMEM;
>> +
>> +	scu_ic->irq_enable = ASPEED_SCU_IC_ENABLE;
>> +	scu_ic->irq_shift = ASPEED_SCU_IC_SHIFT;
>> +	scu_ic->num_irqs = ASPEED_SCU_IC_NUM_IRQS;
>> +
>> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
>> +}
>> +
>> +static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
>> +						 struct device_node *parent)
>> +{
>> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
>> +
>> +	if (!scu_ic)
>> +		return -ENOMEM;
>> +
>> +	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC0_ENABLE;
>> +	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC0_SHIFT;
>> +	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC0_NUM_IRQS;
>> +
>> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
>> +}
>> +
>> +static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
>> +						 struct device_node *parent)
>> +{
>> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
>> +
>> +	if (!scu_ic)
>> +		return -ENOMEM;
>> +
>> +	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC1_ENABLE;
>> +	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC1_SHIFT;
>> +	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC1_NUM_IRQS;
>> +
>> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
>> +}
>> +
>> +IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
>> +IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
>> +IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
>> +		aspeed_ast2600_scu_ic0_of_init);
>> +IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
>> +		aspeed_ast2600_scu_ic1_of_init);
>>
> This otherwise looks nice and clean.


Thanks for the quick review!


Eddie


>
> 	M.
