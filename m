Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DAFC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B306206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sGUkpYMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDZEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:46:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16818 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZEqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:46:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc28d280001>; Thu, 25 Apr 2019 21:46:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Apr 2019 21:46:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Apr 2019 21:46:35 -0700
Received: from [10.24.47.58] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 04:46:32 +0000
Subject: Re: [PATCH 2/2] pinctrl: tegra: Add Tegra194 pinmux driver
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <pdeschrijver@nvidia.com>, <josephl@nvidia.com>,
        <smangipudi@nvidia.com>, <ldewangan@nvidia.com>
References: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
 <1556247378-3335-2-git-send-email-kyarlagadda@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <353b41da-8055-a39d-e40c-612e88cb2982@nvidia.com>
Date:   Fri, 26 Apr 2019 10:16:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556247378-3335-2-git-send-email-kyarlagadda@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556253992; bh=hoB36HPSt3BX4XgpT/yEPpxtDpJHAQurCxalvDUISrU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sGUkpYMZm9B+qjxm2uLNrMo5MvngiMg0ohnd69c72G247N01pg/mE1iTggr/Dr4jg
         ZLkyt0NwSr/Db9jhYY47b9L1cdL/A7Ntj2U09NFg/gs1jbJIETw/1K/ohn1MZBEAMA
         tZqPznj12cLkEDIKvEIqtrYgq4X+CrpxIYEm1eTqY2oxiUN5ffgcM3Jmkk5JK7i75g
         u5U7VBM8KQSMFBb6qFSIVOxDxlflXNATFYQbnktu+N4ujrUnd6/EOVjkCjjLZOZnm1
         Ur5lXYejm7frMA5eaiCm6bSu0T1VDhL36rbYPlEz9yLKxYzlxiMdLr/WfUoMI78eKZ
         C/LLgsV0LurQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2019 8:26 AM, Krishna Yarlagadda wrote:
