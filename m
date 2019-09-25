Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D4C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC8821655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569417154;
	bh=AaD74a0PCviH3ASjVa4uhtW3hNJxUotze4MI2kShMJ8=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=rdblWVNN3RJZDu+uIWrPZ5Bu+79xCNReE4d/LzTltXPRLbejVmUA7mJwxvBA//cHs
	 cgexZqakh6gnaJn1ezc1cOYxa61Vv/BLePV3MCjJY9V7fh6N52ZQFrVTRTTQHd4j8T
	 Wg0/uO7bCE5vUI3yQiHExqSyatZ0z+yp8R/VxXlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406137AbfIYNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405921AbfIYNMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:12:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4751020640;
        Wed, 25 Sep 2019 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569417152;
        bh=AaD74a0PCviH3ASjVa4uhtW3hNJxUotze4MI2kShMJ8=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=tsOpwJ5S9fDmc4Pig1XjNj6oLCGe0M4hVsW7WQl+PPUlaPGYjFsdvDpJGyLSCkYXl
         RwoiYlq1n4QdPzXJR0cX4hpiE3clNqWYqt4fHMwGiMMHQFCwQh9F3LlMVFCxX4YDLV
         n9hY1eXpcN13X/mM4pOEay05xt499/QddSCpAgX4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569411888-98116-3-git-send-email-jian.hu@amlogic.com>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com> <1569411888-98116-3-git-send-email-jian.hu@amlogic.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: meson: a1: add support for Amlogic A1 clock driver
User-Agent: alot/0.8.1
Date:   Wed, 25 Sep 2019 06:12:31 -0700
Message-Id: <20190925131232.4751020640@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Hu (2019-09-25 04:44:48)
> The Amlogic A1 clock includes three parts:
> peripheral clocks, pll clocks, CPU clocks.
> sys pll and CPU clocks will be sent in next patch.
>=20
> Unlike the previous series, there is no EE/AO domain
> in A1 CLK controllers.
>=20
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>

This second name didn't send the patch. Please follow the signoff
procedures documented in Documentation/process/submitting-patches.rst

> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 16d7614..a48f67d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -138,6 +138,7 @@ config ARCH_MESON
>         select COMMON_CLK_AXG
>         select COMMON_CLK_G12A
>         select MESON_IRQ_GPIO
> +       select COMMON_CLK_A1

Sort?

>         help
>           This enables support for the arm64 based Amlogic SoCs
>           such as the s905, S905X/D, S912, A113X/D or S905X/D2
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index dabeb43..e6cb4c3 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -107,3 +107,13 @@ config COMMON_CLK_G12A
>         help
>           Support for the clock controller on Amlogic S905D2, S905X2 and =
S905Y2
>           devices, aka g12a. Say Y if you want peripherals to work.
> +
> +config COMMON_CLK_A1

Probably should be placed somewhere alphabetically in this file?

> +       bool
> +       depends on ARCH_MESON
> +       select COMMON_CLK_MESON_REGMAP
> +       select COMMON_CLK_MESON_DUALDIV
> +       select COMMON_CLK_MESON_PLL
> +       help
> +         Support for the clock controller on Amlogic A113L device,
> +         aka a1. Say Y if you want peripherals to work.
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 3939f21..6be3a8f 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) +=3D axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) +=3D gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) +=3D g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) +=3D meson8b.o
> +obj-$(CONFIG_COMMON_CLK_A1) +=3D a1.o

I would guess this should be sorted on Kconfig name in this file?

> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> new file mode 100644
> index 0000000..26edae0f
> --- /dev/null
> +++ b/drivers/clk/meson/a1.c
> @@ -0,0 +1,2617 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include "clk-mpll.h"
> +#include "clk-pll.h"
> +#include "clk-regmap.h"
> +#include "vid-pll-div.h"
> +#include "clk-dualdiv.h"
> +#include "meson-eeclk.h"
> +#include "a1.h"
> +
[...]
> +
> +/*
> + * The Meson A1 HIFI PLL is 614.4M, it requires
> + * a strict register sequence to enable the PLL.
> + * set meson_clk_pcie_pll_ops as its ops

Please remove this last line as it's obvious from the code what ops are
used.

> + */
> +static struct clk_regmap a1_hifi_pll =3D {
> +       .data =3D &(struct meson_clk_pll_data){
> +               .en =3D {
> +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> +                       .shift   =3D 28,
> +                       .width   =3D 1,
> +               },
> +               .m =3D {
> +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> +                       .shift   =3D 0,
> +                       .width   =3D 8,
> +               },
> +               .n =3D {
> +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> +                       .shift   =3D 10,
> +                       .width   =3D 5,
> +               },
> +               .frac =3D {
> +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL1,
> +                       .shift   =3D 0,
> +                       .width   =3D 19,
> +               },
> +               .l =3D {
> +                       .reg_off =3D ANACTRL_HIFIPLL_STS,
> +                       .shift   =3D 31,
> +                       .width   =3D 1,
> +               },
> +               .table =3D a1_hifi_pll_params_table,
> +               .init_regs =3D a1_hifi_init_regs,
> +               .init_count =3D ARRAY_SIZE(a1_hifi_init_regs),
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "hifi_pll",
> +               .ops =3D &meson_clk_pcie_pll_ops,
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                       &a1_xtal_hifipll.hw
> +               },
> +               .num_parents =3D 1,
> +       },
> +};
> +
[..]
> +
> +static struct clk_regmap a1_fclk_div2 =3D {
> +       .data =3D &(struct clk_regmap_gate_data){
> +               .offset =3D ANACTRL_FIXPLL_CTRL0,
> +               .bit_idx =3D 21,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "fclk_div2",
> +               .ops =3D &clk_regmap_gate_ops,
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                       &a1_fclk_div2_div.hw
> +               },
> +               .num_parents =3D 1,
> +               /*
> +                * add CLK_IS_CRITICAL flag to avoid being disabled by cl=
k core
> +                * or its children clocks.

This comment is useless. Please replace it with an actual reason for
keeping the clk on instead of describing what the flag does.

> +                */
> +               .flags =3D CLK_IS_CRITICAL,
> +       },
> +};
> +
[..]
> +static struct clk_regmap a1_dmc =3D {
> +       .data =3D &(struct clk_regmap_gate_data){
> +               .offset =3D DMC_CLK_CTRL,
> +               .bit_idx =3D 8,
> +       },
> +       .hw.init =3D &(struct clk_init_data) {
> +               .name =3D "dmc",
> +               .ops =3D &clk_regmap_gate_ops,
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                       &a1_dmc_sel2.hw
> +               },
> +               .num_parents =3D 1,
> +               /*
> +                * add CLK_IGNORE_UNUSED to avoid hangup
> +                * DDR clock should not change at runtime
> +                */
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

So not CLK_IS_CRITICAL?

> +       },
> +};
> +
[...]
> +
> +/*
> + * cpu clock register base address is 0xfd000080
> + */
> +static struct clk_regmap *const a1_cpu_clk_regmaps[] =3D {
> +       /* TODO */

Can it be done?

> +};
