Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584BC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0655B20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfGSLrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:47:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSLrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A27337;
        Fri, 19 Jul 2019 04:47:39 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A623F3F71A;
        Fri, 19 Jul 2019 04:47:39 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 7182168065E; Fri, 19 Jul 2019 12:47:38 +0100 (BST)
Date:   Fri, 19 Jul 2019 12:47:38 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, robh+dt@kernel.org,
        leoyang.li@nxp.com
Subject: Re: [v2 3/3] dts: arm64: ls1028a: Add optional property node for
 Mali DP500
Message-ID: <20190719114738.GD16673@e110455-lin.cambridge.arm.com>
References: <20190719095956.11774-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719095956.11774-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 05:59:56PM +0800, Wen He wrote:
> This patch use the optional property node "arm,malidp-arqos-value" to
> can be dynamic configure QoS signaling.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 7975519b4f56..aef5b06a98d5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -554,6 +554,7 @@
>  		clocks = <&dpclk>, <&aclk>, <&aclk>, <&pclk>;
>  		clock-names = "pxlclk", "mclk", "aclk", "pclk";
>  		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> +		arm,malidp-arqos-value = <0xd000d000>;
>  
>  		port {
>  			dp0_out: endpoint {
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
