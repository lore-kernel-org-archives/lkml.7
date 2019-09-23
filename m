Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD33C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C02168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569257685;
	bh=WIRo18P9vD/7u8trD2h5S5GUAMjZkH6LD3wnIxh+LOU=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=lQwrYT3s1i1I4R71lFzWzDquHZuGVQPLBIRRz0HsOHudxeDHPYyW/voXj1jz6u1Tn
	 j5k0RLJM7WPSSAnFVqb8AWw26kFZZZ4hoiCqvAvwxAnS13K4Q7DsKsylO5MVUbZQu9
	 E2AFCluli58ziecCbOwMHJGq6FkOKIEypY9UA5gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502135AbfIWQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390806AbfIWQyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:54:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B1C20882;
        Mon, 23 Sep 2019 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569257683;
        bh=WIRo18P9vD/7u8trD2h5S5GUAMjZkH6LD3wnIxh+LOU=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=fX3kSzm/O/ZTERhPGEutWFuA1d/8Ed2hikLwxeh5MenpYAXPjUKlP3dfXISawejj5
         xeQc8eKDua9XPOO55Rrz9O1fkhEVBinMe2ccKxfmk32T4jNVJEwGulEIAeRQ2UPToM
         y5+IBkiYLYvmn4dwpBZ97FWmejIAmww4YSNNsOXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com> <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
Cc:     devicetree@vger.kernel.org, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
To:     Fabio Estevam <festevam@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
User-Agent: alot/0.8.1
Date:   Mon, 23 Sep 2019 09:54:42 -0700
Message-Id: <20190923165443.D1B1C20882@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurentiu Palcu (2019-09-23 07:13:19)
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index 52aae34..d4aa778 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -871,6 +871,31 @@
>                                 interrupt-controller;
>                                 #interrupt-cells =3D <1>;
>                         };
> +
> +                       dcss: dcss@0x32e00000 {

Drop the 0x prefix on node names.

> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               compatible =3D "nxp,imx8mq-dcss";
> +                               reg =3D <0x32e00000 0x2D000>, <0x32e2f000=
 0x1000>;
> +                               interrupts =3D <6>, <8>, <9>;
> +                               interrupt-names =3D "ctx_ld", "ctxld_kick=
", "vblank";
> +                               interrupt-parent =3D <&irqsteer>;
> +                               clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT=
>,
> +                                        <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
> +                                        <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
> +                                        <&clk IMX8MQ_VIDEO2_PLL_OUT>,
> +                                        <&clk IMX8MQ_CLK_DISP_DTRC>;
> +                               clock-names =3D "apb", "axi", "rtrm", "pi=
x", "dtrc";
> +                               assigned-clocks =3D <&clk IMX8MQ_CLK_DISP=
_AXI>,
> +                                                 <&clk IMX8MQ_CLK_DISP_R=
TRM>,
> +                                                 <&clk IMX8MQ_VIDEO2_PLL=
1_REF_SEL>;
> +                               assigned-clock-parents =3D <&clk IMX8MQ_S=
YS1_PLL_800M>,
> +                                                        <&clk IMX8MQ_SYS=
1_PLL_800M>,
> +                                                        <&clk IMX8MQ_CLK=
_27M>;
> +                               assigned-clock-rates =3D <800000000>,
> +                                                          <400000000>;
> +                               status =3D "disabled";
> +                       };

