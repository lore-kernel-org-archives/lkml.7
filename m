Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D91B20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gmXH0Orz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfHBINh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:13:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15001 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403892AbfHBINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:13:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190802081332epoutp04855a748775331468305f92616744a304~3DO4giWs11573515735epoutp04i
        for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2019 08:13:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190802081332epoutp04855a748775331468305f92616744a304~3DO4giWs11573515735epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564733612;
        bh=VsYXlTMvby2bvlazuxQQ80Bt2lwuuS4S73YdioLZCfw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gmXH0Orzgfad3Dmsb/haDryUExsvR7GkGKC760H5ZKiAH1EZibiOD5Fefu6NF6yOM
         0bWdqShmdEhfCd14RA/mcBLE+CdVw0TFiXyd0Ea/63MguqoGH162havFh76T5jCHyu
         rww0mvr5InuZNpf0D8Bw/uRwr7Xkf9up4U4/MLes=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190802081332epcas1p24754bb652dc2c3f7973eb1f2f72c93bc~3DO4RCxiF1700217002epcas1p2D;
        Fri,  2 Aug 2019 08:13:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 460Kfw4k53zMqYkW; Fri,  2 Aug
        2019 08:13:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.4C.04160.6A0F34D5; Fri,  2 Aug 2019 17:13:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190802081325epcas1p4588bc40751d2aa4ff5ad2ca001103499~3DOyebBEt1089710897epcas1p4U;
        Fri,  2 Aug 2019 08:13:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190802081325epsmtrp2f65b321b1644893a977f614d71c2f909~3DOydK95L1945819458epsmtrp2r;
        Fri,  2 Aug 2019 08:13:25 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-2f-5d43f0a62cee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.EF.03638.5A0F34D5; Fri,  2 Aug 2019 17:13:25 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190802081325epsmtip2e5c4a3dee98c2de40b8f20de41ffe3e2~3DOyU7SNT3161331613epsmtip2h;
        Fri,  2 Aug 2019 08:13:25 +0000 (GMT)
Subject: Re: ERROR: "vmf_insert_mixed" [drivers/gpu/drm/exynos/exynosdrm.ko]
 undefined!
To:     kbuild test robot <lkp@intel.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <d1ba546e-11d1-3f16-aba8-10ffd318a3f3@samsung.com>
Date:   Fri, 2 Aug 2019 17:15:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907250623.Lvc2mgUO%lkp@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuTvjOEob07bWaaO0KSFFbcd1c4q0SKmlpCSJHiTr4E4q7mPa
        WU2jx0YYuvbaiqDNysjELBBEJU0J1IyQ2t5ZEb02yx4WWvYyaMdb5H+/c+53ON8599CEpoLS
        0QV2l+i0C1aWCidbumIS4ms/p2Xre1s4vuehl+DvtlVR/Ls9Lym+7kczWkKannWEms62D6hM
        NcfuU6bhxpmZ5MbCRfmiYBGdUaI912EpsOelsCuzzGlm43w9F88t4JPZKLtgE1PY9IzM+GUF
        1mBHNqpYsBYFU5mCLLPzUhc5HUUuMSrfIbtSWFGyWKUFUoIs2OQie15CrsO2kNPrE41BYU5h
        /p2Dv5FUE17y83yxG52iPYimgUmCj6OrPCiM1jCXENQe03lQeJCHEBxovUfhYATB7spHpKJS
        Cs75G1T4oQPBkTuXCRx8QvDeczRUUU1mNkDV07YQhbXMMmg/cZVQ2hGMAV7UapU0xUSDt+4Z
        pbCaSYXA415CYZKZA78+VCCFI5j1MPS8KwRrJsH144ExE2FMIoy4b43VEsxUeBw4rcIcCXua
        T4z5AaabAn/T/r+u06G7+qgK82R4d60pFLMOhgc7KMxboX+wn8Rr2Q4jJ0swGuB2nQW7j4GG
        tnlYPAtaf51EuOtEGPy6LwSr1VC+V4MlLPTc7kOYAW7VeCksMcHTvoRDaJZv3Fi+caP4xo3i
        +9+3GpH1aIooybY8UeakpPHf3IjGzjCWv4Tab2Z0IoZG7AR1XWBptiZEKJZLbZ0IaILVqg+o
        07I1aotQuk10OszOIqsodyJjcOteQheR6wgetd1l5oyJBoOBT+LmGzmOnao+853P1jB5gkss
        FEVJdP6rU9FhOjfKYg5LZq9789CF4303lkfeSyqLGK5PrvTPbVX3p11cMb359alPr3Uv3pa/
        2XGBdWuTR9emF6x1XfGXxG0YqR56MuNNhBS9bvVsZxV98VtkRmrAV1k+rZTceXiNN67j8qvN
        W7YOeHg9mRO6a1qxf+P97rj4l6Ob+spKXn3Rws7F0gOCJeV8gYslnLLwB1KWzYKcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO7SD86xBvP2mVkcuz6R2eLyrjls
        Fq+aH7FZrPi5ldGBxeP+XnaPxXteMnksmXaVzePzJrkAligum5TUnMyy1CJ9uwSujEv9fxkL
        lnBV/FpZ1sA4j6OLkZNDQsBEYun59UxdjFwcQgK7GSVWTGgFcjiAEhISW7ZyQJjCEocPF0OU
        vGWUuNxyhBGkV1ggUmLO3V2sILaIgJvEntlHmUHqmQWMJR4uE4Gob2WUWPlnOjNIDZuAqsTE
        FffZQGxeATuJJ7dOg8VZBFQkfr/pBJspKhAhcXjHLEaIGkGJkzOfsIDYnAJGEt8aLrBBzFeX
        WD9PCCTMLCAucevJfCYIW16ieets5gmMQrOQdM9C6JiFpGMWko4FjCyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCY0BLawfjiRPxhxgFOBiVeHgZnjvFCrEmlhVX5h5ilOBgVhLh
        7eN1jhXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXAuHja
        g0f9T5qedzrfynz61fj0sbBI39R9Jd4THj6bqXSs9Yz4513r765Xz1nwaLOX5N2Y1a/mcJXn
        5H+Z6VfDwBmXWv7jequjuKve74V3OZ/f/3gz6eZSpoomxd3ivyuelLG3RZz7++DSzKXpEmYr
        Q5UP8F5xWf5z5mefA9f2G5Sp2PpsTqh9+UOJpTgj0VCLuag4EQA2af7DfQIAAA==
X-CMS-MailID: 20190802081325epcas1p4588bc40751d2aa4ff5ad2ca001103499
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190724223620epcas3p35a32100b839a0d545e910e3ed84047ca
References: <CGME20190724223620epcas3p35a32100b839a0d545e910e3ed84047ca@epcas3p3.samsung.com>
        <201907250623.Lvc2mgUO%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

19. 7. 25. 오전 7:35에 kbuild test robot 이(가) 쓴 글:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bed38c3e2dca01b358a62b5e73b46e875742fd75
> commit: 156bdac99061b4013c8e47799c6e574f7f84e9f4 drm/exynos: trigger build of all modules
> date:   4 weeks ago
> config: h8300-allmodconfig (attached as .config)
> compiler: h8300-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 156bdac99061b4013c8e47799c6e574f7f84e9f4
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=h8300 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "vmf_insert_mixed" [drivers/gpu/drm/exynos/exynosdrm.ko] undefined!

With below patch I think the build error reported already will be fixed,
https://patchwork.kernel.org/patch/11035147/

Thanks,
Inki Dae

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
