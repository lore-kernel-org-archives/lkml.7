Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A5BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E666021850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcruy+Hz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcruy+Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfDEOCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:02:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:02:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B40686030E; Fri,  5 Apr 2019 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554472943;
        bh=2NlJK2q5IAxwjEfWd7EahOK0DtN0b/aMY639kvFutGs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kcruy+HzfMYXxzLdXHaU45qyrIvjqGAvexPMAPvvHjJU9PJtrF3xkQwz16agREkHQ
         jwxZ93oRpxY8nC4CD4LNUyNQOO8wnvS67sDu2lQkNGtAp9QnKe6ZyoUjw43guAmIX2
         mw/0G3KVoYqPpGVm2NxLPPLCxqLMnO1uAPgK2gqw=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6994F6047C;
        Fri,  5 Apr 2019 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554472943;
        bh=2NlJK2q5IAxwjEfWd7EahOK0DtN0b/aMY639kvFutGs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kcruy+HzfMYXxzLdXHaU45qyrIvjqGAvexPMAPvvHjJU9PJtrF3xkQwz16agREkHQ
         jwxZ93oRpxY8nC4CD4LNUyNQOO8wnvS67sDu2lQkNGtAp9QnKe6ZyoUjw43guAmIX2
         mw/0G3KVoYqPpGVm2NxLPPLCxqLMnO1uAPgK2gqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6994F6047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Fix blsp2_i2c5 address
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <464822ba-8bf9-a287-bf6c-05988c7d9f88@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c9b0d6c6-a55e-91b4-80aa-42d3cee4e319@codeaurora.org>
Date:   Fri, 5 Apr 2019 08:02:20 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <464822ba-8bf9-a287-bf6c-05988c7d9f88@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2019 4:36 AM, Marc Gonzalez wrote:
> blsp1_i2c1 is at 0x0c175000
> blsp2_i2c5 is at 0x0c1ba000 (the label is correct)
> 
> Fixes: 1e71d0c273d0a ("arm64: dts: qcom: msm8998: Enumerate i2c controllers")
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index a692cbc8dd84..57426bde7580 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -982,7 +982,7 @@
>   
>   		blsp2_i2c5: i2c@c1ba000 {
>   			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x0c175000 0x600>;
> +			reg = <0x0c1ba000 0x600>;
>   			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>   
>   			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
> 

Whoops.  Nice catch.

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
