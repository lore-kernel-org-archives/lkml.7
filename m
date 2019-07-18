Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA8C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ED82173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K3fpAW5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfGRGFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:05:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56374 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfGRGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:05:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718060503euoutp0127e7cdbbd2929ffe051244ce716b9846~yazbMpm8I2618326183euoutp012
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:05:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718060503euoutp0127e7cdbbd2929ffe051244ce716b9846~yazbMpm8I2618326183euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563429903;
        bh=ejYldofp/ftAAUP8++/HWz53g5Xe+2N2cdIjI2Xaw/w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K3fpAW5Xgeffm4d/rbOANmeq9aygYF03E6Xj9tST1JWvOn/aG2G6j7rZpfVkgjxFW
         t4rlr/qiUlqyVdn7LmDDZGrYCGfViAJAVzm7NxBHKjn3u4JHu1xfBSTAw/sC2qA8ez
         XPy2gLYsIkM9mF68iBgrgRtpYcZpi+zTjA1Mw4jE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718060502eucas1p1e8eba8bd897f6d408880bb4c955863de~yazaZJeXZ2232222322eucas1p1r;
        Thu, 18 Jul 2019 06:05:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.AD.04325.E0C003D5; Thu, 18
        Jul 2019 07:05:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060501eucas1p29de29ef5bf19f66880bcf57c50b268bc~yazZU4nJb1633816338eucas1p2n;
        Thu, 18 Jul 2019 06:05:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718060501eusmtrp106081c9c8999e11b3dd18047d6d43625~yazZGn7Oy1082210822eusmtrp1y;
        Thu, 18 Jul 2019 06:05:01 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-a9-5d300c0efd51
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.4F.04146.D0C003D5; Thu, 18
        Jul 2019 07:05:01 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060500eusmtip24b38c5578cae4cd1653f1609dc353f81~yazYYCMNP2022720227eusmtip2b;
        Thu, 18 Jul 2019 06:05:00 +0000 (GMT)
Subject: Re: [PATCH v1 08/50] clk: samsung: change aclk266_isp clocks
 definitions Exynos5420
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
Message-ID: <f42696bc-4bc7-3ad8-9507-e12952159fff@partner.samsung.com>
Date:   Thu, 18 Jul 2019 08:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5ac878fa-21c8-afcd-9afe-13ed3cd36afb@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzHfe/3yO70c8gnNbXboqxOrf74binVqt1frUfTg3LlN5SHul8n
        lDqhYsIo6fKQpthNRJdMmJwxFN00Gj2oo0fV2rFlyfLb71r+e73fn/fn+/l8ti9LKG2UNxsV
        e4rXxWqjVbQLWd8x1bvSVb4qdNW7x0vxUHUvhWsLayg8OPGRwqXtszLH9pXAfX33GfzswjiD
        62wDFP6Z9YbC/Y1FNC7sa5Hhe+2vGXxn0CrD1u6teDilksbpze0MtoxfovDMQC25UampKqlC
        mh8v0xlNnSmD1jwoP6/JNpuQxl7ns4Pe7xIYzkdHxfO6gA1hLpHlnyvpE72+Ca8MjwgDKlqS
        iZxZ4NZC2Z0pJhO5sEquEkH1rxxKEhMI0r5YaEnYEfQ1jtH/WvJynpJSoQKBveWPQ3xDUPv2
        w6xgWXfuEDy4vEv0PbhuBCkjmTKxm+AKZGAs8RQzNKeGBtNJ0VZw2+BmroUQmeSWwph9ghHZ
        kwuBfnMjkjJu0HVjlBTZmQuCEvMnQnrSC4ZGSx3PL4bUhzcJcS5wGSyMpDQjaestkFJcyUjs
        Dl86zQ5eBD35WaTEAhiulDnyZ8GWU+zIrANLp5USdya45VDTGCDZm2AwK5sRbeBc4eU3N2kF
        V8irv05ItgIuX1RK6WVgznouk3g+VFQVMLlIZZxzmHHOMcY5xxj/z72FSBPy4vVCTAQvrInl
        T6sFbYygj41QH42LqUOzX69npnOyAbVMH2lDHItUcoVhSUCoktLGC4kxbQhYQuWhGP48aynC
        tYlJvC7usE4fzQttaCFLqrwUZ5xGDii5CO0p/jjPn+B1/6oy1tnbgBZYEqx/NlNoiPKe3D7l
        G+wWrz5XMKO2X/X1S4oruyZ3Cnsl72rIGH7CxunHc2uPrdg7Lz3td2rUXeuL29Wpu/33pede
        Skrek9ba45NfH3i6qclUtD5RHvY+tKP96aD/o7wQlCzbH+nZFHzY6uTh5x40/bPTduj9zp7v
        rVRpUfboQRUpRGpX+xM6QfsXKcgPgXYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7q8PAaxBn8WSFvcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BZL
        r19ksrh4ytXiduMKNovWvUfYLQ6/aWe1+HdtI4uDkMeaeWsYPd7faGX32LSqk81j85J6j74t
        qxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst
        0rdL0MtY8nIFW8E5tYo7DduZGxjnKHQxcnJICJhITOo/w9LFyMUhJLCUUeL3nR+MEAkxiUn7
        trND2MISf651sYHYQgKvGSVWntbrYuTgEBaIk9jcEQTSKyJwilGi+9FisBpmgWlMEifWM0MM
        /cMosbztJhNIA5uAnsSOVYUgNbwCbhKzJxxmBrFZBFQlnn7+ArZLVCBCoq9tNhtEjaDEyZlP
        WEBsTgF7iXlbXjBDzDeTmLf5IZQtLnHryXwmCFteonnrbOYJjEKzkLTPQtIyC0nLLCQtCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG+bZjPzfvYLy0MfgQowAHoxIP7w0l/Vgh1sSy
        4srcQ4wSHMxKIry3XwKFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YgvJK4g1NDc0tLA3N
        jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTB2nFxZIOfjG9by/Df7ZfdF28w4bOe+
        WiPkm2x+0qlX5h1nz8kfi2Qz2Cp+n/6zwWjB1Ften1V/pHb0XfSdftqiwXqDstOhmjOZTVKu
        Dq4smSu57l97qXZmSsXr+5f8pKQ2BMU5br/Ve+SQrWuO9pIQjRtf2m4l3ojbznTGOXEHr/fl
        3Q5z99UpsRRnJBpqMRcVJwIAnh57vwkDAAA=
