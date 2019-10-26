Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B09206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572083413;
	bh=6X+7o3nYmXTXsHrt3fJpGLQ4D2YmwYsckeqeO0iyPBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EJUvMB6nwvua7koBkCXcmiaIXQusgQ3OiBgkFoKTOM3Qp4RWcM7Ko9BgodBMMHzdj
	 IgcNCNydLopLBNh58rFy+pDK/MIC90FbwlAOecRGi8KBI4kdpx7Tu06PNeqsGwzVzW
	 hMviBK8uJZEogbrWOVzgxZMhC9MIRg5fkfstYyyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfJZJuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:50:04 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688CA206DD;
        Sat, 26 Oct 2019 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572083403;
        bh=6X+7o3nYmXTXsHrt3fJpGLQ4D2YmwYsckeqeO0iyPBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRfM6GkFHiFz61bDBM1gZY69z7MtzF0lhmhYj/eXjcQ/3FGz6yMI0tMvsNaOG0r4T
         tREbXMfsrNdWjxpN/sYtg/TanaasGqIJTPS0eCvYt/Y6Rw2lceE7UqFtQkXiXxeoFC
         AxaPOhTjmcu1phFfy+9LUeH0rmHB/WGEyePbiXE0=
Date:   Sat, 26 Oct 2019 17:49:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v3] arm64: dts: ls1028a: Update the property of the DT node
 dpclk
Message-ID: <20191026094948.GF14401@dragon>
References: <20191014071327.28961-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014071327.28961-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 03:13:27PM +0800, Wen He wrote:
> Update the property #clock-cells = <1> to #clock-cells = <0> of the
> dpclk, since the Display output pixel clock driver provides single
> clock output.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

The patch subject can be more specific like:

  arm64: dts: ls1028a: Update #clock-cells of dpclk node

I updated it and applied patch.

Shawn

> ---
> change in v3:
>         - according the maintainer correction node name
>         - update the commit message
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 51fa8f57fdac..616b150a15aa 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -82,7 +82,7 @@
>  	dpclk: clock-controller@f1f0000 {
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
