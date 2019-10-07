Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC69C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31821924
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570451746;
	bh=G7bPx9GFN1xcIq71rEDntHAC9rEEeUdtSJm31epRpNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVTyTHQNq5Q7D3zFDvvkzH3C2snw6fS/QVRVikgALkgEiocIyzgC0QvHul7r+pdsE
	 d5+FssxrVcKuwaNTnRYW7m5VmJ0AVuzVoWTVA561b5SNzKLD8Th8wyFkvTT2DYC6Ds
	 hIAGre31Z5v/mXC7RD9A6CPHU6UC2uQ8PuJ7MSrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfJGMfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:35:45 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD50206C0;
        Mon,  7 Oct 2019 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570451744;
        bh=G7bPx9GFN1xcIq71rEDntHAC9rEEeUdtSJm31epRpNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHXEvMMPGUIpAl6s1plLNDIIYy0bV2EVRCg4UM5/eMhM19KfB/F+Ev1kAwvho+3Th
         5ATB6FR8DTeQegelhxD7bvB6tD5/ZBLVke2SvxaEEBTusyNPP4PNorJ4BfKS91wixu
         8X2LI5HOR3KRxB9whHwVg/AQWbPIylQGjBa/z/f4=
Date:   Mon, 7 Oct 2019 20:35:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node definition for
 dpclk
Message-ID: <20191007123512.GM7150@dragon>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
 <20190920083419.5092-2-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920083419.5092-2-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:34:19PM +0800, Wen He wrote:
> Update DT node name clock-controller to clock-display,

The node name clock-controller is so good, and I do not understand why
you need to change it.

Shawn

> also change
> the property #clock-cells value to zero.
> 
> This update according the feedback of the Display output interface
> clock driver upstream.
> 
> Link: https://lore.kernel.org/patchwork/patch/1113832/
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 51fa8f57fdac..db1e186352d8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -79,10 +79,10 @@
>  		clock-output-names = "phy_27m";
>  	};
>  
> -	dpclk: clock-controller@f1f0000 {
> +	dpclk: clock-display@f1f0000 {
>  		compatible = "fsl,ls1028a-plldig";
>  		reg = <0x0 0xf1f0000 0x0 0xffff>;
> -		#clock-cells = <1>;
> +		#clock-cells = <0>;
>  		clocks = <&osc_27m>;
>  	};
>  
> @@ -665,7 +665,7 @@
>  		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "DE", "SE";
> -		clocks = <&dpclk 0>, <&clockgen 2 2>, <&clockgen 2 2>,
> +		clocks = <&dpclk>, <&clockgen 2 2>, <&clockgen 2 2>,
>  			 <&clockgen 2 2>;
>  		clock-names = "pxlclk", "mclk", "aclk", "pclk";
>  		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> -- 
> 2.17.1
> 
