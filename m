Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D7AC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551C121783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CcKkU3kj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MlgjGIim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfKMLVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:21:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKMLVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:21:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F01276092C; Wed, 13 Nov 2019 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573644063;
        bh=G7Z6QkPbntFk8QRouNA5ZuiOR+CkmVoeKkOObd1B8BU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CcKkU3kjAz3HeXjTsTsnU8oLgtebFOyU42E/twns9tiYAgVm2vtuDGkoSGahau88u
         h6o6qolsdAqxqqZv8C7bYNSXi0ahYJaiG8xz37ugbRRdD8DN1NScS7HSFb0qFSGqAV
         ThagiWMXLH4P8iHcyNpJuuwTRyznGStLdpzW5KgQ=
Received: from [10.206.28.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D26E607EF;
        Wed, 13 Nov 2019 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573644061;
        bh=G7Z6QkPbntFk8QRouNA5ZuiOR+CkmVoeKkOObd1B8BU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MlgjGIim8m5qKKU2sC1qv3BqGinfLXvrSxVCF6ExDcekDPU10Xlcg4f2czT3ljhnj
         0XFBN1U6tvAsJS5/kVv6I2XgzD+ZzPwCNR4BfRMxhNNrGJhcV2rbKKc4dVLvnnc6rE
         6rzTNfiYzIoddG04RERJdPTRHrGa2mrOsBjX2OLQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D26E607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v9 1/4] dt-bindings: clock: Document external clocks for
 MSM8998 gcc
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1573591382-14225-1-git-send-email-jhugo@codeaurora.org>
 <1573591466-14296-1-git-send-email-jhugo@codeaurora.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <63e2cdd2-919d-9ec2-9fe8-48bbe34f732c@codeaurora.org>
Date:   Wed, 13 Nov 2019 16:50:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1573591466-14296-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

On 11/13/2019 2:14 AM, Jeffrey Hugo wrote:
> The global clock controller on MSM8998 can consume a number of external
> clocks.  Document them.
> 
> For 7180 and 8150, the hardware always exists, so no clocks are truly
> optional.  Therefore, simplify the binding by removing the min/max
> qualifiers to clocks.  Also, fixup an example so that dt_binding_check
> passes.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   .../devicetree/bindings/clock/qcom,gcc.yaml        | 47 +++++++++++++++-------
>   1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> index e73a56f..2f3512b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -40,20 +40,38 @@ properties:
>          - qcom,gcc-sm8150
>   
>     clocks:
> -    minItems: 1
> -    maxItems: 3
> -    items:
> -      - description: Board XO source
> -      - description: Board active XO source
> -      - description: Sleep clock source
> +    oneOf:
> +      #qcom,gcc-sm8150
> +      #qcom,gcc-sc7180
> +      - items:
> +        - description: Board XO source
> +        - description: Board active XO source
> +        - description: Sleep clock source
> +      #qcom,gcc-msm8998
> +      - items:
> +        - description: Board XO source
> +        - description: USB 3.0 phy pipe clock
> +        - description: UFS phy rx symbol clock for pipe 0
> +        - description: UFS phy rx symbol clock for pipe 1
> +        - description: UFS phy tx symbol clock
> +        - description: PCIE phy pipe clock

Would it be possible to add an example for MSM8998?

>   
>     clock-names:
> -    minItems: 1
> -    maxItems: 3
> -    items:
> -      - const: bi_tcxo
> -      - const: bi_tcxo_ao
> -      - const: sleep_clk
> +    oneOf:
> +      #qcom,gcc-sm8150
> +      #qcom,gcc-sc7180
> +      - items:
> +        - const: bi_tcxo
> +        - const: bi_tcxo_ao
> +        - const: sleep_clk

Not required for SC7180.

> +      #qcom,gcc-msm8998
> +      - items:
> +        - const: xo
> +        - const: usb3_pipe
> +        - const: ufs_rx_symbol0
> +        - const: ufs_rx_symbol1
> +        - const: ufs_tx_symbol0
> +        - const: pcie0_pipe
>   
>     '#clock-cells':
>       const: 1
> @@ -118,6 +136,7 @@ else:
>         compatible:
>           contains:
>             enum:
> +            - qcom,gcc-msm8998
>               - qcom,gcc-sm8150
>               - qcom,gcc-sc7180
>     then:
> @@ -179,8 +198,8 @@ examples:
>       clock-controller@100000 {
>         compatible = "qcom,gcc-sc7180";
>         reg = <0x100000 0x1f0000>;
> -      clocks = <&rpmhcc 0>, <&rpmhcc 1>;
> -      clock-names = "bi_tcxo", "bi_tcxo_ao";
> +      clocks = <&rpmhcc 0>, <&rpmhcc 1>, <0>;
> +      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";

SC7180 does not require a sleep clock.

>         #clock-cells = <1>;
>         #reset-cells = <1>;
>         #power-domain-cells = <1>;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
