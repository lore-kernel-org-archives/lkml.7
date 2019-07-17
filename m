Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19881C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73842173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k+bk1l3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfGQKjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:39:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51203 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGQKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:39:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190717103902euoutp02e5827ee711785f2373448d4ee8dbea10~yK5WhsFnK2358423584euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:39:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190717103902euoutp02e5827ee711785f2373448d4ee8dbea10~yK5WhsFnK2358423584euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563359942;
        bh=n/O1iH//eg1hXaXIsO8ffDEceYDqcTYk3gkfWOJ+At0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k+bk1l3nXmLa1N3BEBtDGyzhkRu5VQLnpH6jTPsn1X9MQRJ+rjWPYZ8qkMl+Xr8R2
         bRzqv9cZk21f0/wxcLZ4DLBpNgDzcDHdhB3qugGFD9U795HqzEcA0H4dhL2nx6XLVv
         iLjdvYs+67LNmOG99J9QGgZC+7BRy5Jgj4Wn2Ohg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190717103901eucas1p1473bf92a00385623eb2cc4d8c5929b97~yK5VmSP0b1190111901eucas1p1S;
        Wed, 17 Jul 2019 10:39:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E0.5A.04377.4CAFE2D5; Wed, 17
        Jul 2019 11:39:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190717103900eucas1p1149a22f44bea2fab99df0497f3375110~yK5U3mLgr1067810678eucas1p1O;
        Wed, 17 Jul 2019 10:39:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717103900eusmtrp2b4f9a0d2ea1840611eb6e89bd60b64b2~yK5U233uT2767127671eusmtrp2J;
        Wed, 17 Jul 2019 10:39:00 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-7a-5d2efac4cc58
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.0D.04146.4CAFE2D5; Wed, 17
        Jul 2019 11:39:00 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190717103859eusmtip28c7d76622c4b02c00b8e5ce75050104e~yK5UBJiJP2262822628eusmtip2S;
        Wed, 17 Jul 2019 10:38:59 +0000 (GMT)
Subject: Re: [PATCH v1 37/50] ARM: dts: exynos: change parent and rate of
 bus_fsys in Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <2fe2e840-f4b2-773b-7d92-4ffb8502d4e6@partner.samsung.com>
