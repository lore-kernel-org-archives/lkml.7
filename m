Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD9C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEUIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:54:23 -0400
Received: from foss.arm.com ([217.140.101.70]:59574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEUIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:54:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB31374;
        Tue, 21 May 2019 01:54:21 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9393F575;
        Tue, 21 May 2019 01:54:19 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] irqchip/irq-csky-mpintc: Add triger type and
 priority
To:     Guo Ren <guoren@kernel.org>, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, Ren Guo <ren_guo@c-sky.com>
References: <1557741339-29331-1-git-send-email-guoren@kernel.org>
 <1557741339-29331-2-git-send-email-guoren@kernel.org>
 <CAJF2gTQSnVKo_sXF8BSYUcKWOkXOkX3z96zCEBfa4iUPjN9UDA@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <1597254b-e356-6402-6e6a-c49bd22148e4@arm.com>
Date:   Tue, 21 May 2019 09:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQSnVKo_sXF8BSYUcKWOkXOkX3z96zCEBfa4iUPjN9UDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 08:22, Guo Ren wrote:
> Hi Marc,
> ping ... Any problem ?

Pinging me twice in four days for a patch posted in the middle of the
merge window is a problem, yes. In general, do not post such patches
during the merge window, unless this is an urgent fix. Everybody is busy
unbreaking the tree.

