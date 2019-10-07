Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9257C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9541621721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570451028;
	bh=SXqAzMkkc4rgzNayHQj7LNvsnRtyRLfX5eY3NLKcKak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vn5iQYWgQFtFSe/7+fK0/7ZxPW1KbkmcG4UN3GLWzO+8kr3rss8f1waihqM+kbsaI
	 476jIC46V5snEC2a3nwJoBGpQAvMRjGaNCU5PriK53m+wjs2oLjc2Ij0YNndXD83bj
	 OTwYn8NEKMnh8+3VmuTYWjs/dsAcXXh129CawN2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJGMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:23:47 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00DC206BB;
        Mon,  7 Oct 2019 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570451027;
        bh=SXqAzMkkc4rgzNayHQj7LNvsnRtyRLfX5eY3NLKcKak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgUEdVvE6ILZ+SX1qJ/WP/I3/T/K6UyTfnAfJAsBIdWPv9OxqkxTPuJAsiVm/GCXi
         9c4F2gtfA5FsMZCbjeGoajzqshrk+4I5vl8/9D5qViYJIjT9c2hgheFzTUTIIcCnUN
         y1EgmnPgB52j8rjMiw9/rTb2R0EsgaiIXn5An4KA=
Date:   Mon, 7 Oct 2019 20:23:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: Add i2c3 support
Message-ID: <20191007122313.GJ7150@dragon>
References: <1568886408-18168-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568886408-18168-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:46:47PM +0800, Anson Huang wrote:
> Enable i2c3 for i.MX8MM EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index f7a15f3..7758c1c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -306,6 +306,13 @@
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
>  &iomuxc {

The iomuxc node is being put at end of file because of its huge pinctrl
data.  I2C devices should be placed in alphabetical sort though.  Can
you please have a patch moving i2c1 and i2c2 to correct place first,
and then add i2c3?

Shawn

>  	pinctrl-names = "default";
>  
> @@ -355,6 +362,13 @@
>  		>;
>  	};
>  
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c3
> +		>;
> +	};
> +
>  	pinctrl_pmic: pmicirq {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
> -- 
> 2.7.4
> 
