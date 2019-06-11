Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C708C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570612173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oBV1Z9Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407007AbfFKSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:19:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:19:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BIJWho063062;
        Tue, 11 Jun 2019 13:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560277172;
        bh=FjbeW6hQygWtg4Ftr4sb6KJZYE5ajtCT1MrP4b5Ra4w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oBV1Z9Nb5Q7kQwN/yOHuE3nYYbXU7V2J8ixmBG1IJ02pkhMSxh/y1QKGgUO7Lg+a/
         aa4I94OpjP9iX7r75qbDXVKqCqfOsFuJgUNiv4EL1a+AszO848vlvXUjdiEVIDIlRP
         bVWFLd+HVRtltJXL8zQn+2PL7sP3YaP1DUW31BDg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BIJWsh081807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 13:19:32 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 13:19:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 13:19:32 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BIJTAm015771;
        Tue, 11 Jun 2019 13:19:30 -0500
Subject: Re: [PATCH] arm64: configs: Enable GPIO_DAVINCI
To:     Keerthy <j-keerthy@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>
CC:     <lokeshvutla@ti.com>, <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190605061401.25806-1-j-keerthy@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <09a60289-2747-a570-54e0-822b0ea4b01a@ti.com>
Date:   Tue, 11 Jun 2019 21:19:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605061401.25806-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2019 09:14, Keerthy wrote:
> Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm64/configs/defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d1b72f99e2f4..57d7a4c207bd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -385,6 +385,9 @@ CONFIG_PINCTRL_QCS404=y
>   CONFIG_PINCTRL_QDF2XXX=y
>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>   CONFIG_PINCTRL_SDM845=y
> +CONFIG_DEBUG_GPIO=y

Why DEBUG_GPIO?

> +CONFIG_GPIO_SYSFS=y

Also, why GPIO_SYSFS?

Both of the above are nice for debugging purposes, but should not be 
enabled by default imho, as they are not needed by drivers.

> +CONFIG_GPIO_DAVINCI=y

I think you should not modify defconfig, rather add these as platform 
required features under arch/arm64/Kconfig.platforms?

-Tero

>   CONFIG_GPIO_DWAPB=y
>   CONFIG_GPIO_MB86S7X=y
>   CONFIG_GPIO_PL061=y
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
