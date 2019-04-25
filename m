Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB1C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38D320678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfDYNHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:07:01 -0400
Received: from ns.iliad.fr ([212.27.33.1]:52562 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfDYNHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:07:01 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 47D2520109;
        Thu, 25 Apr 2019 15:06:59 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 2FFDA1FFE1;
        Thu, 25 Apr 2019 15:06:59 +0200 (CEST)
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
 <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr>
 <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
 <903fa0a6-5c40-97b4-1c01-fd84f3e51c62@free.fr>
 <8e53ea22-d248-8c63-bcda-15b502eb9699@free.fr>
 <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <0e2ffc33-1ffd-2eb2-e6a7-117b3f14c2e7@free.fr>
Date:   Thu, 25 Apr 2019 15:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 25 15:06:59 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 08:31, Amit Kucheria wrote:

> [PATCH 3/3] arm64: dts: msm8998: thermal: Restrict thermal zone name length to under 20
> 
> The thermal core restricts names of thermal zones to under 20
> characters. Fix the names for a couple of msm8998 thermal zones.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 062a93a12198..01757829d5f3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -536,7 +536,7 @@
>  			};
>  		};
>  
> -		cluster0-mhm-thermal {
> +		clust0-mhm-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -551,7 +551,7 @@
>  			};
>  		};
>  
> -		cluster1-mhm-thermal {
> +		clust1-mhm-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  

Wouldn't it be better to drop the "-thermal" suffix than to chop characters
off from the actual description?

Or would it make sense to increase the 20-char limit to 24?
=> Probably impossible without breaking the user-space ABI, since
THERMAL_NAME_LENGTH is defined in include/uapi/linux/thermal.h

Anyway, for msm8998 patches, you have my

Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Regards.
