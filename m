Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852B920715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Fk7iUiCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKVPZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:25:29 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:58543 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfKVPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:25:29 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 732532304F;
        Fri, 22 Nov 2019 16:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574436325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAITS8urrbG7nx+Ks3NZHTfTeocnsWnrB//FdeHPAHo=;
        b=Fk7iUiCJahsnOL9TThBQtcWyP9MsJnk34PKz5nReaRnyQ7o0BDnVmWToYvOVlffb/v5BUE
        zbMatu5X4Qu66BJQuhkpa38qxpwmp+4Y5uelf0qpTiffZzEnlHl/QEhghDZGGmDUui2XQN
        LAbrRsX69nKNOWeVb4BoBtWXN2qiLlg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 22 Nov 2019 16:25:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Wen He <wen.he_1@nxp.com>
Cc:     devicetree@vger.kernel.org, Leo Li <leoyang.li@nxp.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@kernel.org
Subject: Re: [EXT] Re: [v9 2/2] clk: ls1028a: Add clock driver for Display
 output interface
In-Reply-To: <DB7PR04MB5195DE21552AE64DBA59CCFFE24E0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191119080747.35250-2-wen.he_1@nxp.com>
 <b300cc0f4d8a2c5650abc847d76bc380@walle.cc>
 <DB7PR04MB5195DE21552AE64DBA59CCFFE24E0@DB7PR04MB5195.eurprd04.prod.outlook.com>
