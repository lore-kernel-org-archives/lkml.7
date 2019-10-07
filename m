Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3EDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A29F21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570450361;
	bh=g8uLw0ZQWgRMfDcfqOp79RUp0c5KxxYpTy2Z6/fqPZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b8ejYM6RCAIQWQlIIhcsQL1XSNcHYWuHl6XLY2b0wCrlBjyth29HQYrZErW5/a3Ls
	 iuO7Tavm0UmAOZ05EA1bk+kLZaw+6dR8yOBfiYW3S4lxGcpQNbAH4L97PZT9lAWbAs
	 fZrQgGZO2Zkldu2sO6uDsQ4vOKWPeNXK9giBilJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfJGMMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGMMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:12:40 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF39520867;
        Mon,  7 Oct 2019 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570450359;
        bh=g8uLw0ZQWgRMfDcfqOp79RUp0c5KxxYpTy2Z6/fqPZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9lGLL4yFcC16MaugULe+6KFErOlKULLqKFENCoEI9pcqsOrsNJhXNI/joTrefpbc
         hNgjk5Ez0AqLgP1fq0t1KAfbM1TUMEOIgkTPhDnyzJNWYtU/6msoploZJQENFnuZH+
         Qun7anLot6A/Yd3prD7gkOt68NFNVWnimKpv06kg=
Date:   Mon, 7 Oct 2019 20:12:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.lezcano@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] arm64: dts: imx8mq: Use correct clock for usdhc's
 ipg clk
Message-ID: <20191007121204.GI7150@dragon>
References: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:05:57PM +0800, Anson Huang wrote:
> On i.MX8MQ, usdhc's ipg clock is from IMX8MQ_CLK_IPG_ROOT,
> assign it explicitly instead of using IMX8MQ_CLK_DUMMY.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Fixes tag?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index fd42bee..e2c95ad 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -850,7 +850,7 @@
>  				             "fsl,imx7d-usdhc";
>  				reg = <0x30b40000 0x10000>;
>  				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
>  				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
>  				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
>  				clock-names = "ipg", "ahb", "per";
> @@ -867,7 +867,7 @@
>  				             "fsl,imx7d-usdhc";
>  				reg = <0x30b50000 0x10000>;
>  				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MQ_CLK_DUMMY>,
> +				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>,
>  				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
>  				         <&clk IMX8MQ_CLK_USDHC2_ROOT>;
>  				clock-names = "ipg", "ahb", "per";
> -- 
> 2.7.4
> 
