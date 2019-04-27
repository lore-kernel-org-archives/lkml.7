Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ACE212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556353086;
	bh=m4QuBZWJTz637ln21WaDJh7vbXwhTlTGvy/KyOoFA0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WjZiXa21eJ6Uj+xHkANOtKANVkeAzbhWwXIMHBk1h5gS6OwHrCLJJwu4sJtuDAmKX
	 RqAKxi64CE5g+dL/VyV2kJqtve2try/wT7HHLcXL70bmg4vQpMc6WSb5XujJQRPyd6
	 7MA6oXUMgwAb2P6UxFxJvKpLpgQKXm3LJpce1muw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfD0ISF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0ISE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:18:04 -0400
Received: from localhost (unknown [106.51.104.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6D6206E0;
        Sat, 27 Apr 2019 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556353084;
        bh=m4QuBZWJTz637ln21WaDJh7vbXwhTlTGvy/KyOoFA0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXwHZ6aH7YzJXeKQ8jW8DXPQ57Pm5sewO/JglH8LIhGhqKThDGNVr0DJyVRDQSj25
         TIHDjQkWICfdSkCPAwK0Gm6jHe9eWpgeSkhdkkKFdTpSEz83MpwqJw25WBfQKlUMbH
         n8/Sv/rkRs0KA8VVVjuMs89Pnrx+qYClWXb+KGWw=
Date:   Sat, 27 Apr 2019 13:47:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs404: Add turingcc node
Message-ID: <20190427081759.GH28103@vkoul-mobl>
References: <20190324172016.1195-1-bjorn.andersson@linaro.org>
 <20190324172016.1195-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324172016.1195-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-19, 10:20, Bjorn Andersson wrote:
> Add a node describing the Turing Clock Controller of the QCS404. Given
> the default access restriction the node is left disabled.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 298a6053c3e0..f62cd09d965e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +#include <dt-bindings/clock/qcom,turingcc-qcs404.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
>  
>  / {
> @@ -264,6 +265,17 @@
>  		ranges = <0 0 0 0xffffffff>;
>  		compatible = "simple-bus";
>  
> +		turingcc: clock-controller@800000 {
> +			compatible = "qcom,qcs404-turingcc";
> +			reg = <0x00800000 0x30000>;
> +			clocks = <&gcc GCC_CDSP_CFG_AHB_CLK>;
> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +
>  		rpm_msg_ram: memory@60000 {
>  			compatible = "qcom,rpm-msg-ram";
>  			reg = <0x00060000 0x6000>;
> -- 
> 2.18.0

-- 
~Vinod
