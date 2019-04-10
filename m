Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D24C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Icw51xOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfDJNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:55:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22276 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730195AbfDJNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:55:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ADkutR012977;
        Wed, 10 Apr 2019 15:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=ptShkr2k7ppyYd5EpbQvWQsiZ+9sGpu+CyKQ5hwtgKY=;
 b=Icw51xOQOnpZOFMW/5HPPOc3Lvumrm1G4pdUVhwUZWDOzzVeeVl+AxdmAwJuUGEOYkM9
 klYUDjHt87P2ZXChDihA+RRCv2Q4LT3JXor1dcaKVlHwkAYaitnv7KwgHKsDuGHv1hbC
 ewt9O+CaQOh7XCnyrRlzK+CPpk/IX6v1Zm1TeBYZP1BaubsL+WKMrgbb9TpWUDGt9WVZ
 F1AQphlYYoF9ZM8aEV62DILiX3JBuL8KeXr4QBCeEyQ2ekeGBz4MtNFSAZcV0FXu8gJa
 QAonb9rZfyit3NRHXCVczuoIrUPQaAmHR8EwGumcV8C6X2Hen5efMfZDSVLKjoTpJXZN Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rprcfg9u3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 15:55:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 961453F;
        Wed, 10 Apr 2019 13:55:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EA6C24E6;
        Wed, 10 Apr 2019 13:55:28 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 15:55:27 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add power supply of otm8009a on
 stm32mp157c-dk2
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <1553854406-28992-1-git-send-email-yannick.fertre@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <757bcb50-0a4e-68e3-521f-997185196ac3@st.com>
Date:   Wed, 10 Apr 2019 15:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553854406-28992-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On 3/29/19 11:13 AM, Yannick Fertré wrote:
> This patch adds a new property (power-supply) to panel otm8009a (orisetech)
> on stm32mp157c-dk2  & regulator v3v3 which is always set on until the
> implementation of regulator driver.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-dk2.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> index 363aeb9..20ea601 100644
> --- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
> @@ -50,6 +50,7 @@
>   		compatible = "orisetech,otm8009a";
>   		reg = <0>;
>   		reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
> +		power-supply = <&v3v3>;
>   		status = "okay";
>   
>   		port {
> 

Applied on stm32-next. I just updated the commit message as regulator 
fixed hook is no more used due to stpmic1 merge.

Thanks.
Alex
