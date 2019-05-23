Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB694C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635062133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558597441;
	bh=hwfjC0bXWxh5lwODucXR9POcCE97XxGPfx1uJr9D5yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBB1mn/kSnXW+opC0XwKn1K3TKwN7l2vPhseCyQyL/EZfpOwn83hU+BF/vVk2qWJH
	 A2YcSUUn9SwioZmnwXeFGJHOeA1W6wl6L4QebqM5eb62HWiiRCDvWyGtu9KWrp+FcB
	 9BpQhdSW+MZK9uQP2L8z/FBZJIbrujMtOFs6RL3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfEWHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfEWHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:44:00 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 467A020856;
        Thu, 23 May 2019 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558597439;
        bh=hwfjC0bXWxh5lwODucXR9POcCE97XxGPfx1uJr9D5yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9onpqNwODufrI8uriW0tYeYRv+0mlHpJc++3atbbEighhn/1SpHQpYJWkxUeeJAe
         V9YnYpsQfUDuuvh68tB23LMxH806pLBp+uwFdJ87PJZnTEigJT4LK2jRID4t/0VoAr
         SRBPYBsBm0cH6dtEqbFP15rfsZia3Af4BmFosvoU=
Date:   Thu, 23 May 2019 15:43:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for
 usb3 node
Message-ID: <20190523074300.GH9261@dragon>
References: <20190515060434.33581-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515060434.33581-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:04:34PM +0800, Ran Wang wrote:
> Enable USB3 HW LPM feature for lx2160a and active patch for
> snps erratum A-010131. It will disable U1/U2 temperary when
> initiate U3 request.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Depend on: https://lore.kernel.org/patchwork/patch/870134/

Is the dependency accepted?

Shawn

> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 125a8cc..0073df3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -696,6 +696,8 @@
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			usb3-lpm-capable;
> +			snps,dis-u1u2-when-u3-quirk;
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
> @@ -707,6 +709,8 @@
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			usb3-lpm-capable;
> +			snps,dis-u1u2-when-u3-quirk;
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
> -- 
> 1.7.1
> 