X-CMS-MailID: 20190718060501eucas1p29de29ef5bf19f66880bcf57c50b268bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124440eucas1p10bb25e412f32f0da95761f96831893e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124440eucas1p10bb25e412f32f0da95761f96831893e6
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124440eucas1p10bb25e412f32f0da95761f96831893e6@eucas1p1.samsung.com>
        <20190715124417.4787-9-l.luba@partner.samsung.com>
        <5ac878fa-21c8-afcd-9afe-13ed3cd36afb@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 7/16/19 12:22 PM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> The ACLK266_ISP has different topology in Exynos5420 and 5422/5800.  In
>> Exynos5420 this clock does not have dedicated MUX which chooses PLL instead
>> it takes the clock from 2-level mux from ACLK266.  In Exynos5422 there is a
>> dedicated clock tree and the PLL can be chosen.  The patch adds needed
>> MUXes in the exynos5800_mux_cloks, updates exynos5x_mux_clks and
>> exynos5420_mux_clks properly. It also adds IDs to mange these clocks from
>> DT.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 9d54856dbcda..5f251279b4c8 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -432,6 +432,10 @@ PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>>   PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>>   					"mout_sclk_mpll", "ff_dout_spll2",
>>   					"mout_sclk_spll", "mout_sclk_epll"};
>> +PNAME(mout_group17_5800_p)	= { "dout_aclk266_isp", "dout_sclk_sw" };
>> +PNAME(mout_group18_5800_p)	= { "dout_osc_div", "mout_sw_aclk266_isp" };
>> +PNAME(mout_group19_5800_p)	= { "mout_sclk_cpll", "mout_sclk_dpll",
>> +					"mout_sclk_mpll", "mout_sclk_ipll"};
>>   
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock
>> @@ -494,6 +498,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>   	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>   
>> +	MUX(CLK_MOUT_ACLK266_ISP, "mout_aclk266_isp", mout_group19_5800_p,
>> +			SRC_TOP8, 12, 2),
>>   	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>>   	MUX(0, "mout_aclkfl1_550_cam", mout_group3_5800_p, SRC_TOP8, 20, 3),
>>   	MUX(0, "mout_aclk432_cam", mout_group6_5800_p, SRC_TOP8, 24, 2),
>> @@ -501,6 +507,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   
>>   	MUX_F(CLK_MOUT_USER_MAU_EPLL, "mout_user_mau_epll", mout_group16_5800_p,
>>   			SRC_TOP9, 8, 1, CLK_SET_RATE_PARENT, 0),
>> +	MUX(CLK_MOUT_USER_ACLK266_ISP, "mout_user_aclk266_isp",
>> +			mout_group18_5800_p, SRC_TOP9, 12, 1),
>>   	MUX(0, "mout_user_aclk550_cam", mout_group15_5800_p,
>>   							SRC_TOP9, 16, 1),
>>   	MUX(0, "mout_user_aclkfl1_550_cam", mout_group13_5800_p,
>> @@ -510,6 +518,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(0, "mout_user_aclk432_scaler", mout_group9_5800_p,
>>   							SRC_TOP9, 28, 1),
>>   
>> +	MUX(CLK_MOUT_SW_ACLK266_ISP, "mout_sw_aclk266_isp", mout_group17_5800_p,
>> +			SRC_TOP13, 12, 1),
>>   	MUX(0, "mout_sw_aclk550_cam", mout_group14_5800_p, SRC_TOP13, 16, 1),
>>   	MUX(0, "mout_sw_aclkfl1_550_cam", mout_group12_5800_p,
>>   							SRC_TOP13, 20, 1),
>> @@ -524,6 +534,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   static const struct samsung_div_clock exynos5800_div_clks[] __initconst = {
>>   	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
>>   			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
>> +	DIV(CLK_DOUT_ACLK266_ISP, "dout_aclk266_isp", "mout_aclk266_isp",
>> +				DIV_TOP8, 12, 3),
>>   	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
>>   				DIV_TOP8, 16, 3),
>>   	DIV(0, "dout_aclkfl1_550_cam", "mout_aclkfl1_550_cam",
>> @@ -574,6 +586,9 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>>   	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
>>   	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
>>   
>> +	MUX(CLK_MOUT_USER_ACLK266_ISP, "mout_user_aclk266_isp",
>> +			mout_user_aclk266_isp_p, SRC_TOP4, 16, 1),
>> +
>>   	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>>   			mout_group5_5800_p, SRC_TOP7, 16, 2),
>>   	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
>> @@ -641,8 +656,6 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   			SRC_TOP4, 8, 1),
>>   	MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
>>   			SRC_TOP4, 12, 1),
>> -	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
>> -			SRC_TOP4, 16, 1),
>>   	MUX(0, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
>>   	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
>>   	MUX(CLK_MOUT_USER_ACLK333, "mout_user_aclk333", mout_user_aclk333_p,
>>
> 
> I checked it on Exynos5420/5422 TRM.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you!

Regards,
Lukasz
> 
