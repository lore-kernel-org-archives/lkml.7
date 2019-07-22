Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC3C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EAC21926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563765351;
	bh=iHwdsrxcX1l8+hROd7iGKbMdgW9v39P58MFq4E2tEIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9WcFBPF59ZY2Xg1JTOOar1ndhDy4YZKTzHtYAiJHv1KbjG3PdQLMc4MMLc/clKqU
	 UrRlxBPyIx3sUHbXBW8zihmoZWbI6BMXDitgyz+Ff7zjoRVg7AWJS8AOxxSJwHqxTD
	 /9pyKUsnTklVSYFoAtk0jT8tA+eK8Zn+HMlWbOxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfGVDPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfGVDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:15:50 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB2D21953;
        Mon, 22 Jul 2019 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563765349;
        bh=iHwdsrxcX1l8+hROd7iGKbMdgW9v39P58MFq4E2tEIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qniQws2tjKUSYdRtQdiJFVk6z4kPGNwz+PnxJBcBT2/cETkKr7R74TNXLMg6/sADP
         D8+YqxAcK5x4aCtPbP1gPzKU3fmYv41MYgvZC5fJuYtB/esprxGLD1GO0fmgA0Y/Lp
         +ygQa5xyNV9KIX2L9v3fZIl38Hv1qzVvjXzk63EI=
Date:   Mon, 22 Jul 2019 11:15:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        angus@akkea.ca, agx@sigxcpu.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 3/5] arm64: dts: imx8mm: Add system counter node
Message-ID: <20190722031517.GT3738@dragon>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
 <20190710063056.35689-3-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710063056.35689-3-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 02:30:54PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX8MM system counter node to enable timer-imx-sysctr
> broadcast timer driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Do I need to wait for patch #1 landing before I apply #3 ~ #5, or can
they be applied independently (no breaking on anything)?

Shawn

> ---
> Changes since V4:
> 	- update the clock info using fixed clock node;
> 	- correct the reg range;
> 	- update the interrupt number as the system counter driver ONLY uses 1 irq now.
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index b5637f8..8cf7f34 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -560,6 +560,14 @@
>  				#pwm-cells = <2>;
>  				status = "disabled";
>  			};
> +
> +			system_counter: timer@306a0000 {
> +				compatible = "nxp,sysctr-timer";
> +				reg = <0x306a0000 0x20000>;
> +				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&osc_24m>;
> +				clock-names = "per";
> +			};
>  		};
>  
>  		aips3: bus@30800000 {
> -- 
> 2.7.4
> 
