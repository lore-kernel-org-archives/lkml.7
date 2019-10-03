Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C75C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8621D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="reenwcBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfJCKFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:05:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfJCKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:05:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93A1PHE005807;
        Thu, 3 Oct 2019 12:05:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=LPPmd2u13qwBFxFZ5Y56WE+4sPe3u6X86PcYngdfDX0=;
 b=reenwcBxoQPpkmY1pA2l5GXAWD6wX6QABVWRP6AZbzehaCOwGQWNRg3TNPyQ2HBqa4iN
 4lP91nRfYDdrRcKISF+27TSklO7eoNKx1F2AweOFMliNsarLcGR9avkoY3GY2FBerfLf
 odSlvWi7BHuIr0qQinoPj7vHuUAXtR8sVTV+NUAg03e42M4eatQF4C2zjm1uQz21o8OV
 0xxagjVns0XSelirU5Xu1Bz60hgpforasWGSkuKNrqW4F8mJ3ZuB/JMC8Ln/xC4bkO54
 9ZIIpO8q/RtkAaLJQro0VC90fyce40blu31a5YH+COzk43oRp+U4avifIFEEVpCRD+t8 sA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v9w9w3x74-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:05:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E0434E;
        Thu,  3 Oct 2019 10:05:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EC1D2B5CAC;
        Thu,  3 Oct 2019 12:05:09 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Oct
 2019 12:05:08 +0200
Subject: Re: [PATCH] ARM: dts: stm32: move ltdc pinctrl on stm32mp157a dk1
 board
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1564754931-13861-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <05cc08f2-36c8-af75-39f3-7b7f4ac4e671@st.com>
Date:   Thu, 3 Oct 2019 12:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564754931-13861-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-01,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 8/2/19 4:08 PM, Yannick Fertré wrote:
> The ltdc pinctrl must be in the display controller node and
> not in the peripheral node (hdmi bridge).
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> index f3f0e37..1285cfc 100644
> --- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
> +++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
> @@ -99,9 +99,6 @@
>   		reset-gpios = <&gpioa 10 GPIO_ACTIVE_LOW>;
>   		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
>   		interrupt-parent = <&gpiog>;
> -		pinctrl-names = "default", "sleep";
> -		pinctrl-0 = <&ltdc_pins_a>;
> -		pinctrl-1 = <&ltdc_pins_sleep_a>;
>   		status = "okay";
>   
>   		ports {
> @@ -276,6 +273,9 @@
>   };
>   
>   &ltdc {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&ltdc_pins_a>;
> +	pinctrl-1 = <&ltdc_pins_sleep_a>;
>   	status = "okay";
>   
>   	port {
> 

Applied on stm32-next.

Thanks.
Alex
