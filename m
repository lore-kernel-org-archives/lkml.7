Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B84BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C01B21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qNiz9DHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfIKL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:57:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49617 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfIKL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:57:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190911115705euoutp0189874613e8c0362c22003eb1006deac3~DYFfDyBbp2256522565euoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:57:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190911115705euoutp0189874613e8c0362c22003eb1006deac3~DYFfDyBbp2256522565euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568203025;
        bh=OH6rMiShoRkq4pzXu23aOxDbiKTdcWya1YQCabiUZWo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qNiz9DHlRsY7Q743TJAxz3IFOV06tcGoX80bFUb0P7JPXaC5cc5VPjLBo/4Fz/7CU
         ueN8Qpje0RaSrW0Xy34luJClKZKxEBRRN9Hsnp4K4xPZDl1HoG5+7nrkHensmZFz28
         28JCmOmkOFPYiI0ei9uMbN5h9YQa1NAFRH/OM+H8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190911115704eucas1p2e4913ba6e16036352d5396bfcd6e1b60~DYFem1vTH0661106611eucas1p2X;
        Wed, 11 Sep 2019 11:57:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.C9.04469.011E87D5; Wed, 11
        Sep 2019 12:57:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190911115703eucas1p1e3119c400c601a80d2c88d25ab744b38~DYFdtxlQQ2705827058eucas1p1N;
        Wed, 11 Sep 2019 11:57:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190911115703eusmtrp1ae7557e36298b60adb553e64820d7327~DYFdfXUa71503915039eusmtrp1O;
        Wed, 11 Sep 2019 11:57:03 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-e1-5d78e110d6a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.5D.04166.F01E87D5; Wed, 11
        Sep 2019 12:57:03 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190911115703eusmtip13d3ffffe11e3b882ad3b095bb5f75059~DYFdFgB1f2440924409eusmtip1b;
        Wed, 11 Sep 2019 11:57:03 +0000 (GMT)
Subject: Re: [PATCH v3] dt-bindings: arm: samsung: Convert Samsung Exynos
 IOMMU H/W, System MMU to dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Andrzej Hajda <a.hajda@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d7e938e8-d42e-be22-ce76-561159064180@samsung.com>
Date:   Wed, 11 Sep 2019 13:57:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeZ2usT+bx23n-hXxsLsbZqr-0JEtyagK8sfsLaFiaH5w@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7oCDytiDe5MV7K4te4cq8X8I0Di
        /PkN7BaXd81hs5hxfh+TxYPmdWwWS69fZLJo3XuE3YHDY828NYwem1Z1snn0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXxve2k+wF87kqHt4+xNTAuJKji5GTQ0LAROJx4yOWLkYuDiGBFYwS
        r57OZAJJCAl8YZRY86cMIvGZUeLitsesXYwcYB1H+uwg4ssZJbpWnmWGcN4CNTy6xArSLSyQ
        J/GrfQMbiC0iEC6x6OQRsCJmgd+MEhceb2EHSbAJGEp0ve0CK+IVsJPYfP0emM0ioCox7Wcj
        C4gtKhAjsfzNAxaIGkGJkzOfgNmcAoES+18cBpvDLCAvsf3tHGYIW1zi1pP5TBC/rWOXOLQx
        H8J2kZjdf5QNwhaWeHUc4gYJARmJ05N7wP6XEGhmlHh4bi07hNPDKHG5aQYjRJW1xOHjF8H+
        ZxbQlFi/Sx8i7Cjx5s59Nkiw8EnceCsIcQOfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJ
        jEqzkHw2C8k3s5B8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKej0v+Of
        djB+vZR0iFGAg1GJh1fgbkWsEGtiWXFl7iFGCQ5mJRHeBy1AId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYy2H49MWsCTdVTv6tu5ae/jHjJVGSSErJ43
        MzVk/+fbG42fsbw+V9bT2LhXLVV5+t2tD49qe3eWv752MPq2Y0bJQRk9P46WhzEv/1TulheZ
        OCtMIN07Ytmp+rN3vG+qhkxKEa9czq1z89R69qVXpZ/kNsz5oWyyg0PEwYRT5tW2Rbfmqoqm
        fuZWYinOSDTUYi4qTgQA/+tsNz0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7r8DytiDT4vVbW4te4cq8X8I0Di
        /PkN7BaXd81hs5hxfh+TxYPmdWwWS69fZLJo3XuE3YHDY828NYwem1Z1snn0bVnF6PF5k1wA
        S5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexve2
        k+wF87kqHt4+xNTAuJKji5GDQ0LAROJIn10XIyeHkMBSRokbt9hAbAkBGYmT0xpYIWxhiT/X
        uoDiXEA1rxkl9r58wQ6SEBbIk/jVvgGsQUQgXOLKgvvMIEXMAr8ZJT4/3wrVMY9JYu/0N2BV
        bAKGEl1vu8BsXgE7ic3X74HZLAKqEtN+NrKA2KICMRLbpk5ihagRlDg58wlYnFMgUGL/i8Ng
        m5kFzCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAqNu27Gfm3cwXtoYfIhRgINRiYdX4G5FrBBrYllxZe4hRgkOZiUR
        3gctQCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaEvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6B
        gzFCAumJJanZqakFqUUwfUwcnFINjPV+vxW0J+23CH7ypH/OSX6/p/0dk8NveljM+x4Z9Jdf
        WXThLqbrJVP0+HgXRvy4vX2GiOXxzYzznvfKm/256xp78tf1DSUmB+ec0/feWyS1PI3latGx
        oENOM5c/LJo/TVKx14SnU0XgSbXekaXmjqGf+8V/1Z8OdE2fW9zKZu3tY89rk5vrpcRSnJFo
        qMVcVJwIAO6aOKfQAgAA
X-CMS-MailID: 20190911115703eucas1p1e3119c400c601a80d2c88d25ab744b38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237
References: <CGME20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237@eucas1p2.samsung.com>
        <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
        <20190911110446.32058-1-m.falkowski@samsung.com>
        <CAJKOXPeZ2usT+bx23n-hXxsLsbZqr-0JEtyagK8sfsLaFiaH5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzyszotf,

On 2019-09-11 13:36, Krzysztof Kozlowski wrote:
> On Wed, 11 Sep 2019 at 13:05, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>> Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
>> to newer dt-schema format.
>>
>> Update clock description.
>>
>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> Hi Krzysztof,
>>
>> Thank you for feedback.
>>
>> v3:
>>
>> - remove obsolete interrupts description and
>> set its maxItems to one. There are some incompatible
>> files which will be fixed with another patch.
> Driver stopped supporting two IRQ lines in commit
> 7222e8db2d506197ee183de0f9b76b3ad97e8c18 (iommu/exynos: Fix build
> errors). The second IRQ line in Exynos3250 DTS seems to be ignored.
>
> The patch now looks good to me:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> However for some reasons you did not CC the IOMMU maintainers. Please
> use scripts/get_maintainer.pl to get the list of folks to CC.

Frankly I don't see any reason to spam IOMMU ml or maintainer with this 
discussion about dt-binding conversion. This patch will be merged via dt 
tree if I got it right.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

