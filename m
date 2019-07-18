Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D65C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC2C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WanHS1Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfGRGCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:02:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45302 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:02:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718060252euoutp02721547204f4953d60e345c2d870e128e~yaxhOYAdc1131411314euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718060252euoutp02721547204f4953d60e345c2d870e128e~yaxhOYAdc1131411314euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563429772;
        bh=0ST1brnTCEkGXCsDHqqYxoIz17apf22c7auT1HUgQ6I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WanHS1Q2SK7EHL1EVo7xcec3df5GFP1tzddn+jjO0Q7nmhFOw2ifFxwzxm48P9X7F
         YtRjBvY6Zn0B0kSEpcTRRvkekUIiks6IJj3nZKSSgx7/OyVqGN2pAWqSW+zPzDOuK4
         yMFg2w+KQ8vEBcp+7YxKdUjC3RN+0828zD5hSrpI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718060251eucas1p1620bb64523a7763ce99001a1bd04a378~yaxgX3iJn1078510785eucas1p10;
        Thu, 18 Jul 2019 06:02:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.41.04377.B8B003D5; Thu, 18
        Jul 2019 07:02:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060250eucas1p2657899e6de98b70915ba6e15b1e95a10~yaxfgLkvr3116431164eucas1p2v;
        Thu, 18 Jul 2019 06:02:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718060250eusmtrp1a7d7e3171e4b2e393024625a6aa98422~yaxfR87OT0969409694eusmtrp1d;
        Thu, 18 Jul 2019 06:02:50 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-22-5d300b8b7237
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.17.04140.A8B003D5; Thu, 18
        Jul 2019 07:02:50 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060249eusmtip209fc28787ad7986876fcebb08d473959~yaxeVZQJZ2322723227eusmtip2Z;
        Thu, 18 Jul 2019 06:02:49 +0000 (GMT)
Subject: Re: [PATCH v1 01/50] clk: samsung: add new IDs for Exynos5420
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
Message-ID: <6dfe9e43-48da-a4a6-7af1-d00a817852bb@partner.samsung.com>
Date:   Thu, 18 Jul 2019 08:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <f8ff72f9-4a55-40c6-fdb9-bb4cddd00cf9@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju27m6XBynthcri4V0odTC4IuiC5SNCupXZRZ1qoONtmU7WllR
        WzXTaRYFarPMIFOmtlwrYqCZl0ytbAhaDmO0UZSXEA26Ws4zyX/P+zzP+37P+/KxhDJAxbBa
        Q4ZgNPA6NS0nHz//0bk0b3ri3sShmjjce/81hWuLHRTuGf1E4dvN4+UVfz+BOzsfMPjV+QEG
        O/3dFB7Of0/hLvdNGhd31stwTXMfg8t7PDLsad+IveZKGlvqmhncNHCJwmPdteQ6paa6tBpp
        vr61MBqnPZfWPLx7TlPgsiPNiDN2O71bvvqQoNMeF4wJa/bLD3urnqL0wbknezoaCRNqBisK
        Y4FLgsGaQsaK5KySq0Tg679JScUoggJfESEVIwjMFptssqX0W05IqEDwobs0VAwicFQ3TLgi
        uW3gr/pDB4Uorn283WedEAiuUAa20mgrYlmai4cn9mNBWsElw3DuRzqISS4O6p2+CXs0twu6
        XG4keSKg7UaADOIwbi0Ut31kpJEq6A3cDo2fCxcelUwEAi6XhQfP7IQUewPk9ddSEo6EL60u
        RsKzoeN6PilhEUyX7yAJnwH/lVshzypoavVQwcwEtwgc7gSJXg+Wi24mSAM3A94ORkgRZsC1
        x8HLBWkF5GQrJfdCcOW/Cd1wJlRUFzJXkdo2ZTHblGVsU5ax/X+3DJF2pBIyRX2aIC43CCfi
        RV4vZhrS4g8e1TvR+N/rGGsdfYLcvw80Io5F6nCFaV7CXiXFHxez9I0IWEIdpfB+HqcUh/is
        U4Lx6D5jpk4QG9EsllSrFKen+VKVXBqfIRwRhHTBOKnK2LAYEzrbXvIuJ6B9sTIxRhen35qV
        HFsZi+u6Er5f27IqameMc174rfKUX30pe8xlemf7/J/eBYkFjrzk4Yg5kapXZUUftF0gEp91
        92YaMpBn2LSRX2JpIDcfaRj4m1FRZqYoG2qztmwqv+5Kz/a/hKLAiqSSHdH3UpcMpXhavvWm
        X1aT4mF+2WLCKPL/AKEIZc53AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7pd3AaxBr9XqlncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BZL
        r19ksrh4ytXiduMKNovWvUfYLQ6/aWe1+HdtI4uDkMeaeWsYPd7faGX32LSqk81j85J6j74t
        qxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst
        0rdL0Mu4vXo/Y8Fb+Yrrpw8xNzAekehi5OSQEDCRmPe1gxnEFhJYyijxb4UJRFxMYtK+7ewQ
        trDEn2tdbF2MXEA1rxklNkxcCeRwcAgL+Eq8umgOEhcROMUo0f1oMRtIA7PANCaJE+uZIRr+
        MEqcOXeVBaSBTUBPYseqQpAaXgE3iY+dz8DqWQRUJfZtesAEYosKREj0tc1mg6gRlDg58wkL
        iM0pYC8x4+Qzdoj5ZhLzNj9khrDFJW49mc8EYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRlASPL
        KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA433bs55YdjF3vgg8xCnAwKvHw3lDSjxViTSwr
        rsw9xCjBwawkwnv7JVCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84EpKK8k3tDU0NzC0tDc
        2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+Np/UoW6TMS/6fzyvbmbVDn/MqQI+U6
        O2Tjo7Oze35rledJLZTPXb+lcNWT8tarBS//cC7iz1eZ/WB63YErm27P/N7rVrDba0KIvdji
        rwt23D3Y8HJh3ZOZnC4lF/7XtQTqtoSn1tx476O6+8ilJ2edhPTfm8fNkGX8skb79va/v6Yx
        G923zCpRYinOSDTUYi4qTgQAQj90pAkDAAA=
