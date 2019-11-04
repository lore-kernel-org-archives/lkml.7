Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E94CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B2521744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572852607;
	bh=QJMX4hYVZC4TczUoT32Bkr5EA9Iu2ovv4KhF0XdoP6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SkCsXfgCK9hLezUzFCET0g8wLM5ZfDL1rKHCSUyGLJAsxOVft9TDu2m5xKvAO75tN
	 Iz4yeXGs7UsmmfpWcxBO2acpr+m0Rbd9tda/e7mXjAJIO1TyJ9Qdlte7MGyaD9oRuO
	 zAoKpNV1tdh8zewL0dxBaKj7Rd0Fy+39HHpY0Wmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfKDHaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfKDHaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:30:05 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B689A2053B;
        Mon,  4 Nov 2019 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572852605;
        bh=QJMX4hYVZC4TczUoT32Bkr5EA9Iu2ovv4KhF0XdoP6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmcSJ44XVGKvoTzHlkHMN+vGCJ89LBY8TsPHcyqEGdFecX9QSLCIUKfJJRKyvIpZK
         zOuVEePIEDOJkevGyRXdLajyynMbzrN33BbVhVdWJgI5APUFWZhdETJtb33SgdmSD6
         FfA4MV/hKCIJULu33h4ruLC0aJo/aQXeqBwaww98=
Date:   Mon, 4 Nov 2019 15:29:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/11] ARM: dts: imx6ul-kontron-n6x1x-s: Specify
 bus-width for SD card and eMMC
Message-ID: <20191104072936.GQ24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-7-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031142112.12431-7-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:24:18PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Both, the SD card and the eMMC are connected to the usdhc controller
> by four data lines. Therefore we set 'bus-width = <4>' for both
> interfaces.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> index 7c98a1a46fb1..2299cad900af 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> @@ -209,6 +209,7 @@
>  	wakeup-source;
>  	vmmc-supply = <&reg_3v3>;
>  	voltage-ranges = <3300 3300>;
> +	bus-width = <4>;

Isn't it already set in arch/arm/boot/dts/imx6ul.dtsi as the default?

Shawn

>  	no-1-8-v;
>  	status = "okay";
>  };
> @@ -223,6 +224,7 @@
>  	wakeup-source;
>  	vmmc-supply = <&reg_3v3>;
>  	voltage-ranges = <3300 3300>;
> +	bus-width = <4>;
>  	no-1-8-v;
>  	status = "okay";
>  };
> -- 
> 2.17.1
