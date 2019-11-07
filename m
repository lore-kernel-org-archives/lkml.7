Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BC921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573167311;
	bh=jExGSxODnj6qW8jJKoeORibxwrOMTybXfuDaiSWa98s=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=YJHqyfKOZo/Oarwrtbe3sshhYMLODrF5OQTgPLwZj9FXeUzySs4LYjpWaX62xNnTs
	 P09Kvo+kiJGi7ZwEvIYKEoc2d+TToThZl0hhsll+XDENRbRH57Tzf9cE1sFdwuSrAq
	 2qpwy76tu1bWMZhMTWvmF8Aip9qPVEsArDOkkvGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKGWzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfKGWzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:55:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3732085B;
        Thu,  7 Nov 2019 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573167309;
        bh=jExGSxODnj6qW8jJKoeORibxwrOMTybXfuDaiSWa98s=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=CoYtf+xLGfDiQfquE2zCW0O1/SA4w1+/M3OThuKGMHV++4ZFRd6kg/yDEDY6ACVnf
         zWTq4MY7EGiGMrRQElaTliKuFz7ml3CGC40OfboKtZEAOA1bialhhSgwlrz4MbJikR
         x8CZmnN5FnxlQLarGfonSlGiXRYosy1u01MJFdlw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573111012-29095-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573111012-29095-1-git-send-email-rajan.vaja@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] dt-bindings: clock: Add bindings for versal clock driver
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 14:55:08 -0800
Message-Id: <20191107225509.5C3732085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-11-06 23:16:52)
> Add documentation to describe Xilinx Versal clock driver
> bindings.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Signoff chain is all wrong. The sender should come last. Please read up
on how to submit patches to the kernel with proper SoB chains in kernel
docs. I can dig it up if you can't find it.

> ---
>  .../devicetree/bindings/clock/xlnx,versal-clk.txt  |  48 ++++++++
>  include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++=
++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-c=
lk.txt
>  create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt =
b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt
> new file mode 100644
> index 0000000..398e751
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.txt

Can you write this in YAML so we can validate it?

> @@ -0,0 +1,48 @@
> +------------------------------------------------------------------------=
--
> +Device Tree Clock bindings for the Xilinx Versal
> +------------------------------------------------------------------------=
--
> +The clock controller is a h/w block of Xilinx versal clock tree. It reads
> +required input clock frequencies from the devicetree and acts as clock p=
rovider
> +for all clock consumers of PS clocks.
> +
> +See clock_bindings.txt for more information on the generic clock binding=
s.
> +
> +Required properties:
> + - #clock-cells:       Must be 1
> + - compatible:         Must contain:   "xlnx,versal-clk"
> + - clocks:             List of clock specifiers which are external input
> +                       clocks to the given clock controller. Please refer
> +                       the next section to find the input clocks for a
> +                       given controller.
> + - clock-names:                List of clock names which are exteral inp=
ut clocks
> +                       to the given clock controller. Please refer to the
> +                       clock bindings for more details.
> +
> +Input clocks for Xilinx Versal clock controller:
> +
> +The Xilinx Versal has one primary and two alternative reference clock in=
puts.
> +These required clock inputs are:
> + - ref_clk
> + - alt_ref_clk
> + - pl_alt_ref_clk
> +
> +Output clocks are registered based on clock information received
> +from firmware. Output clocks indexes are mentioned in
> +include/dt-bindings/clock/xlnx-versal-clk.h.
> +
> +-------
> +Example
> +-------
> +
> +firmware {
> +       versal_firmware: versal-firmware {
> +               compatible =3D "xlnx,versal-firmware";
> +               method =3D "smc";
> +               versal_clk: clock-controller {
> +                       #clock-cells =3D <1>;
> +                       compatible =3D "xlnx,versal-clk";
> +                       clocks =3D <&ref_clk>, <&alt_ref_clk>, <&pl_alt_r=
ef_clk>;
> +                       clock-names =3D "ref_clk", "alt_ref_clk", "pl_alt=
_ref_clk";
> +               };
> +       };
> +};
> diff --git a/include/dt-bindings/clock/xlnx-versal-clk.h b/include/dt-bin=
dings/clock/xlnx-versal-clk.h
> new file mode 100644
> index 0000000..264d634
> --- /dev/null
> +++ b/include/dt-bindings/clock/xlnx-versal-clk.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2019 Xilinx Inc.
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_VERSAL_H
> +#define _DT_BINDINGS_CLK_VERSAL_H
> +
> +#define PMC_PLL                                        1

Why not start with 0?

