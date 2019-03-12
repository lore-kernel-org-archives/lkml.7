Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3F2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lWp1AaDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCLP3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:29:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6554 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:29:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c87d0620000>; Tue, 12 Mar 2019 08:29:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 08:29:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 08:29:39 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 15:29:37 +0000
Subject: Re: [PATCH] arm64: tegra: dts: enable aconnect, adma and agic
To:     Sameer Pujar <spujar@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <treding@nvidia.com>
CC:     <josephl@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552400705-1179-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e473d089-7d6c-1c22-d395-91bd0ca8e122@nvidia.com>
Date:   Tue, 12 Mar 2019 15:29:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552400705-1179-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552404578; bh=+avscebs1vC92mqB6CxIVaurngPuNzKvbZpsR739d1I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lWp1AaDdiUT04uDnXN8uUOACzBs1ljaKbJn0N9ljyuPdjA1lR2kaKveu1PFN3zDpE
         3oOfYfpabIqRej8q/b8JNLdv0ToD645v8U3ya7Fhvpe/rCtMu3hiHCbFUl/d+3nrJs
         ffYBy1f/n3usE8Rt57wQ6SZKixJuzTnRPoNQLUakrAlSRZLERSVWPOzsCWqRKW0eEg
         NCEziF0VYc0rmoQhR3lHrneWUO4zVDL6SNPAHSZkYOFDAfOUoLYXcWRjVAto9imdr1
         lCEY/rQn9viHgcQ/e5Bggw7lcLREH4AExED90zLNOOpK7oy0ABWg4BQmfghkpp+SV6
         PD6bjg7rko+HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2019 14:25, Sameer Pujar wrote:
> Enable aconnect, adma and agic for Tegra Jetson TX1.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> index 9fad0d2..5a57396 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> @@ -99,4 +99,16 @@
>  		pinctrl-0 = <&dvfs_pwm_active_state>;
>  		pinctrl-1 = <&dvfs_pwm_inactive_state>;
>  	};
> +
> +	aconnect@702c0000 {
> +		status = "okay";
> +
> +		dma@702e2000 {
> +			status = "okay";
> +		};
> +
> +		agic@702f9000 {
> +			status = "okay";
> +		};
> +	};
>  };

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
