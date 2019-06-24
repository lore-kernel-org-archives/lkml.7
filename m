Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D009208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WkgAnjsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfFXHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:20:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51006 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFXHUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:20:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624072041euoutp028e6d41e91423d064e0c4656e7511b864~rEWm_T86X3053630536euoutp021
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:20:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624072041euoutp028e6d41e91423d064e0c4656e7511b864~rEWm_T86X3053630536euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561360841;
        bh=AkkGYU4UEYgfsh3s+7fzHB6aVXnYZdkOfuooy+x870g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WkgAnjsW05sUl8X6Dlqlm58Q2AcbroHkjtjUeWf/nTaafa1+3WNjnyPWBt+6Hp27Y
         vAtgxL4uz+cujhJXZwoFIIwRylPCvpk/gDbM1oSAThGEBJDbjfiw62NCBHcdXK1k+p
         XVRgnXYj1nwF3q+OyCB4vO62LUnO8Zh7Y1U0CEzI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624072041eucas1p2aea54a574b3873ce169927d1c4fa95d5~rEWmo1As_3236132361eucas1p2d;
        Mon, 24 Jun 2019 07:20:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.6C.04325.8C9701D5; Mon, 24
        Jun 2019 08:20:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190624072040eucas1p2d484086328b7c097693c2b45f18076db~rEWl7OxCh3225832258eucas1p2c;
        Mon, 24 Jun 2019 07:20:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190624072040eusmtrp2509024819a46be13d0f5a21e69749747~rEWltEwkM1889218892eusmtrp2t;
        Mon, 24 Jun 2019 07:20:40 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-88-5d1079c83e4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.39.04140.8C9701D5; Mon, 24
        Jun 2019 08:20:40 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624072039eusmtip14a1638925c7d4e53713e27369151dee7~rEWlW37Px0343903439eusmtip1S;
        Mon, 24 Jun 2019 07:20:39 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] ARM: dts: exynos: Add regulator suspend
 configuration to Odroid XU3/XU4/HC1 family
To:     Anand Moon <linux.amoon@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d94a2f99-fb99-c238-7011-9bbb4c0cd90f@samsung.com>
Date:   Mon, 24 Jun 2019 09:20:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANAwSgTFQo8wL5s-djwPXFFOLtTHvRQif6234kFC=23PwMhuEQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87onKwViDdZ+ZbSYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLFu4y12B3aPnbPusntsWtXJ5rF5Sb3H501yASxRXDYp
        qTmZZalF+nYJXBkfLhxjKVjOWTHh8QH2BsYV7F2MnBwSAiYSm/f/YOli5OIQEljBKNG9/QCU
        84VR4uuMe0wQzmdGiabjS4AcDrCWPTtdIOLLGSX6ev+yQThvGSWuXFrFBDJXWKBAovPoWzYQ
        W0TAX6Jn4z5WkCJmgZuMEt+3rmUESbAJGEp0ve0CK+IVsJP4ceo1O8gGFgFViffr+UDCogIx
        Eg/n34EqEZQ4OfMJC4jNKRAoceHvPrAfmAXkJba/ncMMYYtL3HoyH+xqCYFl7BIrJ25jh7ja
        ReL7NjGIn4UlXh3fAvW/jMT/nTD1zYwSD8+tZYdwehglLjfNYISospY4fPwiK8ggZgFNifW7
        9CFmOkq8uZYKYfJJ3HgrCHECn8SkbdOZIcK8Eh1tQhAz1CRmHV8Ht/XghUvMExiVZiF5bBaS
        Z2YheWYWwtoFjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxApPO6X/Hv+5g3Pcn6RCj
        AAejEg+vwAb+WCHWxLLiytxDjBIczEoivEsTBWKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81Yz
        PIgWEkhPLEnNTk0tSC2CyTJxcEo1MAauSX783k1KQVzbX+n423dPXdfvLozyV0y4KXlgHcPO
        tZcX+b1W77t24aP//v69JwR4Jrsp9p7U38mZ+nWudnuv3q1nwX5+z1l1vyw0ufHnEGvr36/3
        inWW/lV8tWxCUjeHeBTz6l0X4364uMotir60ce67OYcj1AVNjlkknrxUIOjcza3jq6XEUpyR
        aKjFXFScCAA6JuHXNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7onKgViDY4cFrCYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLFu4y12B3aPnbPusntsWtXJ5rF5Sb3H501yASxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkfLhxjKVjO
        WTHh8QH2BsYV7F2MHBwSAiYSe3a6dDFycQgJLGWUaD8KEucEistInJzWwAphC0v8udbFBmIL
        CbxmlPg6pQjEFhYokOg8+hYsLiLgK/G/4RYziM0scJNRouuODcTQH4wS87YsYwRJsAkYSnS9
        hRjEK2An8ePUa7AjWARUJd6v5wMJiwrESHRN/ckCUSIocXLmEzCbUyBQ4sLffewQ880k5m1+
        CLVLXmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqX
        rpecn7uJERhl24793LKDsetd8CFGAQ5GJR5egQ38sUKsiWXFlbmHGCU4mJVEeJcmCsQK8aYk
        VlalFuXHF5XmpBYfYjQF+m0is5Rocj4wAeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJ
        zU5NLUgtgulj4uCUamA8taH+p2rW/JWexWdda3281B6+mL3SWW630gXT3R42uaZt0/OeliQ8
        mCex0H7FhodFnRXySvetV5/zPrbfQnVH84QEngWvSvK1NkQZ7jI+r2PlNs/Yq2p39Peftyo/
        5i7f5vrlxrmPztVndM0UJkww0lBeOWGv3J/Mm1sjVMUU2dZZXDZ5f/2wEktxRqKhFnNRcSIA
        XxGznMgCAAA=
X-CMS-MailID: 20190624072040eucas1p2d484086328b7c097693c2b45f18076db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190623160226epcas2p3449814deb1faf7bf939481e6d4da2b86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190623160226epcas2p3449814deb1faf7bf939481e6d4da2b86
References: <20190621155845.7079-1-krzk@kernel.org>
        <20190621155845.7079-3-krzk@kernel.org>
        <CGME20190623160226epcas2p3449814deb1faf7bf939481e6d4da2b86@epcas2p3.samsung.com>
        <CANAwSgTFQo8wL5s-djwPXFFOLtTHvRQif6234kFC=23PwMhuEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 2019-06-23 18:02, Anand Moon wrote:
> Thanks for this patch. Please add my
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> [snip]
>
> Could you integrate below small changes into this patch.
> with these below changes suspend and resume work correctly at my end.
>
> [1] XU4_suspendresume.patch
>
> As per S2MPS11B PMIC 1.2.1 Regulator (Features)
> Fix the min max value for *Buck7* and *Buck8*
>
> -- Buck7 (VDD_1.0V_LDO) 1.5 A (1.2 V to 1.5 V, 12.5 mV step, default on 1.35 V)
> -- Buck8 (VDD_1.8V_LDO) 2.5 A (1.8 V to 2.1 V, 12.5 mV step, default on 2.0 V)

Could you elaborate why such change for Buck7 and Buck8 is needed?

> Also add suspend-off for *Buck9*
> Buck9 internally controls the power of USB hub.
> Adding suspend the this node help proper reset of USB hub on Odroid
> XU4 / HC1/ XU3
> during suspend and resume. Below it the logs from my testing.

Disabling Buck9 in suspend indeed reduces the power consumed by the 
board during suspend-to-ram from about 80mA to as little as 7-10mA, what 
matches the results of OdroidXU3. Thanks for the hint!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

