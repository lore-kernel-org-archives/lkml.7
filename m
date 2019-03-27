Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6309420651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730329;
	bh=X7sQ4bPMv4Hnl/0+yRNNCZ7JpZ8yzeG7+FHbQkJNPpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bt+/ESyucjpVkl0IEGLropQMOxMvFI/rIVkITk9SoocDFMySNcC89ashy9rw6M5rY
	 e6fU9MW+ckhRQrdlcw5YiGTFLyDQjjK1LKaGcfOOPu1iyWCdo+p0aivO3nXriKTNlz
	 VKFt64d6cS4b/WOxbkRnD+Npp6pn3Qs+9ZrF5YNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfC0Xp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:45:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43751 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbfC0Xp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:45:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id 67so14285529oif.10;
        Wed, 27 Mar 2019 16:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7DkzqMUzCpFaGX76GbM9SX0n9kN0CaDcTe1FmhZii0=;
        b=q1RrU40CMkI8gg7KYZV3OwrkvQDtwQscdA/J+BONImdx1YL6jspO90whFc1DUxz+ln
         l9q95P1ZGaZMvaYecNV+kujHfB3vEcnhjPg4c3/VC5bMD+Vjk7RTmLotW50uOXlJcNvV
         lSUhyHRxGyZ7sPSzmKaHTFBH76wVYI/fbt0Nq4jwy18mu8hW48mo7Q18ZEZD7tYbDoTJ
         8E2/bNyPr42NlVP/phlo0pxkARlXOMbcPAb1OkV1GFiN4mKpkXQW1hE+hoy32PPDVPev
         /WgdceSyDZRz6L94cmnhOa9AGmzQL1gMwNo8g2vbI7NRHErZ1pHU2Tsm8P7sN/uvUJBB
         b3lg==
X-Gm-Message-State: APjAAAVWgvEFJbLPQCqTLxBb693JwDxgH9Z6WNyt7d4Yfggk4yRpfU4M
        xOgVmsLZJcvSoJSEGrk+aw==
X-Google-Smtp-Source: APXvYqxbU3zCkfd2J8cXbk0uiJpHXt9RAUPr/1jcZOq4I9JC4w+VhHfs00BIxmuygZhYfXiL41Rw/Q==
X-Received: by 2002:a54:4f0f:: with SMTP id e15mr20211166oiy.66.1553730325461;
        Wed, 27 Mar 2019 16:45:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i17sm9082369otc.67.2019.03.27.16.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:45:24 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:45:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: Rename and amend Hexagon
 v56 binding
Message-ID: <20190327234524.GA20594@bogus>
References: <20190307000318.1750-1-bjorn.andersson@linaro.org>
 <20190307000318.1750-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307000318.1750-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:03:17PM -0800, Bjorn Andersson wrote:
> The SDM845 Audio DSP peripheral image loader binding describes the
> properties needed to load and boot firmware on a Hexagon v56. Rename the
> file and add the Compute DSP (CDSP) found in QCS404 to the binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  ...qcom,adsp-pil.txt => qcom,hexagon-v56.txt} | 34 +++++++++++++------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>  rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp-pil.txt => qcom,hexagon-v56.txt} (74%)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
> similarity index 74%
> rename from Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> rename to Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
> index 66af2c30944f..8011f88f7c1f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
> @@ -1,12 +1,13 @@
> -Qualcomm Technology Inc. ADSP Peripheral Image Loader
> +Qualcomm Technology Inc. Hexagon v56 Peripheral Image Loader
>  
>  This document defines the binding for a component that loads and boots firmware
> -on the Qualcomm Technology Inc. ADSP Hexagon core.
> +on the Qualcomm Technology Inc. Hexagon v56 core.
>  
>  - compatible:
>  	Usage: required
>  	Value type: <string>
>  	Definition: must be one of:
> +		    "qcom,qcs404-cdsp-pil",
>  		    "qcom,sdm845-adsp-pil"
>  
>  - reg:
> @@ -28,10 +29,10 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
>  - clocks:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition:  List of 8 phandle and clock specifier pairs for the adsp.
> +	Definition:  List of phandles and clock specifier pairs for the Hexagon.

Would be nice to keep some range of what is valid.

>  
>  - clock-names:
> -	Usage: required
> +	Usage: required for SDM845 ADSP
>  	Value type: <stringlist>
>  	Definition: List of clock input name strings sorted in the same
>  		    order as the clocks property. Definition must have
> @@ -39,6 +40,14 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
>  		    "lpass_ahbm_aon_cbcr", "qdsp6ss_xo", "qdsp6ss_sleep"
>  		    and "qdsp6ss_core".
>  
> +- clock-names:
> +	Usage: required for QCS404 CDSP
> +	Value type: <stringlist>
> +	Definition: List of clock input name strings sorted in the same
> +		    order as the clocks property. Definition must have
> +		    "xo", "sway", "tbu", "bimc", "ahb_aon", "q6ss_slave",
> +		    "q6ss_master", "q6_axim".
> +
>  - power-domains:
>  	Usage: required
>  	Value type: <phandle>
> @@ -47,28 +56,33 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
>  - resets:
>  	Usage: required
>  	Value type: <phandle>
> -	Definition: reference to the list of 2 reset-controller for the adsp.
> +	Definition: reference to the list of resets for the Hexagon.
>  
>  - reset-names:
> -        Usage: required
> +        Usage: required for SDM845 ADSP
>          Value type: <stringlist>
>          Definition: must be "pdc_sync" and "cc_lpass"
>  
> +- reset-names:
> +        Usage: required for QCS404 CDSP
> +        Value type: <stringlist>
> +        Definition: must be "restart"
> +
>  - qcom,halt-regs:
>  	Usage: required
>  	Value type: <prop-encoded-array>
>  	Definition: a phandle reference to a syscon representing TCSR followed
> -			by the offset within syscon for lpass halt register.
> +		    by the offset within syscon for Hexagon halt register.
>  
>  - memory-region:
>  	Usage: required
>  	Value type: <phandle>
> -	Definition: reference to the reserved-memory for the ADSP
> +	Definition: reference to the reserved-memory for the firmware
>  
>  - qcom,smem-states:
>  	Usage: required
>  	Value type: <phandle>
> -	Definition: reference to the smem state for requesting the ADSP to
> +	Definition: reference to the smem state for requesting the Hexagon to
>  		    shut down
>  
>  - qcom,smem-state-names:
> @@ -79,7 +93,7 @@ on the Qualcomm Technology Inc. ADSP Hexagon core.
>  
>  = SUBNODES
>  The adsp node may have an subnode named "glink-edge" that describes the
> -communication edge, channels and devices related to the ADSP.
> +communication edge, channels and devices related to the Hexagon.
>  See ../soc/qcom/qcom,glink.txt for details on how to describe these.
>  
>  = EXAMPLE
> -- 
> 2.18.0
> 