Message-ID: <899466e7f4f24b45c2765d55f854fbc4@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 732532304F
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM(-0.00)[-0.936];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2019-11-21 17:04, schrieb Wen He:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: 2019年11月20日 22:36
>> To: Wen He <wen.he_1@nxp.com>
>> Cc: devicetree@vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
>> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org;
>> mark.rutland@arm.com; mturquette@baylibre.com; robh+dt@kernel.org;
>> sboyd@kernel.org
>> Subject: [EXT] Re: [v9 2/2] clk: ls1028a: Add clock driver for Display 
>> output
>> interface
>> 
>> 
>> Hi,
> 
> Hi Michael,
> 
>> 
>> > Add clock driver for QorIQ LS1028A Display output interfaces(LCD,
>> > DPHY), as implemented in TSMC CLN28HPM PLL, this PLL supports the
>> > programmable integer division and range of the display output pixel
>> > clock's 27-594MHz.
>> >
>> > Signed-off-by: Wen He <wen.he_1@nxp.com>
>> > ---
>> > change in v9:
>> >       - Use the fixed mfd in plldig_set_rate
>> >
>> >  drivers/clk/Kconfig      |  10 ++
>> >  drivers/clk/Makefile     |   1 +
>> >  drivers/clk/clk-plldig.c | 297
>> > +++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 308 insertions(+)
>> >  create mode 100644 drivers/clk/clk-plldig.c
>> >
>> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
>> > 0530bebfc25a..9f6b0196c604 100644
>> > --- a/drivers/clk/Kconfig
>> > +++ b/drivers/clk/Kconfig
>> > @@ -218,6 +218,16 @@ config CLK_QORIQ
>> >         This adds the clock driver support for Freescale QorIQ platforms
>> >         using common clock framework.
>> >
>> > +config CLK_LS1028A_PLLDIG
>> > +        tristate "Clock driver for LS1028A Display output"
>> > +        depends on ARCH_LAYERSCAPE || COMPILE_TEST
>> > +        default ARCH_LAYERSCAPE
>> > +        help
>> > +          This driver support the Display output interfaces(LCD,
>> > +DPHY)
>> > pixel clocks
>> > +          of the QorIQ Layerscape LS1028A, as implemented TSMC
>> > CLN28HPM PLL. Not all
>> > +          features of the PLL are currently supported by the driver.
>> > By default,
>> > +          configured bypass mode with this PLL.
>> > +
>> >  config COMMON_CLK_XGENE
>> >       bool "Clock driver for APM XGene SoC"
>> >       default ARCH_XGENE
>> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
>> > 0138fb14e6f8..97d1e5bc6de5 100644
>> > --- a/drivers/clk/Makefile
>> > +++ b/drivers/clk/Makefile
>> > @@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_NPCM7XX)          +=
>> clk-npcm7xx.o
>> >  obj-$(CONFIG_ARCH_NSPIRE)            += clk-nspire.o
>> >  obj-$(CONFIG_COMMON_CLK_OXNAS)               += clk-oxnas.o
>> >  obj-$(CONFIG_COMMON_CLK_PALMAS)              += clk-palmas.o
>> > +obj-$(CONFIG_CLK_LS1028A_PLLDIG)     += clk-plldig.o
>> >  obj-$(CONFIG_COMMON_CLK_PWM)         += clk-pwm.o
>> >  obj-$(CONFIG_CLK_QORIQ)                      += clk-qoriq.o
>> >  obj-$(CONFIG_COMMON_CLK_RK808)               += clk-rk808.o
>> > diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c new
>> > file mode 100644 index 000000000000..f940a9d3d011
>> > --- /dev/null
>> > +++ b/drivers/clk/clk-plldig.c
>> > @@ -0,0 +1,297 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Copyright 2019 NXP
>> > + *
>> > + * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
>> > + */
>> > +
>> > +#include <linux/clk-provider.h>
>> > +#include <linux/device.h>
>> > +#include <linux/module.h>
>> > +#include <linux/err.h>
>> > +#include <linux/io.h>
>> > +#include <linux/iopoll.h>
>> > +#include <linux/of.h>
>> > +#include <linux/of_address.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/bitfield.h>
>> > +
>> > +/* PLLDIG register offsets and bit masks */
>> > +#define PLLDIG_REG_PLLSR            0x24
>> > +#define PLLDIG_REG_PLLDV            0x28
>> > +#define PLLDIG_REG_PLLFM            0x2c
>> > +#define PLLDIG_REG_PLLFD            0x30
>> > +#define PLLDIG_REG_PLLCAL1          0x38
>> > +#define PLLDIG_REG_PLLCAL2          0x3c
>> > +#define PLLDIG_LOCK_MASK            BIT(2)
>> > +#define PLLDIG_REG_FIELD_SSCGBYP    BIT(30)
>> > +#define PLLDIG_REG_FIELD_FDEN       BIT(30)
>> > +#define PLLDIG_REG_FIELD_DTHDIS     GENMASK(17, 16)
>> > +#define PLLDIG_REG_FIELD_MULT       GENMASK(7, 0)
>> > +#define PLLDIG_REG_FIELD_RFDPHI1    GENMASK(30, 25)
>> > +
>> > +/* Minimum output clock frequency, in Hz */ #define PHI1_MIN_FREQ
>> > +27000000
>> > +
>> > +/* Maximum output clock frequency, in Hz */ #define PHI1_MAX_FREQ
>> > +600000000
>> > +
>> > +/* Maximum of the divider */
>> > +#define MAX_RFDPHI1          63
>> > +
>> > +/*
>> > + * Clock configuration relationship between the PHI1
>> > frequency(fpll_phi) and
>> > + * the output frequency of the PLL is determined by the PLLDV,
>> > according to
>> > + * the following equation:
>> > + * fpll_phi = (pll_ref * mfd) / div_rfdphi1  */ struct
>> > +plldig_phi1_param {
>> > +     unsigned long rate;
>> > +     unsigned int rfdphi1;
>> > +     unsigned int mfd;
>> > +};
>> > +
>> > +static const struct clk_parent_data parent_data[] = {
>> > +     {.index = 0},
>> > +};
>> > +
>> > +struct clk_plldig {
>> > +     struct clk_hw hw;
>> > +     void __iomem *regs;
>> > +     unsigned int mfd;
>> > +};
>> > +
>> > +#define to_clk_plldig(_hw)   container_of(_hw, struct clk_plldig, hw)
>> > +
>> > +static int plldig_enable(struct clk_hw *hw) {
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +     u32 val;
>> > +
>> > +     val = readl(data->regs + PLLDIG_REG_PLLFM);
>> > +     /*
>> > +      * Use Bypass mode with PLL off by default, the frequency overshoot
>> > +      * detector output was disable. SSCG Bypass mode should be enable.
>> > +      */
>> > +     val |= PLLDIG_REG_FIELD_SSCGBYP;
>> > +     writel(val, data->regs + PLLDIG_REG_PLLFM);
>> > +
>> > +     val = readl(data->regs + PLLDIG_REG_PLLFD);
>> > +     /* Disable dither and Sigma delta modulation in bypass mode */
>> > +     val |= FIELD_PREP(PLLDIG_REG_FIELD_FDEN, 0x1) |
>> 
>> Unlike mentioned in the documentation, FDEN is "fractional divider 
>> enable".
>> 
>> 
> 
> Yes, this point just confirmed in yesterday.
> 
>> 
>> > +            FIELD_PREP(PLLDIG_REG_FIELD_DTHDIS, 0x3);
>> > +
>> > +     writel(val, data->regs + PLLDIG_REG_PLLFD);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static void plldig_disable(struct clk_hw *hw) {
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +     u32 val;
>> > +
>> > +     val = readl(data->regs + PLLDIG_REG_PLLFM);
>> > +
>> > +     val &= ~PLLDIG_REG_FIELD_SSCGBYP;
>> > +     val |= FIELD_PREP(PLLDIG_REG_FIELD_SSCGBYP, 0x0);
>> > +
>> > +     writel(val, data->regs + PLLDIG_REG_PLLFM); }
>> > +
>> > +static int plldig_is_enabled(struct clk_hw *hw) {
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +
>> > +     return (readl(data->regs + PLLDIG_REG_PLLFM) &
>> > +                           PLLDIG_REG_FIELD_SSCGBYP); }
>> > +
>> > +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
>> > +             unsigned long parent_rate) {
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +     u32 mult, div, val;
>> > +
>> > +     val = readl(data->regs + PLLDIG_REG_PLLDV);
>> > +
>> > +     /* Check if PLL is bypassed */
>> > +     if (val & PLLDIG_REG_FIELD_SSCGBYP)
>> > +             return parent_rate;
>> > +
>> > +     /* Checkout multiplication factor divider value */
>> > +     mult = FIELD_GET(PLLDIG_REG_FIELD_MULT, val);
>> > +
>> > +     /* Checkout divider value of the output frequency */
>> > +     div = FIELD_GET(PLLDIG_REG_FIELD_RFDPHI1, val);
>> > +
>> > +     return (parent_rate * mult) / div; }
>> > +
>> > +static int plldig_calc_target_rate(unsigned long target_rate,
>> > +                                unsigned long parent_rate,
>> > +                                struct plldig_phi1_param *phi1) {
>> > +     unsigned int div, ret;
>> > +     unsigned long round_rate;
>> > +
>> > +     /* Range limitation of the request target rate */
>> > +     if (target_rate > PHI1_MAX_FREQ)
>> > +             target_rate = PHI1_MAX_FREQ;
>> > +     else if (target_rate < PHI1_MIN_FREQ)
>> > +             target_rate = PHI1_MIN_FREQ;
>> > +
>> > +     /*
>> > +      * Firstly, check the request target rate whether is divisible
>> > +      * by the best VCO frequency.
>> > +      */
>> > +     round_rate = parent_rate * phi1->mfd;
>> > +     div = round_rate / target_rate;
>> Can't you use DIV_ROUND_UP(), DIV_ROUND_DOWN_ULL() or
>> DIV_ROUND_CLOSEST_ULL() and drop the stuff below except the range 
>> check?
>> 
> 
> Great advice.
> 
>> 
>> > +     if (!div || div > MAX_RFDPHI1)
>> > +             return -EINVAL;
>> > +
>> > +     ret = round_rate % target_rate;
>> > +     if (ret) {
>> > +             /*
>> > +              * Rounded down the request target rate, VESA specifies
>> > +              * 0.5% pixel clock tolerance, therefore this algorithm
>> > +              * can able to compatible a lot of request rates within
>> > +              * range of the tolerance.
>> > +              */
>> > +             round_rate += (target_rate / 2);
>> > +             div = round_rate / target_rate;
>> > +             if (!div || div > MAX_RFDPHI1)
>> > +                     return -EINVAL;
>> > +     }
>> > +
>> > +     phi1->rfdphi1 = div;
>> > +     phi1->rate = target_rate;
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int plldig_determine_rate(struct clk_hw *hw,
>> > +                              struct clk_rate_request *req) {
>> > +     int ret;
>> > +     unsigned long parent_rate;
>> > +     struct clk_hw *parent;
>> > +     struct plldig_phi1_param phi1_param;
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +
>> > +     if (!req->rate)
>> > +             return -ERANGE;
>> > +
>> > +     phi1_param.mfd = data->mfd;
>> > +     parent = clk_hw_get_parent(hw);
>> > +     parent_rate = clk_hw_get_rate(parent);
>> > +
>> > +     ret = plldig_calc_target_rate(req->rate, parent_rate, &phi1_param);
>> > +     if (ret)
>> > +             return ret;
>> > +
>> > +     req->rate = phi1_param.rate;
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
>> > +             unsigned long parent_rate) {
>> > +     struct clk_plldig *data = to_clk_plldig(hw);
>> > +     struct plldig_phi1_param phi1_param;
>> > +     unsigned int val, cond;
>> > +     int ret;
>> > +
>> > +     phi1_param.mfd = data->mfd;
>> > +     ret = plldig_calc_target_rate(rate, parent_rate, &phi1_param);
>> > +     if (ret)
>> > +             return ret;
>> > +
>> > +     val = readl(data->regs + PLLDIG_REG_PLLDV);
>> > +     val = FIELD_PREP(PLLDIG_REG_FIELD_MULT, phi1_param.mfd) |
>> > +           FIELD_PREP(PLLDIG_REG_FIELD_RFDPHI1,
>> phi1_param.rfdphi1);
>> > +
>> > +     writel(val, data->regs + PLLDIG_REG_PLLDV);
>> > +
>> > +     /* delay 200us make sure that old lock state is cleared */
>> > +     udelay(200);
>> > +
>> > +     /* Wait until PLL is locked or timeout (maximum 1000 usecs) */
>> > +     return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR,
>> cond,
>> > +                                      cond & PLLDIG_LOCK_MASK, 0,
>> > +                                      USEC_PER_MSEC); }
>> > +
>> > +static const struct clk_ops plldig_clk_ops = {
>> > +     .enable = plldig_enable,
>> > +     .disable = plldig_disable,
>> > +     .is_enabled = plldig_is_enabled,
>> > +     .recalc_rate = plldig_recalc_rate,
>> > +     .determine_rate = plldig_determine_rate,
>> > +     .set_rate = plldig_set_rate,
>> > +};
>> > +
>> > +static int plldig_clk_probe(struct platform_device *pdev) {
>> > +     struct clk_plldig *data;
>> > +     struct resource *mem;
>> > +     struct device *dev = &pdev->dev;
>> > +     int ret;
>> > +
>> > +     data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> > +     if (!data)
>> > +             return -ENOMEM;
>> > +
>> > +     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > +     data->regs = devm_ioremap_resource(dev, mem);
>> > +     if (IS_ERR(data->regs))
>> > +             return PTR_ERR(data->regs);
>> > +
>> > +      /*
>> > +       * Support to get the best loop multiplication divider value
>> > +       * from DTS file, since this PLL can't changed this value on
>> > +       * the fly, write the fixed value.
>> > +       */
>> > +     ret = of_property_read_u32(dev->of_node, "best-mfd", &data->mfd);
>> > +     if (ret)
>> > +             data->mfd = 0x2c;
>> 
>> IMHO this is a really bad device tree binding. First it is not 
>> described anywhere,
>> ie it is missing in the dt-bindings file and second, to actually make 
>> use of the
>> "best-mfd" the user has to know the parent clock, the desired vco 
>> frequency
>> and have to calculate it by himself.
>> IMHO a better one would be something like "vco-frequency". Also you 
>> should
>> use the fractional divider to get better results. Using the fractional 
>> divider
>> almost any VCO frequency is possible (within a certain range which 
>> should be
>> checked [650 MHz to 1300 MHz]).
>> 
> 
> Yes, the fractional part can covered range is 27MHz, it can almost any
> VCO frequency.
> the fractional divider should be supported in this driver.
> 
> I also knew the device tree binding is bad specially way, but here just 
> want to
> provide a simple solution used to configure the MFD value for users 
> requirement.

Well, but once it is in the device tree, it is hard to change, so there 
should be no quick hacks, IMHO.

> So you think that should be use "vco-frequency" instead of the
> "best-mfd" in dts used to
> avoid user recalculate it(user may don’t know the parent rate)?

correct.

-michael
