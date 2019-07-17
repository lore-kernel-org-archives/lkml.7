Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54AC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E58217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wo7Jq2Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfGQK3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:29:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58314 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfGQK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:29:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190717102952euoutp01a4d9585c6a92fc4d4d5d1a947f8a751f~yKxWr8aRj0368903689euoutp01W
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190717102952euoutp01a4d9585c6a92fc4d4d5d1a947f8a751f~yKxWr8aRj0368903689euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563359392;
        bh=SDA5tD2P1J2Q7wZZ1hx8dTqvs0jbLs+PVjNuEh4MrGM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wo7Jq2JwCQZ3uZWrtCYpODfh1aA7R6YAYg7NmDNrvzlnkNEOvtFQWR2YF7NDUdeBj
         hiPNiIM2kB8FFmTC99bpkDfYJ0pnPV2jTrtZon8SlZk5xTaakutm+2JeVxmP9fbGlu
         2chXhxCYOH2o7wJs6G/FKFFzvofraUXJ3kzyuC+I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717102951eucas1p27d1f7239d6de753c8d62e83913fb3381~yKxVZO7n82944829448eucas1p2P;
        Wed, 17 Jul 2019 10:29:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.EB.04298.E98FE2D5; Wed, 17
        Jul 2019 11:29:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190717102950eucas1p17facbc79d951c4305f60df8ac6d567a2~yKxUmmoej2723227232eucas1p1i;
        Wed, 17 Jul 2019 10:29:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717102950eusmtrp2ab26d6fd408c395bc65ce131d4b75e62~yKxUYVHOR2136421364eusmtrp2B;
        Wed, 17 Jul 2019 10:29:50 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-a7-5d2ef89e2b48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.73.04140.E98FE2D5; Wed, 17
        Jul 2019 11:29:50 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190717102949eusmtip2b83dba6b3f3830bea72db3b9ad1feb3a~yKxTqqxIs1285512855eusmtip2_;
        Wed, 17 Jul 2019 10:29:49 +0000 (GMT)
Subject: Re: [PATCH v1 27/50] ARM: dts: exynos: align bus_wcore OPPs in
 Exynos5420
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
Message-ID: <701cbb66-17cb-9f32-1da4-4129a787fc7f@partner.samsung.com>
Date:   Wed, 17 Jul 2019 12:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfFZL8q9hM1vPsLq+Qxe-gMz4c8j0jgFKfdf5qs68MTmA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7rzf+jFGszfz2hxa905VouNM9az
        Wlz/8pzVYv4RILf/8Wtmi/PnN7BbnG16w26x6fE1VouPPfdYLS7vmsNmMeP8PiaLtUfuslss
        vX6RyeLiKVeL240r2Cxa9x5htzj8pp3V4t+1jSwOQh5r5q1h9Hh/o5XdY9OqTjaPzUvqPfq2
        rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj0u4TzAWfZSp+H/7F2MB4U6iLkZNDQsBE4tuTH0xd
        jFwcQgIrGCVuXtjPCuF8YZT49rmBBcL5zChx6WE/I0zL4wcwLcuBEjvnMEM4bxklHu54yApS
        JSwQIjHjTAsTiC0ioClx/e93sLnMAldZJH7c/w40l4ODTUBPYseqQpAaXgE3iZcte9lAbBYB
        VYkJG/aygNiiAhESl7fsYoSoEZQ4OfMJWJxTIFBi/f1FYPOZBcQlbj2ZD2XLS2x/C3GQhEAv
        h8Ss3itQZ7tIvP64mQnCFpZ4dXwLO4QtI/F/53yoeLFEQ+9CqPoaicf9c6FqrCUOH7/ICnIz
        M9Az63fpQ4QdJdav+M4EEpYQ4JO48VYQ4gQ+iUnbpjNDhHklOtqgQa0hsaXnAtQiMYnla6ax
        T2BUmoXksVlInpmF5JlZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEx7p/8d
        /7SD8eulpEOMAhyMSjy8Hod1Y4VYE8uKK3MPMUpwMCuJ8Np+1Y4V4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwOj2pXnFb9GUG/w8PlIlf14dak32/xux
        Y7LPtNpdticmFXsf4j4psizmkUDp8xiu5xUW0xun7tq3N05sqdBfnkCZm5P3Pq55t+/jBDMp
        /8ynE24cCBBj31Z/M+GLpM7r42U59xUDjC2nszNxpOs0bju+UeO+0roDK7bzTVGKzZ45W+36
        T+XV//YosRRnJBpqMRcVJwIAgm8tJXcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7rzfujFGmzYzGtxa905VouNM9az
        Wlz/8pzVYv4RILf/8Wtmi/PnN7BbnG16w26x6fE1VouPPfdYLS7vmsNmMeP8PiaLtUfuslss
        vX6RyeLiKVeL240r2Cxa9x5htzj8pp3V4t+1jSwOQh5r5q1h9Hh/o5XdY9OqTjaPzUvqPfq2
        rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
        SN8uQS/j0u4TzAWfZSp+H/7F2MB4U6iLkZNDQsBE4vGDH0wgtpDAUkaJdTvjIeJiEpP2bWeH
        sIUl/lzrYuti5AKqec0osfXMPEaQhLBAiMSMMy1gzSICmhLX/35nBSliFrjKIjHl1UZ2iI5+
        JonTGw4ydzFycLAJ6EnsWFUI0sAr4CbxsmUvG4jNIqAqMWHDXhYQW1QgQqKvbTYbRI2gxMmZ
        T8DinAKBEuvvLwJbxixgJjFv80NmCFtc4taT+VBxeYntb+cwT2AUmoWkfRaSlllIWmYhaVnA
        yLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMNK3Hfu5ZQdj17vgQ4wCHIxKPLweh3VjhVgT
        y4orcw8xSnAwK4nw2n7VjhXiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGASyiuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwLjtwJkDrMUaRpK8m6qi+Owidp0w
        sn2gfOnrK42Z5T2/WO/vnuz/+33VV3PfNBZ2lXu13oWZjTeFjaZHGZ2u4S2Paly/tS7/17FD
        h0XvXMqLuaRwQ+6qu13OI/avm3a41XJ03ljf5F25b/oN07Mn+f+mT1oVYMXI+jp/yld922kl
        xxmSJ+RtfarEUpyRaKjFXFScCAD/KiDwCgMAAA==
