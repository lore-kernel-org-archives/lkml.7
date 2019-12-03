Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A45AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97520659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uxij5SEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLCWK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:10:56 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3265 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:10:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de6dd710000>; Tue, 03 Dec 2019 14:10:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Dec 2019 14:10:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Dec 2019 14:10:53 -0800
Received: from [10.2.160.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 22:10:52 +0000
Subject: Re: [PATCH v1 11/17] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-12-git-send-email-skomatineni@nvidia.com>
 <20191203220727.GA22716@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <a91cd992-a3cd-1d33-d2a7-7f617f3246e9@nvidia.com>
Date:   Tue, 3 Dec 2019 14:11:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191203220727.GA22716@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575411057; bh=LPH3zXUwTaWfeUSAAlE2Mh6Y2Q53HmCDv53m3bnxiQA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Uxij5SEnpRFKFgg1onCr30pOyn/zSxJBrUwHARDApnh8Izvzmv9CrbYPeWX+yYjE8
         fvPjHsI8XvU2Tmq9j9fcg+PS553hmNSGtYsiTI/mEl2aNmgAf2o2OxPaVToxOyMjHS
         GDJ4w0TusRm+9VdVqJaQNUzFu2U8B99q+GygNYAK2sr9YViib9ZPjW3FkWNHvkySA2
         zB0XcG4droS3xu0TDT/EYQspNTcM0iVavHCBqaIK2qRdIJU5vdhvsB8/6rv4HQfC0V
         KNt4ri3FFHCbiJ0XyRWn54f6ZqpDn0BWU0sQRyDM/hn/ERw8OFlCdeyLyKKUk/vvgH
         mCGHpqyLlD63A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/19 2:07 PM, Rob Herring wrote:
> On Mon, Nov 18, 2019 at 10:50:28PM -0800, Sowjanya Komatineni wrote:
>> clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra pmc clocks.
>>
>> This patch removes ids for these clocks from Tegra clock dt-bindings.
> Your commit message should answer why, not what.
>
> This is not a backwards compatible change if any of these IDs are used.

Only Tegra210 samsung platform is using one of these clocks and this 
series includes samsung platform device tree update to change provider 
to PMC and use PMC clock ids.

Sure, Will update commit message to explain the reason for moving these 
clocks to PMC...

>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
>>   include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
>>   include/dt-bindings/clock/tegra20-car.h         |  2 +-
>>   include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
>>   include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
>>   5 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
>> index bb5c2c999c05..9175cd0571b5 100644
>> --- a/include/dt-bindings/clock/tegra114-car.h
>> +++ b/include/dt-bindings/clock/tegra114-car.h
>> @@ -270,10 +270,10 @@
>>   #define TEGRA114_CLK_AUDIO3 242
>>   #define TEGRA114_CLK_AUDIO4 243
>>   #define TEGRA114_CLK_SPDIF 244
>> -#define TEGRA114_CLK_CLK_OUT_1 245
>> -#define TEGRA114_CLK_CLK_OUT_2 246
>> -#define TEGRA114_CLK_CLK_OUT_3 247
>> -#define TEGRA114_CLK_BLINK 248
>> +/* 245 */
>> +/* 246 */
>> +/* 247 */
>> +/* 248 */
>>   /* 249 */
>>   /* 250 */
>>   /* 251 */
>> @@ -333,9 +333,9 @@
>>   #define TEGRA114_CLK_AUDIO3_MUX 303
>>   #define TEGRA114_CLK_AUDIO4_MUX 304
>>   #define TEGRA114_CLK_SPDIF_MUX 305
>> -#define TEGRA114_CLK_CLK_OUT_1_MUX 306
>> -#define TEGRA114_CLK_CLK_OUT_2_MUX 307
>> -#define TEGRA114_CLK_CLK_OUT_3_MUX 308
>> +/* 306 */
>> +/* 307 */
>> +/* 308 */
>>   #define TEGRA114_CLK_DSIA_MUX 309
>>   #define TEGRA114_CLK_DSIB_MUX 310
>>   #define TEGRA114_CLK_XUSB_SS_DIV2 311
>> diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
>> index 0c4f5be0a742..90a0c5e7eb5f 100644
>> --- a/include/dt-bindings/clock/tegra124-car-common.h
>> +++ b/include/dt-bindings/clock/tegra124-car-common.h
>> @@ -269,10 +269,10 @@
>>   #define TEGRA124_CLK_AUDIO3 242
>>   #define TEGRA124_CLK_AUDIO4 243
>>   #define TEGRA124_CLK_SPDIF 244
>> -#define TEGRA124_CLK_CLK_OUT_1 245
>> -#define TEGRA124_CLK_CLK_OUT_2 246
>> -#define TEGRA124_CLK_CLK_OUT_3 247
>> -#define TEGRA124_CLK_BLINK 248
>> +/* 245 */
>> +/* 246 */
>> +/* 247 */
>> +/* 248 */
>>   /* 249 */
>>   /* 250 */
>>   /* 251 */
>> @@ -332,9 +332,9 @@
>>   #define TEGRA124_CLK_AUDIO3_MUX 303
>>   #define TEGRA124_CLK_AUDIO4_MUX 304
>>   #define TEGRA124_CLK_SPDIF_MUX 305
>> -#define TEGRA124_CLK_CLK_OUT_1_MUX 306
>> -#define TEGRA124_CLK_CLK_OUT_2_MUX 307
>> -#define TEGRA124_CLK_CLK_OUT_3_MUX 308
>> +/* 306 */
>> +/* 307 */
>> +/* 308 */
>>   /* 309 */
>>   /* 310 */
>>   #define TEGRA124_CLK_SOR0_LVDS 311 /* deprecated */
>> diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
>> index b21a0eb32921..fe541f627965 100644
>> --- a/include/dt-bindings/clock/tegra20-car.h
>> +++ b/include/dt-bindings/clock/tegra20-car.h
>> @@ -131,7 +131,7 @@
>>   #define TEGRA20_CLK_CCLK 108
>>   #define TEGRA20_CLK_HCLK 109
>>   #define TEGRA20_CLK_PCLK 110
>> -#define TEGRA20_CLK_BLINK 111
>> +/* 111 */
>>   #define TEGRA20_CLK_PLL_A 112
>>   #define TEGRA20_CLK_PLL_A_OUT0 113
>>   #define TEGRA20_CLK_PLL_C 114
>> diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
>> index 44f60623f99b..a3d8d3e75728 100644
>> --- a/include/dt-bindings/clock/tegra210-car.h
>> +++ b/include/dt-bindings/clock/tegra210-car.h
>> @@ -304,10 +304,10 @@
>>   #define TEGRA210_CLK_AUDIO3 274
>>   #define TEGRA210_CLK_AUDIO4 275
>>   #define TEGRA210_CLK_SPDIF 276
>> -#define TEGRA210_CLK_CLK_OUT_1 277
>> -#define TEGRA210_CLK_CLK_OUT_2 278
>> -#define TEGRA210_CLK_CLK_OUT_3 279
>> -#define TEGRA210_CLK_BLINK 280
>> +/* 277 */
>> +/* 278 */
>> +/* 279 */
>> +/* 280 */
>>   #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
>>   #define TEGRA210_CLK_SOR0_OUT 281
>>   #define TEGRA210_CLK_SOR1_OUT 282
>> @@ -386,9 +386,9 @@
>>   #define TEGRA210_CLK_AUDIO3_MUX 353
>>   #define TEGRA210_CLK_AUDIO4_MUX 354
>>   #define TEGRA210_CLK_SPDIF_MUX 355
>> -#define TEGRA210_CLK_CLK_OUT_1_MUX 356
>> -#define TEGRA210_CLK_CLK_OUT_2_MUX 357
>> -#define TEGRA210_CLK_CLK_OUT_3_MUX 358
>> +/* 356 */
>> +/* 357 */
>> +/* 358 */
>>   #define TEGRA210_CLK_DSIA_MUX 359
>>   #define TEGRA210_CLK_DSIB_MUX 360
>>   /* 361 */
>> diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
>> index 3c90f1535551..20ef2462d9e1 100644
>> --- a/include/dt-bindings/clock/tegra30-car.h
>> +++ b/include/dt-bindings/clock/tegra30-car.h
>> @@ -230,11 +230,11 @@
>>   #define TEGRA30_CLK_AUDIO3 204
>>   #define TEGRA30_CLK_AUDIO4 205
>>   #define TEGRA30_CLK_SPDIF 206
>> -#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
>> -#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
>> -#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
>> +/* 207 */
>> +/* 208 */
>> +/* 209 */
>>   #define TEGRA30_CLK_SCLK 210
>> -#define TEGRA30_CLK_BLINK 211
>> +/* 211 */
>>   #define TEGRA30_CLK_CCLK_G 212
>>   #define TEGRA30_CLK_CCLK_LP 213
>>   #define TEGRA30_CLK_TWD 214
>> @@ -260,9 +260,9 @@
>>   /* 297 */
>>   /* 298 */
>>   /* 299 */
>> -#define TEGRA30_CLK_CLK_OUT_1_MUX 300
>> -#define TEGRA30_CLK_CLK_OUT_2_MUX 301
>> -#define TEGRA30_CLK_CLK_OUT_3_MUX 302
>> +/* 300 */
>> +/* 301 */
>> +/* 302 */
>>   #define TEGRA30_CLK_AUDIO0_MUX 303
>>   #define TEGRA30_CLK_AUDIO1_MUX 304
>>   #define TEGRA30_CLK_AUDIO2_MUX 305
>> -- 
>> 2.7.4
>>
