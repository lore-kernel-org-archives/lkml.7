Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE67205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfJUIPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:15:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49145 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfJUIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:15:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMSqi-0000ki-3p; Mon, 21 Oct 2019 10:15:32 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMSqg-0008Os-FJ; Mon, 21 Oct 2019 10:15:30 +0200
Date:   Mon, 21 Oct 2019 10:15:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dt: add fxos8700 on gateworks boards
Message-ID: <20191021081530.frhbez44x6gwosvi@pengutronix.de>
References: <20191018232049.4045-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018232049.4045-1-rjones@gateworks.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:09:31 up 156 days, 14:27, 97 users,  load average: 0.16, 0.12,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

please don't use 'ARM: dt: ..' instead you should name it 'ARM: dts:
imx6qdl-gw5x:'.

On 19-10-18 16:20, Robert Jones wrote:
> Add fxos8700 iio imu entries for Gateworks SBCs.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 1a9a9d9..ffc4449 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -306,6 +306,11 @@
>  		VDDIO-supply = <&reg_3p3v>;
>  	};
>  
> +	fxos8700@1e {
> +		compatible = "nxp,fxos8700";

I grep'd the whole tree and found no such compatible. I don't know the
rule but IMHO if there isn't a driver we shouldn't add the compatible
here.

Regards,
  Marco

> +		reg = <0x1e>;
> +	};
> +
>  	touchscreen: egalax_ts@4 {
>  		compatible = "eeti,egalax_ts";
>  		reg = <0x04>;
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index 54b2bea..ebbd1c8 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -297,6 +297,11 @@
>  		VDDIO-supply = <&reg_3p3v>;
>  	};
>  
> +	fxos8700@1e {
> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +	};
> +
>  	touchscreen: egalax_ts@4 {
>  		compatible = "eeti,egalax_ts";
>  		reg = <0x04>;
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 1b6c133..67d4725 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -354,6 +354,11 @@
>  		VDDIO-supply = <&reg_3p3v>;
>  	};
>  
> +	fxos8700@1e {
> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +	};
> +
>  	touchscreen: egalax_ts@4 {
>  		compatible = "eeti,egalax_ts";
>  		reg = <0x04>;
> -- 
> 2.9.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
