Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80FECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BF121835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570451574;
	bh=jZekqvOAUQZzuKpPLk1i1wNMZcqRjgtUk7v5o7rc1iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CHgg++xjpuNcI7Fn4OkHtYSZbc5vLz1xOep5CJEV9uCwAsrn4cXnlZfL74X4/JLqU
	 rF5UsC1J7tck1WHXHWhsEu+ujs2Yb0PuKDMPyHvCwgeYo8HKSTUtGU5acaH26KgKI3
	 gceWn6m1fmrIAyjsXohMiYyOORDtG7GR76csx1S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfJGMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGMcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:32:54 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D674B206C0;
        Mon,  7 Oct 2019 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570451573;
        bh=jZekqvOAUQZzuKpPLk1i1wNMZcqRjgtUk7v5o7rc1iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7HRMnK6V9XLxevb5hS+UZA5RgX/8VHa2eMN6RRUtlIp2pVaQMb0xDk5uAY7NX3nN
         Y6hAKwMiMXCjYEng22jJZqiCYc64csm5HrAtXBC/7sMQI1EJlYQdKcEAnxT1VejGep
         5HcLq0DFIe9WUOClTBEnpH4/sSxrjD9FmEtnGHTQ=
Date:   Mon, 7 Oct 2019 20:32:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2 1/2] arm64: dts: ls1028a: Update the clock providers for the
 Mali DP500
Message-ID: <20191007123203.GL7150@dragon>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920083419.5092-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 04:34:18PM +0800, Wen He wrote:
> In order to maximise performance of the LCD Controller's 64-bit AXI
> bus, for any give speed bin of the device, the AXI master interface
> clock(ACLK) clock can be up to CPU_frequency/2, which is already
> capable of optimal performance. In general, ACLK is always expected
> to be equal to CPU_frequency/2. APB slave interface clock(PCLK) and
> Main processing clock(PCLK) both are tied to the same clock as ACLK.
> 
> This change followed the LS1028A Architecture Specification Manual.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

@Leo, agree?

Shawn

> ---
> change in v2:
>         - add details commit description for this change. 
>         - v1: Link: https://lore.kernel.org/patchwork/patch/1119145/
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 72b9a75976a1..51fa8f57fdac 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -86,20 +86,6 @@
>  		clocks = <&osc_27m>;
>  	};
>  
> -	aclk: clock-axi {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <650000000>;
> -		clock-output-names= "aclk";
> -	};
> -
> -	pclk: clock-apb {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <650000000>;
> -		clock-output-names= "pclk";
> -	};
> -
>  	reboot {
>  		compatible ="syscon-reboot";
>  		regmap = <&dcfg>;
> @@ -679,7 +665,8 @@
>  		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "DE", "SE";
> -		clocks = <&dpclk 0>, <&aclk>, <&aclk>, <&pclk>;
> +		clocks = <&dpclk 0>, <&clockgen 2 2>, <&clockgen 2 2>,
> +			 <&clockgen 2 2>;
>  		clock-names = "pxlclk", "mclk", "aclk", "pclk";
>  		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
>  		arm,malidp-arqos-value = <0xd000d000>;
> -- 
> 2.17.1
> 
