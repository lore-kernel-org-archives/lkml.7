Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF37AC47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83668222CB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570330517;
	bh=ieq18tBRGO65LoXREEvWqq2qiGQbPennPGhSD9vJ4AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NpPe15ce5CnxgsbbYC2VM/ZqQNSLbEnTeXQlOtQP/J/tUu3tJbrQUhXjGa3xigOT8
	 ea9BKfRULrbynhWtDUSHsL03J7GssELxHob8ZyVfDHpciEevj7ejbWNtmL6krxpvpd
	 AccIT2OOQHQ5+wP3lPCNPV5zEgvxisrjvOsk72/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJFCzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJFCzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:55:16 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D539218AC;
        Sun,  6 Oct 2019 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570330515;
        bh=ieq18tBRGO65LoXREEvWqq2qiGQbPennPGhSD9vJ4AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CD9w2Sr+yn51n+HDlK6lfj/NCATJMKBOJPO3TOvHsen/CPup5K1msxudmTCDNdxbm
         UcMmcAN3eompehkCvRvn1INLn0czUQwGmi/FrRruD6GrFL8nm0gQ2HQTItwsSiflAt
         odf3cv3YudRWWjZDj6zUJmJOm+NFPVLPzpIgD2QI=
Date:   Sun, 6 Oct 2019 10:54:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v1] usb: dwc3: enable otg mode for dwc3 usb ip on
 layerscape
Message-ID: <20191006025450.GO7150@dragon>
References: <20190909090244.42543-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909090244.42543-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 05:02:44PM +0800, Yinbo Zhu wrote:
> layerscape otg function should be supported HNP SRP and ADP protocol
> accroing to rm doc, but dwc3 code not realize it and use id pin to
> detect who is host or device(0 is host 1 is device) this patch is to
> enable OTG mode on ls1028ardb ls1088ardb and ls1046ardb in dts
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

The patch prefix should be something like: 'arm64: dts: ...'

@Leo, do you agree with the changes?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 7975519b4f56..5810d0400dbc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -320,7 +320,7 @@
>  			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
>  			reg = <0x0 0x3110000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> -			dr_mode = "host";
> +			dr_mode = "otg";
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index b0ef08b090dd..ecce6151b9b0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -582,7 +582,7 @@
>  			compatible = "snps,dwc3";
>  			reg = <0x0 0x3000000 0x0 0x10000>;
>  			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> -			dr_mode = "host";
> +			dr_mode = "otg";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index dacd8cf03a7f..4b5413f7c90c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -385,7 +385,7 @@
>  			compatible = "snps,dwc3";
>  			reg = <0x0 0x3110000 0x0 0x10000>;
>  			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
> -			dr_mode = "host";
> +			dr_mode = "otg";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
>  			status = "disabled";
> -- 
> 2.17.1
> 
