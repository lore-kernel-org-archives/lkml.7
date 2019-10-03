Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625D9217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UuKcnYOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfJCKef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:34:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13158 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729466AbfJCKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:34:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93AVScS009886;
        Thu, 3 Oct 2019 12:34:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=lzOYBhAfnBcaEOuQ4FsCPxcaUazDlQqNyGCAqbms35c=;
 b=UuKcnYOLaOGuL0Jnl42Nuj/vTBvssVeWY0GmhV75H7g3Z264h+YwXcqzvw2iXzK8vJo8
 XgXG/HO97QayKRMm8RvzDS2M3KSGkpxwU3kJq/sed2nnwa2BV1c+w+IvUtxb7THmrPat
 /oGOPZibvOgKNii7sPgUnY3tCLsHWvQihDsWF/iD9KOgx1awwEZN8Lj9u/KQsChjcncY
 g7l3ba3b9jOg57BvDktTDWfHaXlIWa+5I4wWwFqcVylfYo5zmezCc433OG9az9X3q5Tg
 Dcoa4OPHaWrdMo4XZWCrtqquH367Gu6izJYbARSR9MWtQPgVtUHw5L3uL6I5j8uLwTSq hw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9vnam43h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:34:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A1C3B4C;
        Thu,  3 Oct 2019 10:34:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9DD1F2B9881;
        Thu,  3 Oct 2019 12:34:18 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Oct
 2019 12:34:18 +0200
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
References: <1569854751-22337-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <09ad1310-ebc5-7a41-7af6-cdef79f20802@st.com>
Date:   Thu, 3 Oct 2019 12:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569854751-22337-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-03,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 9/30/19 4:45 PM, Yannick Fertré wrote:
> Enable focaltech ft6236 touchscreen on STM32MP157C-DK2 board.
> This device supports 2 different addresses (0x2a and 0x38)
> depending on the display  board version (MB1407).
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-dk2.dts | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> index 20ea601..527bb75 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> @@ -61,6 +61,29 @@
>   	};
>   };
>   
> +&i2c1 {
> +	touchscreen@2a {
> +		compatible = "focaltech,ft6236";
> +		reg = <0x2a>;
> +		interrupts = <2 2>;
> +		interrupt-parent = <&gpiof>;
> +		interrupt-controller;
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <800>;
> +		status = "okay";
> +	};
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

I'm not confident by this duplication. We should only support the latest 
revision of the MB1407. I understand the need but my fear is to 
duplicate this node each time we have a new revision (and imagine if we 
do that for all i2c devices).

regards
alex


>   &ltdc {
>   	status = "okay";
>   
> 