X-CMS-MailID: 20190718060250eucas1p2657899e6de98b70915ba6e15b1e95a10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c@eucas1p2.samsung.com>
        <20190715124417.4787-2-l.luba@partner.samsung.com>
        <f8ff72f9-4a55-40c6-fdb9-bb4cddd00cf9@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/19 11:49 AM, Chanwoo Choi wrote:
> Hi,
> 
> Usually, when developing the clock controller driver,
> define the same sequence between the definition sequence in dt-bibing
> and clock driver. As I replied, if you squash patches, it is easy.
OK
> 
> For example,
> This series add clock id as following.
>                                                                               
>   569         MUX(CLK_MOUT_ACLK400_ISP, "mout_aclk400_isp", mout_group1_p,
>   570                         SRC_TOP0, 0, 2),
>   571         MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,
>   572                         SRC_TOP0, 4, 2),
>   573         MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
>   574                         SRC_TOP0, 16, 2),
>   575         MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_p,
>   576                         SRC_TOP0, 20, 2),
> 
> In case of this code, you can define the IDs as following sequentially:
> 
> #define CLK_MOUT_ACLK400_ISP ...
> #define CLK_MOUT_ACLK400_MSCL ...
> #define CLK_MOUT_ACLK400_WCORE ...
> #define CLK_MOUT_ACLK100_NOC ...
> 
Thank you for this example. I will align them.

Regards,
Lukasz
> 
> But, this series define the ID as following:
> 	#define CLK_MOUT_ACLK400_WCORE          662
> #define CLK_MOUT_SCLK_DPLL      663
> 	#define CLK_MOUT_ACLK100_NOC    664
> #define CLK_MOUT_ACLK200_FSYS2  665
> #define CLK_MOUT_PCLK200_FSYS   666
> #define CLK_MOUT_ACLK200_FSYS   667
> 	#define CLK_MOUT_ACLK400_ISP    668
> 	#define CLK_MOUT_ACLK400_MSCL   669
> #define CLK_MOUT_SCLK_MPLL      700
> #define CLK_MOUT_ACLK266        701
> #define CLK_MOUT_UART0          702
> #define CLK_MOUT_UART1          703
> #define CLK_MOUT_UART2          704
> #define CLK_MOUT_UART3          7
> 
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> There is a need of new IDs which will be used for modeling proper hierarchy
>> in the Exynos54xx SoCs. Previous implementation rely on bootloader
>> settings, which are not configuring properly some clocks.
>> These IDs provide interface to set proper parents.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 27 +++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>> index 02d5ac469a3d..c37a28eeaf7e 100644
>> --- a/include/dt-bindings/clock/exynos5420.h
>> +++ b/include/dt-bindings/clock/exynos5420.h
>> @@ -230,6 +230,30 @@
>>   #define CLK_MOUT_USER_MAU_EPLL	659
>>   #define CLK_MOUT_SCLK_SPLL	660
>>   #define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>> +#define CLK_MOUT_ACLK400_WCORE		662
>> +#define CLK_MOUT_SCLK_DPLL	663
>> +#define CLK_MOUT_ACLK100_NOC	664
>> +#define CLK_MOUT_ACLK200_FSYS2	665
>> +#define CLK_MOUT_PCLK200_FSYS	666
>> +#define CLK_MOUT_ACLK200_FSYS	667
>> +#define CLK_MOUT_ACLK400_ISP	668
>> +#define CLK_MOUT_ACLK400_MSCL	669
>> +#define CLK_MOUT_SCLK_MPLL	700
>> +#define CLK_MOUT_ACLK266	701
>> +#define CLK_MOUT_UART0		702
>> +#define CLK_MOUT_UART1		703
>> +#define CLK_MOUT_UART2		704
>> +#define CLK_MOUT_UART3		705
>> +#define CLK_MOUT_SCLK_CPLL	706
>> +#define CLK_MOUT_PWM		707
>> +#define CLK_MOUT_ACLK266_G2D		708
>> +#define CLK_MOUT_SW_ACLK400_WCORE	709
>> +#define CLK_MOUT_SW_ACLK400_MSCL	710
>> +#define CLK_MOUT_SW_ACLK400_ISP		711
>> +#define CLK_MOUT_SW_ACLK266_ISP		712
>> +#define CLK_MOUT_USER_ACLK266_ISP	713
>> +#define CLK_MOUT_ACLK266_ISP	714
>> +#define CLK_MOUT_MMC0		715
>>   
>>   /* divider clocks */
>>   #define CLK_DOUT_PIXEL		768
>> @@ -264,8 +288,9 @@
>>   #define CLK_FF_DOUT_SPLL2	797
>>   #define CLK_DOUT_PCLK_DREX0	798
>>   #define CLK_DOUT_PCLK_DREX1	799
>> +#define CLK_DOUT_ACLK266_ISP	800
>>   
>>   /* must be greater than maximal clock id */
>> -#define CLK_NR_CLKS		800
>> +#define CLK_NR_CLKS		801
>>   
>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
>>
> 
> 
