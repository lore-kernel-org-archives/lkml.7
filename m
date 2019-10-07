Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56CC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3377221721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570449104;
	bh=rJkCYF9E8hJDyr+u7S20Ya90d4j7QifBLzL5U859QeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EXnD93wMQKUwDaLGfsW8IYmlUgMqS0lZY4EzZ+bhKshDsFn4t80GEnZzR7rTDEP2o
	 qmRPdcVqmU4HktSu5iW6U0EsG1rMjQLY2fBD1ewy+MWaNO1Y01pDeq32A1yFWzvf7f
	 BHOmnBWeG0wpwEPZBajGumT+es0xnyvkw38QwAxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJGLvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGLvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:51:43 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F20206C2;
        Mon,  7 Oct 2019 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570449102;
        bh=rJkCYF9E8hJDyr+u7S20Ya90d4j7QifBLzL5U859QeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krAXa5J6WdSaSD7XsilsdxAYI6LjH2OnEJltMf52tq4LLeketI0lqfP0IxFX5BXG/
         mD6+IN98E9Banma/LLMJqN9mHsByFLZhPb5Gwoacnb7cNJReOkneZbuNdUV96xFBrn
         3T8AljcPirmnJHyjMA/eKxmHitdsR9kgD84ez17w=
Date:   Mon, 7 Oct 2019 19:51:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: Correct CPU core idle state name
Message-ID: <20191007115104.GF7150@dragon>
References: <20190917073357.5895-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917073357.5895-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:33:56PM +0800, Ran Wang wrote:
> lx2160a support PW15 but not PW20, correct name to avoid confusing.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Leo, agree?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 36 +++++++++++++-------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 408e0ec..b032f38 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -33,7 +33,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster0_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@1 {
> @@ -49,7 +49,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster0_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@100 {
> @@ -65,7 +65,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster1_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@101 {
> @@ -81,7 +81,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster1_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@200 {
> @@ -97,7 +97,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster2_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@201 {
> @@ -113,7 +113,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster2_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@300 {
> @@ -129,7 +129,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster3_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@301 {
> @@ -145,7 +145,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster3_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@400 {
> @@ -161,7 +161,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster4_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@401 {
> @@ -177,7 +177,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster4_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@500 {
> @@ -193,7 +193,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster5_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@501 {
> @@ -209,7 +209,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster5_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@600 {
> @@ -225,7 +225,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster6_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@601 {
> @@ -241,7 +241,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster6_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@700 {
> @@ -257,7 +257,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster7_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cpu@701 {
> @@ -273,7 +273,7 @@
>  			i-cache-line-size = <64>;
>  			i-cache-sets = <192>;
>  			next-level-cache = <&cluster7_l2>;
> -			cpu-idle-states = <&cpu_pw20>;
> +			cpu-idle-states = <&cpu_pw15>;
>  		};
>  
>  		cluster0_l2: l2-cache0 {
> @@ -340,9 +340,9 @@
>  			cache-level = <2>;
>  		};
>  
> -		cpu_pw20: cpu-pw20 {
> +		cpu_pw15: cpu-pw15 {
>  			compatible = "arm,idle-state";
> -			idle-state-name = "PW20";
> +			idle-state-name = "PW15";
>  			arm,psci-suspend-param = <0x0>;
>  			entry-latency-us = <2000>;
>  			exit-latency-us = <2000>;
> -- 
> 2.7.4
> 
