Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B44C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8552184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566841178;
	bh=vhvUfinBuSpm31ERs791ilat2rMccKc/GvBF87f6fuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ylDKb8JrXZj+d+tAbNjf4oHqVH66+t1Zyk5OSUTT6klbQit1lq1Ou/2nfBtuqRTnj
	 f1kb1MUhaei6qluBw7YyMBwSi5a5kwJ+N//iSQhbToREFpSgja9gvVWRFaZkRquAwY
	 xHqLldeukyAIy3PyXqaI2yqwPzob2xGcCNMHDaZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfHZRjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbfHZRjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:39:35 -0400
Received: from localhost (unknown [122.178.200.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B4D2080C;
        Mon, 26 Aug 2019 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566841175;
        bh=vhvUfinBuSpm31ERs791ilat2rMccKc/GvBF87f6fuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJ9aMvddrr4mCu9l3R/JGImtMK12IkD2AcSahL1RwBX/J8vH30u2zbXRbrC7YQrQr
         6LikbONFNnGjjLjsDpgaSqGg+qOg7dLoXZceMYKcbNRxUOoNvYP1PDdDrC+fRKtoUh
         MtYV36bW8phNflGVDgBMeAEZZ95EbXmqL4saCNDA=
Date:   Mon, 26 Aug 2019 23:08:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Update parent clock for rpmhcc
Message-ID: <20190826173825.GJ2672@vkoul-mobl>
References: <20190822170533.8056-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822170533.8056-1-vkoul@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, 22:35, Vinod Koul wrote:
> Since rphmcc expects the parent clock name as 'xo_board', update the
> parent clock name.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 379c40b9a52f..f92c590fd3dc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -650,7 +650,7 @@
>  			rpmhcc: clock-controller {
>  				compatible = "qcom,sm8150-rpmh-clk";
>  				#clock-cells = <1>;
> -				clock-names = "xo";
> +				clock-names = "xo_board";

With the v5 of the rpmh changes we dont need this, so please drop this

>  				clocks = <&xo_board>;
>  			};
>  		};
> -- 
> 2.20.1

-- 
~Vinod