> 
> Thx
>  Guo Ren
> 
> <guoren@kernel.org> 于2019年5月13日周一 下午5:55写道：
>>
>> From: Guo Ren <ren_guo@c-sky.com>
>>
>> Support 4 triger types:
>>  - IRQ_TYPE_LEVEL_HIGH
>>  - IRQ_TYPE_LEVEL_LOW
>>  - IRQ_TYPE_EDGE_RISING
>>  - IRQ_TYPE_EDGE_FALLING
>>
>> Support 0-255 priority setting for each irq.
>>
>> All of above could be set in DeviceTree file and it still compatible
>> with the old DeviceTree format.
>>
>> Changes for V3:
>>  - Use IRQ_TYPE_LEVEL_HIGH as default instead of IRQ_TYPE_NONE
>>  - Remove unnecessary loop in csky_mpintc_handler
>>
>> Changes for V2:
>>  - Fixup this_cpu_read() preempted problem.
>>  - Optimize the coding style.
>>
>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-csky-mpintc.c | 113 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 106 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
>> index c67c961..5bc0868 100644
>> --- a/drivers/irqchip/irq-csky-mpintc.c
>> +++ b/drivers/irqchip/irq-csky-mpintc.c
>> @@ -17,6 +17,7 @@
>>  #include <asm/reg_ops.h>
>>
>>  static struct irq_domain *root_domain;
>> +
>>  static void __iomem *INTCG_base;
>>  static void __iomem *INTCL_base;
>>
>> @@ -29,11 +30,13 @@ static void __iomem *INTCL_base;
>>
>>  #define INTCG_ICTLR    0x0
>>  #define INTCG_CICFGR   0x100
>> +#define INTCG_CIPRTR   0x200
>>  #define INTCG_CIDSTR   0x1000
>>
>>  #define INTCL_PICTLR   0x0
>> +#define INTCL_CFGR     0x14
>> +#define INTCL_PRTR     0x20
>>  #define INTCL_SIGR     0x60
>> -#define INTCL_HPPIR    0x68
>>  #define INTCL_RDYIR    0x6c
>>  #define INTCL_SENR     0xa0
>>  #define INTCL_CENR     0xa4
>> @@ -41,21 +44,66 @@ static void __iomem *INTCL_base;
>>
>>  static DEFINE_PER_CPU(void __iomem *, intcl_reg);
>>
>> +static unsigned long *__trigger;
>> +static unsigned long *__priority;
>> +
>> +#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_BASE))
>> +
>> +#define TRIG_BYTE_OFFSET(i)    ((((i) * 2) / 32) * 4)
>> +#define TRIG_BIT_OFFSET(i)      (((i) * 2) % 32)
>> +
>> +#define PRI_BYTE_OFFSET(i)     ((((i) * 8) / 32) * 4)
>> +#define PRI_BIT_OFFSET(i)       (((i) * 8) % 32)
>> +
>> +#define TRIG_VAL(trigger, irq) (trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(irq)))
>> +#define TRIG_VAL_MSK(irq)          (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(irq))))
>> +#define PRI_VAL(priority, irq) (priority << PRI_BIT_OFFSET(IRQ_OFFSET(irq)))
>> +#define PRI_VAL_MSK(irq)         (~(0xff << PRI_BIT_OFFSET(IRQ_OFFSET(irq))))
>> +
>> +#define TRIG_BASE(irq) \
>> +       (TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
>> +       (this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CICFGR)))
>> +
>> +#define PRI_BASE(irq) \
>> +       (PRI_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
>> +       (this_cpu_read(intcl_reg) + INTCL_PRTR) : (INTCG_base + INTCG_CIPRTR)))
>> +
>> +static DEFINE_SPINLOCK(setup_lock);
>> +static void setup_trigger_priority(unsigned long irq, unsigned long trigger,
>> +                                  unsigned long priority)
>> +{
>> +       unsigned int tmp;
>> +
>> +       spin_lock(&setup_lock);
>> +
>> +       /* setup trigger */
>> +       tmp = readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
>> +
>> +       writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
>> +
>> +       /* setup priority */
>> +       tmp = readl_relaxed(PRI_BASE(irq)) & PRI_VAL_MSK(irq);
>> +
>> +       writel_relaxed(tmp | PRI_VAL(priority, irq), PRI_BASE(irq));
>> +
>> +       spin_unlock(&setup_lock);
>> +}
>> +
>>  static void csky_mpintc_handler(struct pt_regs *regs)
>>  {
>>         void __iomem *reg_base = this_cpu_read(intcl_reg);
>>
>> -       do {
>> -               handle_domain_irq(root_domain,
>> -                                 readl_relaxed(reg_base + INTCL_RDYIR),
>> -                                 regs);
>> -       } while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
>> +       handle_domain_irq(root_domain,
>> +               readl_relaxed(reg_base + INTCL_RDYIR), regs);

This seems to be an unrelated change.

>>  }
>>
>>  static void csky_mpintc_enable(struct irq_data *d)
>>  {
>>         void __iomem *reg_base = this_cpu_read(intcl_reg);
>>
>> +       setup_trigger_priority(d->hwirq, __trigger[d->hwirq],
>> +                                __priority[d->hwirq]);
>> +
>>         writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
>>  }
>>
>> @@ -73,6 +121,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
>>         writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
>>  }
>>
>> +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +       switch (type & IRQ_TYPE_SENSE_MASK) {
>> +       case IRQ_TYPE_LEVEL_HIGH:
>> +               __trigger[d->hwirq] = 0;
>> +               break;
>> +       case IRQ_TYPE_LEVEL_LOW:
>> +               __trigger[d->hwirq] = 1;
>> +               break;
>> +       case IRQ_TYPE_EDGE_RISING:
>> +               __trigger[d->hwirq] = 2;
>> +               break;
>> +       case IRQ_TYPE_EDGE_FALLING:
>> +               __trigger[d->hwirq] = 3;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  #ifdef CONFIG_SMP
>>  static int csky_irq_set_affinity(struct irq_data *d,
>>                                  const struct cpumask *mask_val,
>> @@ -105,6 +175,7 @@ static struct irq_chip csky_irq_chip = {
>>         .irq_eoi        = csky_mpintc_eoi,
>>         .irq_enable     = csky_mpintc_enable,
>>         .irq_disable    = csky_mpintc_disable,
>> +       .irq_set_type   = csky_mpintc_set_type,
>>  #ifdef CONFIG_SMP
>>         .irq_set_affinity = csky_irq_set_affinity,
>>  #endif
>> @@ -125,9 +196,29 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
>>         return 0;
>>  }
>>
>> +static int csky_irq_domain_xlate_cells(struct irq_domain *d,
>> +               struct device_node *ctrlr, const u32 *intspec,
>> +               unsigned int intsize, unsigned long *out_hwirq,
>> +               unsigned int *out_type)
>> +{
>> +       if (WARN_ON(intsize < 1))
>> +               return -EINVAL;
>> +
>> +       *out_hwirq = intspec[0];
>> +       if (intsize > 1)
>> +               *out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
>> +       else
>> +               *out_type = IRQ_TYPE_LEVEL_HIGH;
>> +
>> +       if (intsize > 2)
>> +               __priority[*out_hwirq] = intspec[2];

You keep doing this, and I keep objecting to it. Linux doesn't support
interrupt priorities, and yet you keep bringing them back. Why don't you
simply ignore that field and stick all priorities to some arbitrary value?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
