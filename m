Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D68C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5EE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sdrq5T4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKOSR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:17:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbfKOSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:17:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFI7o6r005156;
        Fri, 15 Nov 2019 19:17:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=R0AG0K+FiTWH1VDAdSpoZmFq3tYATmR+PjAfYmovt68=;
 b=sdrq5T4a9WOf6MFyAas2MYoe3fnYWaZgrxVxFxJ5KqzpDfYchemixCcxUlh7Zz5tSRvj
 RbOPu21YJRFbI4Q3+XL4hSufxAnYEzTgPNUjHsxhS0yQlvzEPaiMDYyE55OFQuPzjuGo
 obZrA/vd8A2ekPxA0Nsal7TE9QEAbLnslc3RP/6f3Dzmf7R/l4Pye59h4aKFLAto9ZWg
 HsD9rEuP6q82yfuL2fOYw6lpslXv7tmMiFL7SZsJjQ9AmrROLcj2V4NYY46b7eBZf1NC
 gcLIq1Wm+zxAW9ZrsVJuYG+xCxNZywb1/dda6fQSUzyU2vipuArQ7RCTZVr5nmvfmm1R xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psfntuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 19:17:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A840510002A;
        Fri, 15 Nov 2019 19:17:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96E0D2129DA;
        Fri, 15 Nov 2019 19:17:45 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 19:17:44 +0100
Subject: Re: [PATCH] ARM: dts: stm32: remove unused rng interrupt
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lionel.debieve@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191115100651.17754-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b3759a65-99e1-d846-b60b-576dfa9c9f6e@st.com>
Date:   Fri, 15 Nov 2019 19:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115100651.17754-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_05:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 11/15/19 11:06 AM, Benjamin Gaignard wrote:
> Interrupt has never be used in rng driver so remove it from DT.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 5c8a826b3195..196817da0c1d 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -789,7 +789,6 @@
>   		rng: rng@50060800 {
>   			compatible = "st,stm32-rng";
>   			reg = <0x50060800 0x400>;
> -			interrupts = <80>;
>   			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(RNG)>;
>   
>   		};
> 

Applied on stm32-next. Next time, please indicate (at least in the 
commit title) for which SOC the patch is targeted.

Alex
