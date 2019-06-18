Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560844591;
	bh=XIE2Hjz7qxyhCE1ax8Z4bhoYlN9BRc2odviako0LTrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOiGbJHK2nVXbgo2ltHUGnB7zwpH2qZmGuPs4imadnDnpClt7QQhw7KQJtZxJ+for
	 FNmEgWBkECqSJMkGoZIGgSeWzsm3hKKl0MVx8mLRkDvuIgLMuZpUU97FaovsQUkbdV
	 ZOrAmaFYge5nzl/Sb5AeNkw4eMjP2YasxV/6Kreg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfFRH43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfFRH43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:56:29 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321CD20B1F;
        Tue, 18 Jun 2019 07:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560844588;
        bh=XIE2Hjz7qxyhCE1ax8Z4bhoYlN9BRc2odviako0LTrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7XJWm8ZlhiiyWS1I4UaU1VfpwZo2sqNCqKS3nbUgX2Ey4LdpNe/KqZ1HK/pxyvpi
         1LmUZie0HKiL/6PPPnxYOPaMwsYaQis06gWMkOSKi8zOutdgGFwVW9CJMe/Gy3oMiT
         amNgcEJ6dyX6pB2Nct7GZmWS2AkkUbGeIIrCXgxA=
Date:   Tue, 18 Jun 2019 15:55:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com
Subject: Re: [PATCH v2 2/2] ARM: dts: Add support for 96Boards Meerkat96 board
Message-ID: <20190618075534.GI29881@dragon>
References: <20190613132705.5150-1-manivannan.sadhasivam@linaro.org>
 <20190613132705.5150-3-manivannan.sadhasivam@linaro.org>
 <20190614114433.GA24166@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614114433.GA24166@Mani-XPS-13-9360>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:14:33PM +0530, Manivannan Sadhasivam wrote:
> Hi Shawn,
> 
> On Thu, Jun 13, 2019 at 06:57:05PM +0530, Manivannan Sadhasivam wrote:
> > Add devicetree support for 96Boards Meerkat96 board from Novtech. This
> > board is one of the Consumer Edition boards of the 96Boards family based
> > on i.MX7D SoC. Following are the currently supported features of the
> > board:
> > 
> > * uSD
> > * WiFi/BT
> > * USB
> > 
> > More information about this board can be found in 96Boards product page:
> > https://www.96boards.org/product/imx7-96/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/Makefile            |   1 +
> >  arch/arm/boot/dts/imx7d-meerkat96.dts | 389 ++++++++++++++++++++++++++
> >  2 files changed, 390 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index f4f5aeaf3298..3018a763dbd1 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -579,6 +579,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
> >  	imx7d-cl-som-imx7.dtb \
> >  	imx7d-colibri-emmc-eval-v3.dtb \
> >  	imx7d-colibri-eval-v3.dtb \
> > +	imx7d-meerkat96.dtb \
> >  	imx7d-nitrogen7.dtb \
> >  	imx7d-pico-hobbit.dtb \
> >  	imx7d-pico-pi.dtb \
> > diff --git a/arch/arm/boot/dts/imx7d-meerkat96.dts b/arch/arm/boot/dts/imx7d-meerkat96.dts
> > new file mode 100644
> > index 000000000000..a86dc4878e44
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx7d-meerkat96.dts
> > @@ -0,0 +1,389 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Copyright (C) 2019 Linaro Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx7d.dtsi"
> > +
> > +/ {
> > +	model = "96Boards Meerkat96 Board";
> > +	compatible = "novtech,imx7d-meerkat96", "fsl,imx7d";
> > +
> > +	chosen {
> > +		stdout-path = &uart6;
> > +	};
> > +
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x20000000>; /* 512MB */
> > +	};
> > +
> > +	reg_wlreg_on: regulator-wlreg-on {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_wlreg_on>;
> > +		regulator-name = "wlreg_on";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		startup-delay-us = <100>;
> > +		gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_3p3v: regulator-3p3v {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "3P3V";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_otg1_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +	};
> > +
> > +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_otg2_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	sw1a_reg: sw1a {
> > +		compatible = "regulator-fixed";
> 
> Actually I was wrong here. This is not a fixed regulator node as the voltage
> level varies. Since there is no PMIC support exist now, can I remove this node?
> Or I should make it as fixed 0.7v?

I dropped it (&cpu0 as well) and applied both patches.  You can add it
later when you have the right information about it.

Shawn
