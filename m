Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B363C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217D3222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iNoBCSQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389007AbfJDOFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:05:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388149AbfJDOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:05:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94DphSn032172;
        Fri, 4 Oct 2019 16:05:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=+37tYreV7tZjGivq3lYs5eVtMuF7z9GI89L7hwCaTGg=;
 b=iNoBCSQJEHje/AKpfU6DnVH4WWKPpMLuUGe+FMd39vrZpwjkqwwkNejC4Oid9Qrtxjaq
 yu0omMn5fEoKMTDtmOupHUciiVQj8JjZPFGMlhv69BkyTrYKg1hwnwjeMTPche3a3TBp
 7+LLr7BnPXhX3L9hH4yUTndhi/mU/IfFq++ooPvI2rzxrwPmV2ryj1pn2qeNA5jN4+fT
 OKD0wVZqEuRGOoyS0HlJcqlrj+ZwctTYFwLSRX5/TukG97SBhhdQr4Z5sKYkVAVgTnus
 CUWbaZe7XOk80jsqqDzKAs974owrhRJvITHj86GuaePbnwrEMtaFLHC+Y9lFBV2SH+Qb 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v9w9wbd3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 16:05:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50B7E10002A;
        Fri,  4 Oct 2019 16:05:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B7C32C6CED;
        Fri,  4 Oct 2019 16:05:15 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 4 Oct
 2019 16:05:14 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add focaltech touchscreen on
 stm32mp157c-dk2 board
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
References: <1570195022-23327-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c834748b-17f3-39ca-041b-1be86ad61d76@st.com>
Date:   Fri, 4 Oct 2019 16:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570195022-23327-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_07:2019-10-03,2019-10-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yannick

On 10/4/19 3:17 PM, Yannick Fertré wrote:
> Enable focaltech ft6236 touchscreen on STM32MP157C-DK2 board.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-dk2.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> index 20ea601..d44a7c6 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> @@ -61,6 +61,19 @@
>   	};
>   };
>   
> +&i2c1 {
> +	touchscreen@38 {
> +		compatible = "focaltech,ft6236";
> +		reg = <0x38>;
> +		interrupts = <2 2>;
> +		interrupt-parent = <&gpiof>;
> +		interrupt-controller;
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <800>;
> +		status = "okay";
> +	};
> +};
> +
>   &ltdc {
>   	status = "okay";
>   
> 

For the next time, please don't forget to add "PATCH-v2" as it is a 
second version of this patch.

Applied on stm32-next.

Thanks.
Alex
