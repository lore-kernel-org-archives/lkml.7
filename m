Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC4C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB1206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TKLz+vGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK0RG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:06:26 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14541 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0RGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:06:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddead120001>; Wed, 27 Nov 2019 09:06:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Nov 2019 09:06:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Nov 2019 09:06:23 -0800
Received: from [10.2.169.149] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 17:06:22 +0000
Subject: Re: [PATCH v2 06/11] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-7-git-send-email-skomatineni@nvidia.com>
 <22ab4e93-bf94-5c73-b4b9-6cf36d329b97@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <37bc8353-23c3-0ad6-6a91-acea6c2d041f@nvidia.com>
Date:   Wed, 27 Nov 2019 09:06:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <22ab4e93-bf94-5c73-b4b9-6cf36d329b97@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574874386; bh=yfFAgovfNlbjMD9teZVuzNd4RTYpPguSrjSnFEf5No0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TKLz+vGxVQYWB7gBouOFRzTXHcz9xZMw7RkQSXaPB2lPGvD1tRhYJkjo51h2kYL5m
         BDksMBDYV1QqtEY3C975oo0DF8G/XWX5UXJWxGKEwnCdEvOFyiourUPX6r6PSWmwbK
         xHPWya4J0HinoDFWb+8K+orAiI6oetHG08sGtrbzJ5daBFY/tdqgqDjg25U2KahlH7
         Fztq3AE2F/A98c5IHN1JYok6QzZauDmZoWjx4bdCvdIFuQ/JRnl6VBaqN4D7Mqmq2u
         Z1NcAZt3SQerlzYtLS/sA/J2oWh5QNJXjiU6bl1hsJtN0aqvcwuI6PljqhE6KqH/GT
         kfmlDe6AS+Hsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/19 6:32 AM, Dmitry Osipenko wrote:
> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra pmc clocks.
>>
>> This patch removes ids for these clocks from Tegra clock dt-bindings.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
>>   include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
>>   include/dt-bindings/clock/tegra20-car.h         |  2 +-
>>   include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
>>   include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
>>   5 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindi=
ngs/clock/tegra114-car.h
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
>> diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/d=
t-bindings/clock/tegra124-car-common.h
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
>> diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindin=
gs/clock/tegra20-car.h
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
>> diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindi=
ngs/clock/tegra210-car.h
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
>> diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindin=
gs/clock/tegra30-car.h
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
>>
> This a device-tree ABI breakage and I'm not sure that it's okay to break
> older device-trees (Pixel C Smaug board), maybe some kind of fallback is
> needed.

As provider itself changed from tegra_car to pmc, all platform=20
device-trees using CLK_OUT_1/2/3 ids from Tegra car should be moved to=20
PMC and use PMC clock ids.

Based on upstream device tree search, I only see samsung t210 device=20
tree currently using CLK_OUT_2. So updated that as part of this series.

