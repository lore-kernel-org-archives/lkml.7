Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A512C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E580720828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yyZilLo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfLIOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:10:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27268 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbfLIOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:10:03 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9E7mbB028360;
        Mon, 9 Dec 2019 15:09:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=rMgFRcSFtiFbgW/awEUZ3ybc8wwxYOXSNEv2yL+9lZM=;
 b=yyZilLo1hu8fgeyo6uWmmNN+6Gkswci+Ye6OWQbHolQQsyU5pNaTs54lPyNLE4tqA2Xk
 eFVdyzJU88XeR66RFT1Ysq46A1t+PRCta5+T/jil3V3NMcJSLWeXS9MrtxHO2GiXA2Kw
 M3sC6OjMrP08bftjKCLJb/R9MKqPbbCNlPLBO0OYl8JBYo8HtQ28Ad5AvtokY0R57ujd
 PAsK0cT2KlWdLBzMpy1VuH8DLyZJl6elCbtIRGGQ5U57Hg/if1AlpS2LZEDULmcBm+VI
 a4gtU0eaXEa3aoPSOheeoUhTyGk5stdooxRI33m3oWcUctDyaWHkq0D5pZBtt4V9h3Wk Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wrbrf7k08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Dec 2019 15:09:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9954110002A;
        Mon,  9 Dec 2019 15:09:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A66520DAFE;
        Mon,  9 Dec 2019 15:09:53 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 9 Dec
 2019 15:09:53 +0100
Subject: Re: [PATCH 2/3] ARM: dts: stm32: remove useless clock-names from RTC
 node on stm32f746
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191202145604.28872-1-benjamin.gaignard@st.com>
 <20191202145604.28872-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e1c2fe53-1b63-9b66-b48f-0c4dcc5e84ae@st.com>
Date:   Mon, 9 Dec 2019 15:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191202145604.28872-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 12/2/19 3:56 PM, Benjamin Gaignard wrote:
> On stm32f7 family RTC node doesn't need clock-names property.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f746.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index d26f93f8b9c2..3a8e2dc1978c 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -300,7 +300,6 @@
>   			compatible = "st,stm32-rtc";
>   			reg = <0x40002800 0x400>;
>   			clocks = <&rcc 1 CLK_RTC>;
> -			clock-names = "ck_rtc";
>   			assigned-clocks = <&rcc 1 CLK_RTC>;
>   			assigned-clock-parents = <&rcc 1 CLK_LSE>;
>   			interrupt-parent = <&exti>;
> 

Applied on stm32-next.

Thanks.
Alex
