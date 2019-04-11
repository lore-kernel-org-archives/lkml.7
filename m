Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE33C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D820873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554965699;
	bh=uLr3QRaW+Ev4ux8zgTIcxmyBefsZzpI+t8kUFfSzWfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jLKN0FuZM+rXDW4mc/ja+E2DzXMIO8lnhaZu10OXlLxWi8/XPPSg7yCZJ40h/9jmQ
	 aQKqBPgaPrGaS8g6CjUogSvag1RUbigSTaPVjsEOIwTxMkhrDFm1wadoSrqTGxwAXg
	 Yf1ZbQxhPIRGLXhENamkp68piebFwNwiNeQAxrNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKGy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKGy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:54:57 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442D220873;
        Thu, 11 Apr 2019 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554965696;
        bh=uLr3QRaW+Ev4ux8zgTIcxmyBefsZzpI+t8kUFfSzWfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pClAzeeYxuPS8DbQNlbUjPt3ELlBKQnrhiUmcQps5LinL4zIWFjiSPLQGIZbPQEdn
         EIOQB4mus2VJ1pAUrd2edRwnVpF3TVA3T+bpu7BbQAGPlu0T5e+2b955N7HbhThpyl
         El8vXruq6yvU455uFiHSlQCCe90m+9JWbJn5IGaE=
Date:   Thu, 11 Apr 2019 14:54:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Kueffner <kueffner.markus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Message-ID: <20190411065440.GB26817@dragon>
References: <1554566420-1008-1-git-send-email-kueffner.markus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554566420-1008-1-git-send-email-kueffner.markus@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 06:00:20PM +0200, Markus Kueffner wrote:
> Add Pincfgs to enable the i.MX6's OTG feature for UDOO
> 
> Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index 776bfc7..42954ee 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -221,6 +221,14 @@
>  			>;
>  		};
>  
> +		pinctrl_usbotg: usbotg {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> +				MX6QDL_PAD_EIM_D22__USB_OTG_PWR 0x17059
> +				MX6QDL_PAD_EIM_D21__USB_OTG_OC 0x17059
> +			>;
> +		};
> +

I know ac97 is out of order, but I still would like to keep pinctrl
nodes sort alphabetically.  That said, pinctrl_usbotg should go after
pinctrl_usbh.

>  		pinctrl_ac97_running: ac97running {
>  			fsl,pins = <
>  				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
> @@ -294,6 +302,14 @@
>  	status = "okay";
>  };
>  
> +&usbotg {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	fsl,power-line-polarity-active-high;
> +	fsl,over-current-polarity-active-low;

Are these two properties supported by upstream bindings and driver?

Shawn

> +	status = "okay";
> +};
> +
>  &audmux {
>  	status = "okay";
>  };
> -- 
> 2.1.4
> 