X-CMS-MailID: 20190717102950eucas1p17facbc79d951c4305f60df8ac6d567a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f
References: <CGME20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f@eucas1p2.samsung.com>
        <20190715124417.4787-1-l.luba@partner.samsung.com>
        <20190715124417.4787-28-l.luba@partner.samsung.com>
        <CAJKOXPfFZL8q9hM1vPsLq+Qxe-gMz4c8j0jgFKfdf5qs68MTmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/19 12:15 PM, Krzysztof Kozlowski wrote:
> On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This is the most important bus in the Exynos5x SoC. The whole communication
>> inside SoC does through that bus (apart from direct requests from CCI to
>> DRAM controller). It is also modeled as a master bus in devfreq framework.
>> It is also the only one OPP table throughout other buses which has voltage
>> values. The devfreq software controls the speed of that bus and other
>> buses. The other buses follows the rate of the master. There is only one
>> regulator. The old lowest OPP had pair 925mV, 84MHz which is enough for
> 
> s/lowest/slowest/
OK
> 
>> this frequency. However, due to the fact that the other buses follows the
>> WCORE bus by taking the OPP from their table with the same id, e.g. opp02,
>> the children frequency should be stable with the set voltage.
>> It could cause random faults very hard to debug.
>> Thus, the patch removes the lowest OPP to make other buses' lowest OPPs
> 
> s/lowest/slowest/
OK
> 
>> working. The new lowest OPP has voltage high enough for buses working up
>> to 333MHz. It also changes the frequencies of the OPPs to align them to
>> PLL value such that it is possible to set them using only a divider without
>> reprogramming OPP.
> 
> Reprogramming OPP? What is it?
Mistake, should be PLL. Thanks for that.
> 
>> Reprogramming the PLL was not set, so the real frequency
> 
> I understood from the previous that reprogramming the OPP (PLL?) was
> happening... Please rephrase entire sentence.
Yes, I will rewrite it when I will combine these patches into one.

Regards,
Lukasz
> 
> BR,
> Krzysztof
> 
>> values were not the one from the OPP table, which could confuse the
>> governor algorithms which relay on OPP speed values making the system to
>> behave weird.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index f8c36ff0d4c3..a355c76af5a5 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -1107,22 +1107,18 @@
>>                          compatible = "operating-points-v2";
>>
>>                          opp00 {
>> -                               opp-hz = /bits/ 64 <84000000>;
>> -                               opp-microvolt = <925000>;
>> +                               opp-hz = /bits/ 64 <150000000>;
>> +                               opp-microvolt = <950000>;
>>                          };
>>                          opp01 {
>> -                               opp-hz = /bits/ 64 <111000000>;
>> +                               opp-hz = /bits/ 64 <200000000>;
>>                                  opp-microvolt = <950000>;
>>                          };
>>                          opp02 {
>> -                               opp-hz = /bits/ 64 <222000000>;
>> +                               opp-hz = /bits/ 64 <300000000>;
>>                                  opp-microvolt = <950000>;
>>                          };
>>                          opp03 {
>> -                               opp-hz = /bits/ 64 <333000000>;
>> -                               opp-microvolt = <950000>;
>> -                       };
>> -                       opp04 {
>>                                  opp-hz = /bits/ 64 <400000000>;
>>                                  opp-microvolt = <987500>;
>>                          };
>> --
>> 2.17.1
>>
> 
> 
