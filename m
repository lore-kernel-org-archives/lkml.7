Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAA3C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DE8208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T0ACcPj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfGRF0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:26:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49349 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:26:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718052637euoutp0185cc7d9c084f272b352e6728c5cb4a50~yaR3tQl5h2795927959euoutp01f
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:26:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718052637euoutp0185cc7d9c084f272b352e6728c5cb4a50~yaR3tQl5h2795927959euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563427597;
        bh=VqyitIjmHvd1mFt9nd0wLsDdOiN5IPoLZWqZmuqK4ow=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=T0ACcPj0kHSwPk9EgVyIF1GKa++mbBorSKnB1H8nVOmKIYqmtGjuqPyvPK/PrZ+25
         s3Qeqdnypvmu0B4gGD6jMMoa+c/DFYmgjijFrBqzgAQf3IcEfyBdFEyL5i8bIlK91G
         M0IrHvYiEvlxXLhFKA5oePoLkDs//Zp5D6MZUkww=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718052637eucas1p1567714f8a8eb509d67286b296b342931~yaR3AAz9R1478114781eucas1p1C;
        Thu, 18 Jul 2019 05:26:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.10.04298.C03003D5; Thu, 18
        Jul 2019 06:26:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718052636eucas1p206de16a320293650767d73f1b7dd7da9~yaR18a2gT1160411604eucas1p20;
        Thu, 18 Jul 2019 05:26:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718052635eusmtrp2a01cb3b315ae1f78c419969913863525~yaR1toZgF1475514755eusmtrp2p;
        Thu, 18 Jul 2019 05:26:35 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-2e-5d30030cbde6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.3D.04146.B03003D5; Thu, 18
        Jul 2019 06:26:35 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718052634eusmtip1cb652b3ec0e7b62a46944508f69ee866~yaR07zQdm2410324103eusmtip1U;
        Thu, 18 Jul 2019 05:26:34 +0000 (GMT)
Subject: Re: [PATCH v1 02/50] clk: samsung: add IDs for Exynos5420 NoC
 clocks
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <5d3d1cb0-15db-8332-ee6d-946e2906fb87@partner.samsung.com>
Date:   Thu, 18 Jul 2019 07:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <b8503015-732f-7ac5-1b25-50e943d27e55@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUURTHvfPem3lKE9dR81RSMhQtmKMYdaXIopTpQ2TLhzAsR32Mlo42
        Ty1byCytRs0oUpsylTKnSR13TNoYRVFxS3Nr0dDItCEsgxayfD4jv/3+5/zPdrkspRhilrCR
        ujhOr9NEKaUOdE3jj/Z1CyivYK+h5g1ksLSdIeU5Fob0TX1gSF7DjMwcmaBIR0eZjLQlf5KR
        ipFehkymv2VId91tKcnpeCohJQ1vZKSwr0tCulr8yatzJilJedIgI/WfLjJkurec3qpQF98p
        RurP/SkydYX5slRdee+s+kqVGam/ViwLlAY5bA7noiITOL1qS4hDRF/PLyr2s8uJ+hsvURK6
        rjAglgW8Hi5c8DEgB1aBTQimzO8oUUwh+GF+JjEg+xnxFcFvQ4DAQoGhrEUqmooQVP4x0aKw
        Ieg3PmcElxPeDabXrbMuZ9yC4NywYbYVhbMkYLzjIsyWYk+oNR8TUI4DIDXVWUAar4TBfB/B
        7IIPQHdVHRJYjh2h+eYoLbA99oO0dotMbOgKg6N5c82Xw/nqW5S4ZwoLOcWsyDugJDsPiewE
        401VMpHd4M8jsRYwD0kZBXOe0zCSmTvn2QT1TV2MsBqF14ClTiWGt0GnzSYV33Ah9NscxQ0W
        wrWabEoMy+FSqkJ0r4aq9M65QYugqDhLdhUpjfPuMs67xTjvFuP/ufmINiNXLp6P1nK8t447
        7slrovl4ndYzLCa6As18u9bppi+16NuLUCvCLFIukCe5q4IVjCaBT4y2ImAppbP81ceZkDxc
        k3iS08cc1sdHcbwVLWVppav8lN3wQQXWauK4oxwXy+n/ZSWs/ZIktGqvdc/dnWO2rRKPXfLG
        NHfH/cNeA5QquxJ6f2Z6eBd5D/gm0r66+ytCVIl7PYd66Oq2BNX2U7klRyYl065nAifshov2
        jYdexzvjNj7Efo8LLf4D7zMGUViy7/eCq4GL35tsee6HHpzILyc+ha1jo+Nupdrz5E1tjDYo
        LfP0kzIlzUdovNdSel7zFw34wy5yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7rczAaxBj1tmha31p1jtdg4Yz2r
        xfUvz1kt5h8Bcvsfv2a2OH9+A7vF2aY37BabHl9jtfjYc4/V4vKuOWwWM87vY7JYe+Quu8XS
        6xeZLC6ecrW43biCzaJ17xF2i8Nv2lkt/l3byOIg5LFm3hpGj/c3Wtk9Nq3qZPPYvKTeo2/L
        KkaPz5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL
        9O0S9DKuX/nNXPBetOLw1KuMDYyThboYOTkkBEwkujacYuti5OIQEljKKPHm834WiISYxKR9
        29khbGGJP9e6oIpeM0r8vNIClhAW8JX4cHMOK0hCROAUo0T3o8VsIAlmgWlMEifWM0N0/GGU
        OLGylbGLkYODTUBPYseqQhCTV8BNoq1NBMRkEVCVuLXAGKRTVCBCoq9tNtgUXgFBiZMzn4Dd
        wylgL9F9bj07xHQziXmbHzJD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJxvO/Zz8w7GSxuDDzEKcDAq8fDeUNKPFWJNLCuu
        zD3EKMHBrCTCe/slUIg3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgSkoryTe0NTQ3MLS0NzY
        3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY8troQ9Kc0T+V6y+fcl75XzpqRarg3Z/
        yueYFu+yqW5d72yTnYv7LGuj3ORdHfqktMIudTiv61531avxUXWlDpfBl9395ffSNfan34k9
        t5d7yqyyu3vmKy68Gm/69uSKduX7mieyvwr6RzOzzZablyB8xnByT5lT2npHySNBaTFebt/Z
        PnivU2Ipzkg01GIuKk4EAKFDpmYJAwAA