Date:   Wed, 17 Jul 2019 12:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTYRCG/bq73aWxZCkoEzyITYwgoSgx8sUDlKDpL6Pxj4qIi65A5OwK
        3ooGPAABT7AeiMGAlcNWFGyAKIcERA4RMKCClIREwCNUkVNpt0b+vTPzzPEmwxAKE+XChEcd
        4jVRXIRSKiOfvRpr8qwdVwWtqEmR4K6iJgrrs4op3GkeoHB2zUyYbhokcHPzYxq/OTtEY4Op
        g8I/Uj9RuM14W4qzmisluLDmI40fdLZKcGvDJtx9Jl+KkypqaFw9dJ7C0x16coNCXXC3AKm/
        vU+i1QbdRan6Se5pdVqJDqlHDIu3SnfJ1u3nI8LjeY2X715ZWJpBiLmqONJXOUwmoGL7ZGTH
        ALsKcsvuSZKRjFGw+Qg+Jz6ixMCMYLrljVQMRhBkDr2V/mtJ1b+gxUIegvrSr7b+YQSFV++T
        FsqRDYGG8kHCop1Yd+icGrXOJdh2En73jM5ADCNlVVCmi7UwcnYzTIzfsvIkuxRyG420Rc9j
        d0BbiRGJjAPU3+y3zrdjt0FGS7+VJ1hn6OrPlojaFUqHbxOWXcAmMdCUXIXEswNAl1Nrs+AI
        X+pKaFEvhD/PxWZgBUi4lGPjT4Ap/Y6NWQvVda2U5WZixkyx0UtMb4TrLQPWNLD28H7YQTzB
        Hq48yyTEtBwunFOItBuUpLbYFs2HvIIbdAZSamcZ084yo51lRvt/7z1E6pAzHydEhvKCdxR/
        WCVwkUJcVKhqX3SkAc283uvpOnMZMk6GVCGWQcq5cnW1Z5CC4uKFo5FVCBhC6SRf/9MjSCHf
        zx09xmuigzVxEbxQhRYwpNJZfnxOb6CCDeUO8Qd5PobX/KtKGDuXBJSzs2go9qV//I8TfuXB
        H/jQa5n5tXMl1KLCtEb90sQMbtrn1+oKBxdz6/x3Y4UJIWVPw4M2bNmzY/Syx0j4gUB/j/be
        bDLFNYarVAaavZdFu6/pW65S7R6Q8Snd3092Bjjd8SvKWjLR2JD41deNMJ6f4gIeH+lyvnmq
        Z9Jn68PtTq5KUgjjVi4nNAL3F0DMQQJ2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7pHfunFGtxdLm1xa905VouNM9az
        Wlz/8pzVYv4RILf/8Wtmi/PnN7BbnG16w26x6fE1VouPPfdYLS7vmsNmMeP8PiaLtUfuslss
        vX6RyeLiKVeL240r2Cxa9x5htzj8pp3V4t+1jSwOQh5r5q1h9Hh/o5XdY9OqTjaPzUvqPfq2
        rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
        SN8uQS+jb1NxwWShikf73rI0MK7n62Lk5JAQMJHo2XiAvYuRi0NIYCmjxKY3T5khEmISk/Zt
        Z4ewhSX+XOtigyh6zSjxbM0SFpCEsECSxKk9r8EaRAQ0Ja7//c4KUsQscJVFYsqrjVBj+5kk
        Zt6fxNjFyMHBJqAnsWNVIUgDr4CbxO9fs8GaWQRUJZac2QW2TVQgQqKvbTYbRI2gxMmZT8CW
        cQoESky48ASsnlnATGLe5odQtrjErSfzmSBseYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMNK3Hfu5eQfjpY3BhxgFOBiVeHg9DuvGCrEmlhVX
        5h5ilOBgVhLhtf2qHSvEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAklFcSb2hqaG5haWhu
        bG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTGoNPbOLJVSy0S32TxqyVqZzlcFmS2/
        LAri3RZ/YZZm49fr1qIn/JWEN/rFKUy0LI6sVjw59yf7rINbI6/PqtEOKkoP1mOUYz/VkyOc
        ll5ftLu3o6eCYRLHx7JkvdwrFrxZW5dctZ2n2/x3RaSu5qFlle3z/hhpVQQw3F/hJBN4bbbw
        Oj4VJZbijERDLeai4kQAKdfivAoDAAA=
X-CMS-MailID: 20190717103900eucas1p1149a22f44bea2fab99df0497f3375110
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf
References: <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
        <20190715124417.4787-1-l.luba@partner.samsung.com>
        <20190715124417.4787-38-l.luba@partner.samsung.com>
        <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/19 12:25 PM, Krzysztof Kozlowski wrote:
> On Mon, 15 Jul 2019 at 14:45, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The FSYS bus OPP table has been aligned to the new parent rate. This patch
>> sets the proper parent and picks the init frequency before the devfreq
>> governor starts working. It sets also parent rate (DPLL to 1200MHz).
> 
> 1. I see what the patch is doing, but please write why you are doing
> this. What problem are you solving here?
> 2. Commit title is wrong - it is not Exynos 5422 but Odroid XU3/XU4
> family of boards.
OK, I will rewrite it when during the work on squashing the patches.
> 
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index d460041f716c..6a82dd175b8a 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -72,6 +72,11 @@
>>
>>   &bus_fsys {
>>          devfreq = <&bus_wcore>;
>> +       assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
>> +                         <&clock CLK_DOUT_ACLK200_FSYS>,
>> +                         <&clock CLK_FOUT_DPLL>;
>> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
>> +       assigned-clock-rates = <0>, <240000000>,<1200000000>;
> 
> Here and in all other patches:
> I am not entirely sure that this should be here. It looks like
> property of the SoC. Do we expect that buses will be configured to
> different clock rates between different boards? Since the OPP tables
> are shared (they are property of the SoC, not board) then I would
> assume that default frequency is shared as well.
These clocks they all relay on some bootloader configuration. It depends
which version of the bootloader you have, then you might get different
default configuration in the clocks. The pattern of changing the parent
or even rate is known in the DT files (or I am missing something).
When you grep for it, you get 168 hits (38 for exynos*):
git grep -n "assigned-clock-rates" ./arch/arm/boot/dts/ | wc -l

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
> 
