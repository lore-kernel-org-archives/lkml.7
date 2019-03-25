Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6928C2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="STBXu1qr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dC/jQhtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfCYEVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:21:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCYEVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:21:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38CD7602F8; Mon, 25 Mar 2019 04:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553487691;
        bh=r2gVTmQ7RD11JWCxG9M01tRZRaDrrcl36vZEG8+afyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=STBXu1qramhe7FFP7b2nLoycCnNkbBBHbNoRfI49Z+LpN5aydvlicRIGWw42vGFzY
         IRvjjBmoYxqews03zzTfzue/MciWVclTytZGVjygP3qNJnv3c/NO+4fwpGsFEpBT11
         vtfys18GgCw3H/brRHZ9on1Ko/BMbOWrafYC0VmI=
Received: from [10.79.128.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04C83602F8;
        Mon, 25 Mar 2019 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553487690;
        bh=r2gVTmQ7RD11JWCxG9M01tRZRaDrrcl36vZEG8+afyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dC/jQhtDTKJ6qnlUqZrEsWgDWKak5HdW34CJK17YCgCNtV8c8pzwvLokG/ZOw1/kx
         IeKYsgYhnwKgacULbHv6Cw4iJfXIvquuQu0KPi+1Ia6B2/YalP+c3eeWm4b7imOpiy
         vTb2OVqrCmagORZE6ZcjlvWvFmdgrWWK4Iuy3eJc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04C83602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 4/9] dt-bindings: power: Add rpm power domain bindings
 for qcs404
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, andy.gross@linaro.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190324175007.29040-1-sibis@codeaurora.org>
 <20190324175007.29040-5-sibis@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <6989da8a-d295-0079-ed32-b31fb1272c63@codeaurora.org>
Date:   Mon, 25 Mar 2019 09:51:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324175007.29040-5-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/2019 11:20 PM, Sibi Sankar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add RPM Power domain bindings for the qcs404 family of SoC
> 
> [sibis: Add supported rpmpd states for qcs404]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

SoB ordering seems wrong.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
>   include/dt-bindings/power/qcom-rpmpd.h        | 22 +++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index 980e5413d18f..172ccf940c5c 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -6,6 +6,7 @@ which then translates it into a corresponding voltage on a rail
>   Required Properties:
>    - compatible: Should be one of the following
>   	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
> +	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
>   	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
>    - #power-domain-cells: number of cells in Power domain specifier
>   	must be 1.
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 87d9c6611682..450378662944 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -36,4 +36,26 @@
>   #define MSM8996_VDDSSCX		5
>   #define MSM8996_VDDSSCX_VFC	6
>   
> +/* QCS404 Power Domains */
> +#define QCS404_VDDMX		0
> +#define QCS404_VDDMX_AO		1
> +#define QCS404_VDDMX_VFL	2
> +#define QCS404_LPICX		3
> +#define QCS404_LPICX_VFL	4
> +#define QCS404_LPIMX		5
> +#define QCS404_LPIMX_VFL	6
> +
> +/* RPM SMD Power Domain performance levels */

so unlike in the sdm845 case where we map these levels to
(contiguous) corners before passing it over to rpm, we seem
to pass these as-is to rpm, right?

Does this work if the user passes some value which does not
really map to a level defined here?
For instance if value passed is 17 for instance do we fall back to
16?
  
> +#define RPM_SMD_LEVEL_RETENTION       16
> +#define RPM_SMD_LEVEL_RETENTION_PLUS  32
> +#define RPM_SMD_LEVEL_MIN_SVS         48
> +#define RPM_SMD_LEVEL_LOW_SVS         64
> +#define RPM_SMD_LEVEL_SVS             128
> +#define RPM_SMD_LEVEL_SVS_PLUS        192
> +#define RPM_SMD_LEVEL_NOM             256
> +#define RPM_SMD_LEVEL_NOM_PLUS        320
> +#define RPM_SMD_LEVEL_TURBO           384
> +#define RPM_SMD_LEVEL_TURBO_NO_CPR    416
> +#define RPM_SMD_LEVEL_BINNING         512
> +
>   #endif
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
