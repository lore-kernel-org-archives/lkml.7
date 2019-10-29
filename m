Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26477CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFCC21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YCyJN6qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfJ2Lh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:37:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33831 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfJ2Lh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:37:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191029113725euoutp0167e80b54dfe82fe6af9e2eb5187cf261~SGyBZP35Z3227432274euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:37:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191029113725euoutp0167e80b54dfe82fe6af9e2eb5187cf261~SGyBZP35Z3227432274euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572349045;
        bh=MV9FXID7nThRVDKuFUHFACJIlbCzkHrjaJu5Zhz/fsY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YCyJN6qQEllQY1S8GqZsldUqkJIBv3clfupk3Ug2kvQVpQUi8UBE/50zejCjMc4o8
         8L44j9Sw5WBiNRLpJQiyQSDlf0KsmTyXtNUqlIEm9v8hCXCCGtyjo7/Hfv73N1sRe8
         EUinASYPq77FHo5zOAcxuVgtM1DbymYCtVWKDLPA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191029113725eucas1p26abe0e7d7dda56b3e7bbdfdce3434288~SGyBJlTFm2560525605eucas1p25;
        Tue, 29 Oct 2019 11:37:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BC.28.04309.57428BD5; Tue, 29
        Oct 2019 11:37:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191029113725eucas1p1a6e7ba2329ed3d4fdd16cf39fdb286b7~SGyA4Ow142425024250eucas1p1c;
        Tue, 29 Oct 2019 11:37:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191029113725eusmtrp23541ca0c5609b89b6c685a7655433515~SGyA3jjIp2216522165eusmtrp2N;
        Tue, 29 Oct 2019 11:37:25 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-f7-5db824752e33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.37.04117.47428BD5; Tue, 29
        Oct 2019 11:37:25 +0000 (GMT)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191029113724eusmtip28f08b0bb87ec7ba1856511b3ee5baead~SGyAU99Wh1898918989eusmtip2K;
        Tue, 29 Oct 2019 11:37:24 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: exynos5433: Add missing slab.h header for
 kfree()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <448c0770-24a2-6227-24e8-9bd5ad926f5e@samsung.com>
Date:   Tue, 29 Oct 2019 12:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023160000.409-1-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURjtvmXmqY1cR80P22AwzEAnrR+vBclImD9BEJQUYk99qOTGPJdM
        Sk3N3BcCc1RSDM0RXCY190CrsdyQKRWlMhVMw9QcEfd0npL/zjnfOdxz4DKkvJu2Z4JCI3h1
        KBeskJhTjR9X+50jHZq8zzZ32bLDxmmazZ78TbIDA7VSVjc5RLOLGd9p1tBSJGFfDHQQ7Gzi
        hIQd/OzJbg3VUay2ZQNdsVDNjyRLVc2ab1JVWdsModJpUyWqN6/iVFn1WqRa0p24Ib1jftmf
        Dw6K4tVK93vmgcXlP6XhufSD3MoUFI8qqDRkxgA+DwvjSWQaMmfk+DWC9j4jEokRQcNsPCGS
        JQQ1a8VoP9LeUU2JhwoEjfljtEjmEKS+LSd2Xdb4FvQu9JsSNtgJhjdXTCYSzxDwV59O7x4k
        2BUyP2SZTDLsDoWzXaYwhU/B+1rDjs4wttgLepY50WIFnwqmTMXN8DlYn04wRUlsB0+MlbSI
        T0JiQ6FpEOBRKbSlLe/VvgbPSzdoEVvDrL5eKuJjsN38khADiQgyWsekIslB8ENfspe+BF36
        QXq3Ebkzp6ZFKcoesJC5KNmVAVvCyJyVWMIS8hrzSVGWwbOnctHtAOvafELE9pA+tU3lIIXm
        wDTNgTmaA3M0/98tQZQW2fGRQkgAL7iF8tEuAhciRIYGuPiFhejQzv/q2dIbm1DLhm8nwgxS
        HJb9+troLae5KCEmpBMBQypsZIO9O5LMn4t5yKvDfNSRwbzQiY4ylMJOFnto/K4cB3AR/H2e
        D+fV+1eCMbOPR48cLYr63AxXi/Nmln09ozkLbx+v4LRkXNVvkHnQpQldf7xWlF+q1zq3PJM2
        312vDntMR6Tks91xZUom1a+ntfLiba95/WnDSGrmEb/kuOPCBYJpK2hQdrzKscyrumnXVmfM
        K/TOxoRjTEPQcmu5p9Oom2+uYiJWt004O67SCkoI5FzPkGqB+wdPjvHIWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qlKjtiDR4vY7K4/uU5q0X/49fM
        FufPb2C32PT4GqvFx557rBaXd81hs5hxfh+TxavmR2wWF0+5Wvy7tpHFYtWuP4wO3B7vb7Sy
        e+ycdZfdY/Gel0wem1Z1snlsXlLv0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlzlz1kL5jIWjFxZTtjA+Nyli5GTg4JAROJ
        vfvWAdlcHEICSxklvmw4ydTFyAGUkJKY36IEUSMs8edaFxtEzWtGiYvr5oE1CwuESZz5cI4R
        xBYR0JS4/vc7K0gRs8BLJomPe85DdbQxStzrmMIEUsUmYCjRe7QPrINXwE5i9qvDYHEWAVWJ
        Ixsug8VFBSIknm+/AVUjKHFy5hOwbZwCxhK/nzeCxZkF1CX+zLvEDGGLSzR9WckKYctLNG+d
        zTyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMB43Xbs55Yd
        jF3vgg8xCnAwKvHwvri6LVaINbGsuDL3EKMEB7OSCO/FM0Ah3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgemkrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwm
        JxJDN8z953N2ppSt0FaGZ+uzGe8873geZHvvroTouuu/r0481uF4R+PB//M3Zyid1b8umLZH
        slTEa2vXOqV/VsHPBLmPzlaZriEYfWErN1s00175+cd0368TEA8sNeSpqtw5e39npsz0CUnl
        nAcWTPtx1Tdzx9faI/vu7bD89/Nvqc0Hxcz9SizFGYmGWsxFxYkApz0MaO0CAAA=
X-CMS-MailID: 20191029113725eucas1p1a6e7ba2329ed3d4fdd16cf39fdb286b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191023160027epcas4p15be9c72d575fa4c3b022551c32cfc59a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191023160027epcas4p15be9c72d575fa4c3b022551c32cfc59a
References: <CGME20191023160027epcas4p15be9c72d575fa4c3b022551c32cfc59a@epcas4p1.samsung.com>
        <20191023160000.409-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 18:00, Krzysztof Kozlowski wrote:
> Usage of kfree() requires slab.h header.  Otherwise building on x86_64
> with COMPILE_TEST fails with:
> 
>     drivers/clk/samsung/clk-exynos5433.c: In function ‘exynos5433_cmu_probe’:
>     drivers/clk/samsung/clk-exynos5433.c:5598:4: error: implicit declaration 
> of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, I applied it and squashed with the fix patch from Marek that
introduced the above issue.

-- 
Regards,
Sylwester
