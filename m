Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B4C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2702E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bs//UOhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGRFTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:19:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48403 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:19:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718051933euoutp01b6122d56ce81c933cb245648ed9896aa~yaLsA1tG62983529835euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718051933euoutp01b6122d56ce81c933cb245648ed9896aa~yaLsA1tG62983529835euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563427173;
        bh=siOYjgkw/wy7C0asqLY/4tCW33a/SvBZvIzn6L0ZMP0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bs//UOhLa2YR+XnOklQ2l9dYIS+XQ+vBQAAfGzN9W9k7eBE9XAqG0/MECw0cx9UR1
         XLIOLDrMe+AMv632sWedWlDfAhG4zzWkJ6SDgNzbBwQT9Ctu6bcgMceezTPaFBqapH
         wvXVYcS3GKxrnEt98p/DVbuiWwrnqBhETIioMs9Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718051931eucas1p11748bb1792c583c1d5e928f2684fa215~yaLrCDtLb2003720037eucas1p1T;
        Thu, 18 Jul 2019 05:19:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.CE.04377.361003D5; Thu, 18
        Jul 2019 06:19:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718051930eucas1p2badaffeba905219807a2e55867318633~yaLqEVxk31612016120eucas1p2w;
        Thu, 18 Jul 2019 05:19:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718051930eusmtrp25250cb2c814ca3b1f0b297446fb8947c~yaLp2HGzM1144111441eusmtrp2X;
        Thu, 18 Jul 2019 05:19:30 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-89-5d300163f150
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.B4.04140.261003D5; Thu, 18
        Jul 2019 06:19:30 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718051929eusmtip1b8d16e370e2ba9e56aec7a1630580d93~yaLpF9hk81936219362eusmtip18;
        Thu, 18 Jul 2019 05:19:29 +0000 (GMT)
Subject: Re: [PATCH v1 03/50] clk: samsung: change parent of
 dout_aclk400_wcore in Exynos5420
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
Message-ID: <9fa48351-80ae-7046-6795-c19d66c18810@partner.samsung.com>
Date:   Thu, 18 Jul 2019 07:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <6d3361b5-9e1f-eb1a-aaa9-3ca15ed5ad1d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzvd889Lx3H0/X29c5tlrxU3rbfvISGXZtNbDZjyalHpDvc40qx
        qUi6pReb1KUXKs6tF10vqzONSlG4TnpRJGKWtLzcmMlL5znTf5+379v2ZQjZIDmdOag+xmnU
        ykg5JRHXNH+3LAlFfsF+I5WLcG/ZYxJXZJWTuNv2jsT5TeM0bXCYwBbLTRo/SvhAY9NgF4k/
        pfSTuMN8mcJZlnoRLm16QePibqsIW1s34b54A4UTbzfRuPFDEol/dVWI18sUJXklSDHak0gr
        TMZkSlFZdEqRWmVEii+m2UHULsmaMC7yYBSn8fXfKzlQMDJAHdFJjifdK6bjUCmjQ84MsCsg
        68mASIckjIw1IOjWN5MCsSG4OtZLCeQLgvvXiqh/JXeqXxKCcR3Bp6EbtEBGEJR2W5A95cqG
        wI+vmX8NN7YVQfyATmQ3CDZTBPo8dx1iGIr1gVrjUbssZTdDo+k3acdidj6kxhf+7ePO7oSO
        KjMSMi7wIPuN2I6d2XXw7NZLR0tP6H2T78Bz4HR1DiFsmszAq65tAt4I5WUGJGBXeN9SRQt4
        JvyuE2qB5SHu/BVH5iQMpuU6MquhscVK2lcmWG8oN/sK8gborEmm7TKwU6BnxEXYYApcqLlE
        CLIUzp2VCekFUJXS7hjkAddLMul0JNdPuEs/4Rb9hFv0/+cWILEReXJaXhXO8cvUXLQPr1Tx
        WnW4T+hhlQmNv17brxZbLTKP7WtALIPkk6Vxc32DZaQyio9RNSBgCLmbtG9oXJKGKWNiOc3h
        EI02kuMb0AxGLPeUnnAa2C1jw5XHuEMcd4TT/HNFjPP0OOQ977hnxMV1P93PLf82K2ltwDBF
        2bJbPru/Fosm/dz/8PXKoLCtxqf9+Tald4BXX3TYx4i6lIxXdaMJTQk/vDKia9YPGy8U+mPf
        oanb3wYG5VpPtXcmbiF27DwTM80nKvB5V8Li2LujTnv8ewJndcbSbTM71atUsz3qrVHhH7Xp
        33MMcjF/QLl0IaHhlX8AYXoIVnYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7pJjAaxBns6VC1urTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Sx9shddoul
        1y8yWVw85Wpxu3EFm0Xr3iPsFofftLNa/Lu2kcVByGPNvDWMHu9vtLJ7bFrVyeaxeUm9R9+W
        VYwenzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW
        6dsl6GUsePuAraCLq6L96FL2Bsa1HF2MnBwSAiYSB7beZ+5i5OIQEljKKPFo2QR2iISYxKR9
        26FsYYk/17rYIIpeM0ps2PKVBSQhLBAv8fvbNHaQhIjAKUaJ7keL2UASzALTmCROrIca+4dR
        YsGaiYxdjBwcbAJ6EjtWFYLU8Aq4SRze9J8VxGYRUJXoa1zMCGKLCkRI9LXNZoOoEZQ4OfMJ
        2DJOAXuJm7vvM0HMN5OYt/khM4QtLnHryXyouLxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIz1bcd+btnB2PUu+BCjAAejEg/vDSX9WCHWxLLi
        ytxDjBIczEoivLdfAoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5iG8kriDU0NzS0sDc2N
        zY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOat5NvmfjnIjEPjvEHUL5Ebj+9t825+
        fkAylHW5YJqQ74faVjvmL+y9G5fHWOTyahp1urxt2TgtK8Zqg+eUTzM6+YT1Hh430uKfF2ln
        s2m96rRKhitXuP6tnqVxzHFqkNn1cxb/Pe8t2fBBbElWd9PDT+/FeFe8ZSpXPTLxUX3kjahN
        sy0+/1BiKc5INNRiLipOBADHGjkqCwMAAA==
X-CMS-MailID: 20190718051930eucas1p2badaffeba905219807a2e55867318633
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124436eucas1p28a581bc25f6dae52a5b9b1af26d26368
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124436eucas1p28a581bc25f6dae52a5b9b1af26d26368
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124436eucas1p28a581bc25f6dae52a5b9b1af26d26368@eucas1p2.samsung.com>
        <20190715124417.4787-4-l.luba@partner.samsung.com>
        <6d3361b5-9e1f-eb1a-aaa9-3ca15ed5ad1d@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 7/16/19 11:13 AM, Chanwoo Choi wrote:
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> Change parent of dout_aclk400_wcore to mout_aclk400_wcore which reflects
>> topology described in the RM.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index d353870e7fda..361ee53fc9fc 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -577,7 +577,7 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>>   
>>   static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
>>   	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
>> -			"mout_aclk400_wcore_bpll", DIV_TOP0, 16, 3),
>> +			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
>>   };
>>   
>>   static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> If possible, you better to send it to stable mailing list
> with Fixes information.
Thank you, I will do it when finish the v2.

Regards,
Lukasz

