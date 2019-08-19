Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B08C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B6E2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213955;
	bh=clRxM38BHjVRnHIlDBTCGrVwSVY/3cgF0Ls2MuBJJaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVaV2Oo939JG5w604e3BXhIIQYaRRbK1qOJqn3hFbHs3ipKeObZ/NHf08ipAFKn+E
	 CtpwqwM5Sa5sA3zc2hMYlBUZsz8x+qGmlePhLE5c4GIFfBRQBAVUXqSN2ifakbC10g
	 P24P4Pi23aYheHQqx1q2MoxAD7XkWsrFCuX/M+nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHSLZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfHSLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:25:54 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1DA2086C;
        Mon, 19 Aug 2019 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213953;
        bh=clRxM38BHjVRnHIlDBTCGrVwSVY/3cgF0Ls2MuBJJaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCGerm8fY3g/P04NCRoiEKuYqX+8276xlU14NIbB5sZrNFwl+7icni9zUmmh0LxdG
         37ons1mvTwKrsMrKh3RTIysDDUzYp7fjGuTFok/rbm0Ytu8wSICvDKSdlNBADa5KVY
         rjiyUbOuG+EfIER+zg6Bau0BESopAPSbXGyrarFE=
Date:   Mon, 19 Aug 2019 13:25:40 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Message-ID: <20190819112539.GT5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-11-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-11-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:29PM +0000, Philippe Schenker wrote:
> This adds the muxing for the optional pins usb-oc (overcurrent) and
> usb-id.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 019dda6b88ad..9a63debab0b5 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -615,6 +615,13 @@
>  		>;
>  	};
>  
> +	pinctrl_usbh_oc_1: usbh_oc-1 {

Please name it consistently in the way like:

	pinctrl_xxx: xxxgrp {
		...
	};

Also, it doesn't need to be separate patch but can just be added
together with the device referring to it.

Shawn

> +		fsl,pins = <
> +			/* USBH_OC */
> +			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_spdif: spdifgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
> @@ -681,6 +688,13 @@
>  		>;
>  	};
>  
> +	pinctrl_usbc_id_1: usbc_id-1 {
> +		fsl,pins = <
> +			/* USBC_ID */
> +			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
> -- 
> 2.22.0
> 
