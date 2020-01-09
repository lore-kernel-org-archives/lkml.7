Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A45C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA122072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578556724;
	bh=IxIDaYwn1hYLk4AjZMN5Qonq1h8D5Y/VRrDjQJUKNq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ItFK7p4N9Bt7kqO88VQSMJ3En5opw1oJ3Trmmu5jwMi0iiqKz4swUG5k1QtTR4gaf
	 bLJaA67xOw+TbhONwBGDQxP0COy16Obe4xG22QZ0yzgB1SbJh2tgh9fs3ZogA9irJi
	 S47Q38Z21ruDf87CbhwCyl/i6G1/ZMsUFRHE/HZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgAIH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgAIH6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:58:42 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC10206ED;
        Thu,  9 Jan 2020 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578556721;
        bh=IxIDaYwn1hYLk4AjZMN5Qonq1h8D5Y/VRrDjQJUKNq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9FuoXicRdmdy8u3f4kO6XoaxwV4LHUFXa/jXJ1M8Hb5Kaj4P8nFNuYO0ld5JUzTP
         LcKNnf/QO//ezjudN3G2NSzz0chy2/HbRRoosjYXlp156GJc5Vdueu/ym2rJfKJ55t
         GoYrUkNzy6tzqDqUe8nm5NwIbog2TM9mBg9cNOVo=
Date:   Thu, 9 Jan 2020 15:58:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aapo Vienamo <aapo.vienamo@iki.fi>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: mxs: Enable usbphy1 and usb1 on apx4devkit DTS
Message-ID: <20200109075832.GG4456@T480>
References: <20191229131503.20843-1-aapo.vienamo@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229131503.20843-1-aapo.vienamo@iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 03:15:03PM +0200, Aapo Vienamo wrote:
> Enable the USB host port on the APx4 development board.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
> ---
>  arch/arm/boot/dts/imx28-apx4devkit.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
> index 3a184d13887b..f00d201ce242 100644
> --- a/arch/arm/boot/dts/imx28-apx4devkit.dts
> +++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
> @@ -183,6 +183,12 @@ auart2: serial@8006e000 {
>  				pinctrl-0 = <&auart2_2pins_a>;
>  				status = "okay";
>  			};
> +
> +			usbphy1: usbphy@8007e000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&usb1_pins_a>;
> +				status = "okay";
> +			};
>  		};
>  	};
>  
> @@ -193,6 +199,10 @@ mac0: ethernet@800f0000 {
>  			pinctrl-0 = <&mac0_pins_a>;
>  			status = "okay";
>  		};
> +
> +		usb1: usb@80090000 {

We want to keep nodes with unit-address sorted in that address.  That
said, usb@80090000 should go before ethernet@800f0000.

Shawn

> +		      status = "okay";
> +		};
>  	};
>  
>  	regulators {
> -- 
> 2.24.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
