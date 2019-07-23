Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63681C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299EF2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563851465;
	bh=6ZLp1Ao516Xi5yX/o+F/v5VGsTLVx5pvjjiDbR7GZBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qcx8gem+xyTiAM8gu3LtXkpFgSiRjkjJbujmI22xhdFbuSe/Sk1rfiJjT9+sZAw4U
	 NFkoVuEi2zeaGiULK5NhhBi4kwIBon8nak1PGWPDxhPk9J33+IVI6qS+etHyPCnUWX
	 5LmgzKVc6dsmIyD79gE0VOgFKuezm0La0GU+UzL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfGWDLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfGWDLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:11:03 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D2722389;
        Tue, 23 Jul 2019 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563851462;
        bh=6ZLp1Ao516Xi5yX/o+F/v5VGsTLVx5pvjjiDbR7GZBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGGGiT8QOdJg9RdG+oxoEjE9bnK/WKrcOfeFVh30P0G3lR2DsILVJcTdfHpIvfNxZ
         i8/62lrK76t5JWOCEJyhHkozXiWpz5qiSnpS8YPdUB+YTIHfBUISWk/jb7qc6TYnnY
         BVpLmSBrnY6iapm0KGnxex/PixMNeiNz9U1stR1M=
Date:   Tue, 23 Jul 2019 11:10:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, martyn.welch@collabora.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] ARM: dts: imx6ul: segin: Add boot media to dts
 filename
Message-ID: <20190723031032.GM3738@dragon>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
 <1562656767-273566-3-git-send-email-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562656767-273566-3-git-send-email-s.riedmueller@phytec.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:19:19AM +0200, Stefan Riedmueller wrote:
> There is now a PHYTEC phyCORE-i.MX 6UL with eMMC instead of NAND flash
> available. The dts filename needs to reflect that to differentiate both.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
>  arch/arm/boot/dts/Makefile                                           | 2 +-
>  ...l-phytec-segin-ff-rdk.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>  rename arch/arm/boot/dts/{imx6ul-phytec-segin-ff-rdk.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} (85%)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e1924b06f3cb..668b57c8cc57 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -573,7 +573,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-opos6uldev.dtb \
>  	imx6ul-pico-hobbit.dtb \
>  	imx6ul-pico-pi.dtb \
> -	imx6ul-phytec-segin-ff-rdk.dtb \
> +	imx6ul-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> similarity index 85%
> rename from arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
> rename to arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> index 1e59183a2f7c..dc06029c5701 100644
> --- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
> +++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
> @@ -10,8 +10,9 @@
>  #include "imx6ul-phytec-segin-peb-eval-01.dtsi"
>  
>  / {
> -	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured";
> -	compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
> +	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured with NAND";
> +	compatible = "phytec,imx6ul-pbacd10-nand", "phytec,imx6ul-pbacd10",

The board compatibles need to be documented.

Shawn

> +		     "phytec,imx6ul-pcl063", "fsl,imx6ul";
>  };
>  
>  &adc1 {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
