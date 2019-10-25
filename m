Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C46CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E92421872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571992022;
	bh=30+L12pvXfxaxXDRXM/+Zl1YsohKs9Lg/WjJFQ9wTPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X5ErvppmKHydBQ8HtJaMpJsTUTO07blHz7S061y7aulW4syWFFFStooEByXDwLw6K
	 xbZQIUrSP5Uh3y+j8jVGWntADvZFsoPCjxs6V37X0FkeEvxDZCqOagjqIbefLy7DpK
	 GmS9ImaiUGDRtUi75w8cE7lrtYEVUaVCsi1TBeMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437977AbfJYI1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfJYI1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:27:01 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED5920684;
        Fri, 25 Oct 2019 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571992020;
        bh=30+L12pvXfxaxXDRXM/+Zl1YsohKs9Lg/WjJFQ9wTPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxgTSyEweBrXwKuVu3cb9km3FWD3Eg0gKN82K9DdP9tRKNPER60Bq7QtzyUmdki9L
         UaC2/v69hAr6C0SGDEHsBR0Fl12GxOlOy6psnUMjhTP6obRzIIaHy1dX5qEW2KcbLe
         u7UNkTs7HlVJqizXcJQhJBspppwZafSSev7QHA8k=
Date:   Fri, 25 Oct 2019 16:26:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: fix a compatible issue
Message-ID: <20191025082642.GG3208@dragon>
References: <20191010083334.7037-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010083334.7037-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:33:34PM +0800, Yuantian Tang wrote:
> The I2C multiplexer used on ls1028aqds is PCA9547, not PCA9847.
> If the wrong compatible was used, this chip will not be able to
> be probed correctly and hence fail to work.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")

I added the tag and applied the patch.  Please take care of adding Fixes
tag for fixes in the future.

Shawn

> ---
> v2:
> 	- refine the description
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 5e14e5a19744..f5da9e8b0d9d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -107,7 +107,7 @@
>  	status = "okay";
>  
>  	i2c-mux@77 {
> -		compatible = "nxp,pca9847";
> +		compatible = "nxp,pca9547";
>  		reg = <0x77>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.17.1
> 