> Tegra194 has PCIE L5 rst and clkreq pins which need to be controlled
> dynamically at runtime. This driver supports change pinmux for these
> pins. Pinmux for rest of the pins is set statically by bootloader and
> will not be changed by this driver
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Signed-off-by: Suresh Mangipudi <smangipudi@nvidia.com>
> ---
>   drivers/pinctrl/tegra/Kconfig            |   4 +
>   drivers/pinctrl/tegra/Makefile           |   1 +
>   drivers/pinctrl/tegra/pinctrl-tegra.c    |   8 +-
>   drivers/pinctrl/tegra/pinctrl-tegra.h    |   8 +-
>   drivers/pinctrl/tegra/pinctrl-tegra194.c | 175 +++++++++++++++++++++++++++++++
>   drivers/soc/tegra/Kconfig                |   1 +
>   6 files changed, 189 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/pinctrl/tegra/pinctrl-tegra194.c
> 
> diff --git a/drivers/pinctrl/tegra/Kconfig b/drivers/pinctrl/tegra/Kconfig
> index 24e20cc..6f79f1f 100644
> --- a/drivers/pinctrl/tegra/Kconfig
> +++ b/drivers/pinctrl/tegra/Kconfig
> @@ -23,6 +23,10 @@ config PINCTRL_TEGRA210
>   	bool
>   	select PINCTRL_TEGRA
>   
> +config PINCTRL_TEGRA194
> +	bool
> +	select PINCTRL_TEGRA
> +
>   config PINCTRL_TEGRA_XUSB
>   	def_bool y if ARCH_TEGRA
>   	select GENERIC_PHY
> diff --git a/drivers/pinctrl/tegra/Makefile b/drivers/pinctrl/tegra/Makefile
> index bbcb043..ead4e10 100644
> --- a/drivers/pinctrl/tegra/Makefile
> +++ b/drivers/pinctrl/tegra/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_PINCTRL_TEGRA30)		+= pinctrl-tegra30.o
>   obj-$(CONFIG_PINCTRL_TEGRA114)		+= pinctrl-tegra114.o
>   obj-$(CONFIG_PINCTRL_TEGRA124)		+= pinctrl-tegra124.o
>   obj-$(CONFIG_PINCTRL_TEGRA210)		+= pinctrl-tegra210.o
> +obj-$(CONFIG_PINCTRL_TEGRA194)		+= pinctrl-tegra194.o
>   obj-$(CONFIG_PINCTRL_TEGRA_XUSB)	+= pinctrl-tegra-xusb.o
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index a5008c0..76e88c4 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -292,7 +292,7 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
>   			     const struct tegra_pingroup *g,
>   			     enum tegra_pinconf_param param,
>   			     bool report_err,
> -			     s8 *bank, s16 *reg, s8 *bit, s8 *width)
> +			     s8 *bank, s32 *reg, s8 *bit, s8 *width)
>   {
>   	switch (param) {
>   	case TEGRA_PINCONF_PARAM_PULL:
> @@ -451,7 +451,7 @@ static int tegra_pinconf_group_get(struct pinctrl_dev *pctldev,
>   	const struct tegra_pingroup *g;
>   	int ret;
>   	s8 bank, bit, width;
> -	s16 reg;
> +	s32 reg;
>   	u32 val, mask;
>   
>   	g = &pmx->soc->groups[group];
> @@ -480,7 +480,7 @@ static int tegra_pinconf_group_set(struct pinctrl_dev *pctldev,
>   	const struct tegra_pingroup *g;
>   	int ret, i;
>   	s8 bank, bit, width;
> -	s16 reg;
> +	s32 reg;
>   	u32 val, mask;
>   
>   	g = &pmx->soc->groups[group];
> @@ -548,7 +548,7 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
>   	const struct tegra_pingroup *g;
>   	int i, ret;
>   	s8 bank, bit, width;
> -	s16 reg;
> +	s32 reg;
>   	u32 val;
>   
>   	g = &pmx->soc->groups[group];
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
> index 44c7194..82cd947 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.h
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
> @@ -143,10 +143,10 @@ struct tegra_pingroup {
>   	const unsigned *pins;
>   	u8 npins;
>   	u8 funcs[4];
> -	s16 mux_reg;
> -	s16 pupd_reg;
> -	s16 tri_reg;
> -	s16 drv_reg;
> +	s32 mux_reg;
> +	s32 pupd_reg;
> +	s32 tri_reg;
> +	s32 drv_reg;
>   	u32 mux_bank:2;
>   	u32 pupd_bank:2;
>   	u32 tri_bank:2;
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra194.c b/drivers/pinctrl/tegra/pinctrl-tegra194.c
> new file mode 100644
> index 0000000..9172a8c
> --- /dev/null
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra194.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Pinctrl data for the NVIDIA Tegra210 pinmux
> + *
> + * Copyright (c) 2019, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include "pinctrl-tegra.h"
> +
> +#define _GPIO(offset)			(offset)
> +#define NUM_GPIOS			(TEGRA_PIN_PEX_L5_RST_N_PGG1 + 1)
> +
> +/* Define unique ID for each pins */
> +enum pin_id {
> +	TEGRA_PIN_PEX_L5_CLKREQ_N_PGG0 = _GPIO(256),
> +	TEGRA_PIN_PEX_L5_RST_N_PGG1 = _GPIO(257),
> +};
> +
> +/* Table for pin descriptor */
> +static const struct pinctrl_pin_desc tegra194_pins[] = {
> +	PINCTRL_PIN(TEGRA_PIN_PEX_L5_CLKREQ_N_PGG0,
> +		    "TEGRA_PIN_PEX_L5_CLKREQ_N_PGG0"),
> +	PINCTRL_PIN(TEGRA_PIN_PEX_L5_RST_N_PGG1,
> +		    "TEGRA_PIN_PEX_L5_RST_N_PGG1"),
> +};
> +
> +static const unsigned int pex_l5_clkreq_n_pgg0_pins[] = {
> +	TEGRA_PIN_PEX_L5_CLKREQ_N_PGG0,
> +};
> +
> +static const unsigned int pex_l5_rst_n_pgg1_pins[] = {
> +	TEGRA_PIN_PEX_L5_RST_N_PGG1,
> +};
> +
> +/* Define unique ID for each function */
> +enum tegra_mux_dt {
> +	TEGRA_MUX_RSVD0,
> +	TEGRA_MUX_RSVD1,
> +	TEGRA_MUX_RSVD2,
> +	TEGRA_MUX_RSVD3,
> +	TEGRA_MUX_PE5,
> +};
> +
> +/* Make list of each function name */
> +#define TEGRA_PIN_FUNCTION(lid)			\
> +	{					\
> +		.name = #lid,			\
> +	}
> +static struct tegra_function tegra194_functions[] = {
> +	TEGRA_PIN_FUNCTION(rsvd0),
> +	TEGRA_PIN_FUNCTION(rsvd1),
> +	TEGRA_PIN_FUNCTION(rsvd2),
> +	TEGRA_PIN_FUNCTION(rsvd3),
> +	TEGRA_PIN_FUNCTION(pe5),
> +};
> +
> +#define PINGROUP_REG_Y(r) ((r))
> +#define DRV_PINGROUP_Y(r) ((r))
> +
> +#define DRV_PINGROUP_ENTRY_Y(r, drvdn_b, drvdn_w, drvup_b,	\
> +			     drvup_w, slwr_b, slwr_w, slwf_b,	\
> +			     slwf_w, bank)			\
> +		.drv_reg = DRV_PINGROUP_Y(r),			\
> +		.drv_bank = bank,				\
> +		.drvdn_bit = drvdn_b,				\
> +		.drvdn_width = drvdn_w,				\
> +		.drvup_bit = drvup_b,				\
> +		.drvup_width = drvup_w,				\
> +		.slwr_bit = slwr_b,				\
> +		.slwr_width = slwr_w,				\
> +		.slwf_bit = slwf_b,				\
> +		.slwf_width = slwf_w
> +
> +#define PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_lpbk, e_input,	\
> +			     e_od, schmitt_b, drvtype)		\
> +		.mux_reg = PINGROUP_REG_Y(r),			\
> +		.lpmd_bit = -1,					\
> +		.lock_bit = -1,					\
> +		.hsm_bit = -1,					\
> +		.parked_bit = -1,				\
> +		.mux_bank = bank,				\
> +		.mux_bit = 0,					\
> +		.pupd_reg = PINGROUP_REG_##pupd(r),		\
> +		.pupd_bank = bank,				\
> +		.pupd_bit = 2,					\
> +		.tri_reg = PINGROUP_REG_Y(r),			\
> +		.tri_bank = bank,				\
> +		.tri_bit = 4,					\
> +		.einput_bit = e_input,				\
> +		.odrain_bit = e_od,				\
> +		.schmitt_bit = schmitt_b,			\
> +		.drvtype_bit = 13,				\
> +		.drv_reg = -1
> +
> +#define drive_pex_l5_clkreq_n_pgg0				\
> +	DRV_PINGROUP_ENTRY_Y(0x14004, 12, 5, 20, 5, -1, -1, -1, -1, 0)
> +#define drive_pex_l5_rst_n_pgg1					\
> +	DRV_PINGROUP_ENTRY_Y(0x1400c, 12, 5, 20, 5, -1, -1, -1, -1, 0)
> +
> +#define PINGROUP(pg_name, f0, f1, f2, f3, r, bank, pupd, e_lpbk,	\
> +		 e_input, e_lpdr, e_od, schmitt_b, drvtype, io_rail)	\
> +	{							\
> +		.name = #pg_name,				\
> +		.pins = pg_name##_pins,				\
> +		.npins = ARRAY_SIZE(pg_name##_pins),		\
> +			.funcs = {				\
> +				TEGRA_MUX_##f0,			\
> +				TEGRA_MUX_##f1,			\
> +				TEGRA_MUX_##f2,			\
> +				TEGRA_MUX_##f3,			\
> +			},					\
> +		PIN_PINGROUP_ENTRY_Y(r, bank, pupd, e_lpbk,	\
> +				     e_input, e_od,		\
> +				     schmitt_b, drvtype),	\
> +		drive_##pg_name,				\
> +	}
> +
> +static const struct tegra_pingroup tegra194_groups[] = {
> +	PINGROUP(pex_l5_clkreq_n_pgg0, PE5, RSVD1, RSVD2, RSVD3, 0x14000, 0,
> +		 Y, -1, 6, 8, 11, 12, N, "vddio_pex_ctl_2"),
> +	PINGROUP(pex_l5_rst_n_pgg1, PE5, RSVD1, RSVD2, RSVD3, 0x14008, 0,
> +		 Y, -1, 6, 8, 11, 12, N, "vddio_pex_ctl_2"),
> +};
> +
> +static const struct tegra_pinctrl_soc_data tegra194_pinctrl = {
> +	.ngpios = NUM_GPIOS,
> +	.pins = tegra194_pins,
> +	.npins = ARRAY_SIZE(tegra194_pins),
> +	.functions = tegra194_functions,
> +	.nfunctions = ARRAY_SIZE(tegra194_functions),
> +	.groups = tegra194_groups,
> +	.ngroups = ARRAY_SIZE(tegra194_groups),
> +	.hsm_in_mux = true,
> +	.schmitt_in_mux = true,
> +	.drvtype_in_mux = true,
> +};
> +
> +static int tegra194_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return tegra_pinctrl_probe(pdev, &tegra194_pinctrl);
> +}
> +
> +static const struct of_device_id tegra194_pinctrl_of_match[] = {
> +	{ .compatible = "nvidia,tegra194-pinmux", },
> +	{ },
> +};
> +
> +static struct platform_driver tegra194_pinctrl_driver = {
> +	.driver = {
> +		.name = "tegra194-pinctrl",
> +		.of_match_table = tegra194_pinctrl_of_match,
> +	},
> +	.probe = tegra194_pinctrl_probe,
> +};
> +
> +static int __init tegra194_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra194_pinctrl_driver);
> +}
> +arch_initcall(tegra194_pinctrl_init);
> diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
> index a0b0344..b6d3a2e 100644
> --- a/drivers/soc/tegra/Kconfig
> +++ b/drivers/soc/tegra/Kconfig
> @@ -107,6 +107,7 @@ config ARCH_TEGRA_186_SOC
>   
>   config ARCH_TEGRA_194_SOC
>   	bool "NVIDIA Tegra194 SoC"
> +	select PINCTRL_TEGRA194
>   	select MAILBOX
>   	select TEGRA_BPMP
>   	select TEGRA_HSP_MBOX
> 
Tested along with patches that enable PCIe C5 controller on Tegra T194 SoC.

Tested-by: Vidya Sagar <vidyas@nvidia.com>