X-CMS-MailID: 20190718052636eucas1p206de16a320293650767d73f1b7dd7da9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124435eucas1p2099cd7670a3d85d9b11eb0ff86041a2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124435eucas1p2099cd7670a3d85d9b11eb0ff86041a2a
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124435eucas1p2099cd7670a3d85d9b11eb0ff86041a2a@eucas1p2.samsung.com>
        <20190715124417.4787-3-l.luba@partner.samsung.com>
        <b8503015-732f-7ac5-1b25-50e943d27e55@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/19 11:26 AM, Chanwoo Choi wrote:
> Hi,
> 
> You don't need to make the separate patches according to
> the type of clock just in order to add the ID by handling them
> from devicetree.
> 
> Please merge following patches to one patch
> - patch2, patch4~patch7, patch9, patch11, patch12, patch14, patch17
> and separate from patch13, patch15, patch16 for adding the ID
I agree. The patches will be squashed.

Regards,
Lukasz
> 
> 
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> The patch adds NoC WCORE clock IDs needed used for changing parent of the
>> main NoC clock from the DT device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 16ad498e3f3f..d353870e7fda 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -463,7 +463,8 @@ static const struct samsung_fixed_factor_clock
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
>>   	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
>> -	MUX(0, "mout_aclk400_wcore", mout_group2_5800_p, SRC_TOP0, 16, 3),
>> +	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
>> +			SRC_TOP0, 16, 3),
>>   	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
>>   
>>   	MUX(0, "mout_aclk333_432_gscl", mout_group6_5800_p, SRC_TOP1, 0, 2),
>> @@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>>   
>>   	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
>>   	MUX(0, "mout_aclk400_mscl", mout_group1_p, SRC_TOP0, 4, 2),
>> -	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
>> +	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
>> +			SRC_TOP0, 16, 2),
>>   	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
>>   
>>   	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
>> @@ -674,8 +676,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   			SRC_TOP10, 8, 1),
>>   	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
>>   			SRC_TOP10, 12, 1),
>> -	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
>> -			SRC_TOP10, 16, 1),
>> +	MUX(CLK_MOUT_SW_ACLK400_WCORE, "mout_sw_aclk400_wcore",
>> +			mout_sw_aclk400_wcore_p, SRC_TOP10, 16, 1),
>>   	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
>>   			SRC_TOP10, 20, 1),
>>   	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
>>
> 
> 
