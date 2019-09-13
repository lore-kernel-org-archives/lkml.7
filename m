Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBA1208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aOg4Krmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbfIMJPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:15:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57666 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:15:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190913091547euoutp02df98289e11fa330767ab25da54af5552~D9LOB2_Hf2208222082euoutp024
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190913091547euoutp02df98289e11fa330767ab25da54af5552~D9LOB2_Hf2208222082euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568366147;
        bh=PR7plf5xfUSTBIvJtmBM06aLqddyK3IZ5QA/vHAAwdw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aOg4KrmrmGdFVwzw6e0usS8/Yv3K4SANdhFp94RdkDEyCZN/xVZJ0VXvgMwklM8PP
         Vf5/260J5pGsWYjSre47xnEBidyoq7kEZHr2A5to9DW7WwlVzwwPqle7YhPpspjbzz
         FDdheFdQ4C+W+9MeUcrPtLy+CeHGhSij4/Gf+rB4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190913091546eucas1p28a71702dd105aaf9caf2f1c16f8ed313~D9LNXOJPV0954009540eucas1p2H;
        Fri, 13 Sep 2019 09:15:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.2E.04374.24E5B7D5; Fri, 13
        Sep 2019 10:15:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190913091545eucas1p17e7a786e078fdc38ae56b1cd56e30543~D9LMh7_gR1367913679eucas1p1C;
        Fri, 13 Sep 2019 09:15:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190913091545eusmtrp23bf17003f06fe85b2bde552261e5553a~D9LMT1BFD2926629266eusmtrp23;
        Fri, 13 Sep 2019 09:15:45 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-3d-5d7b5e42f38c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.53.04166.14E5B7D5; Fri, 13
        Sep 2019 10:15:45 +0100 (BST)
Received: from [106.120.51.73] (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190913091544eusmtip223f7b61a5537b436821aa1ceb5f8b59e~D9LLzUcX63102731027eusmtip2G;
        Fri, 13 Sep 2019 09:15:44 +0000 (GMT)
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, a.hajda@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e082996a-743d-807a-38c0-dee65b490771@samsung.com>
Date:   Fri, 13 Sep 2019 11:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913062945.GA10283@pi3>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pOcdWxBlcns1ncWneO1aL33Ekm
        i//bJjJbzD8C5F75+p7N4vz5DewWl3fNYbOYcX4fk8WD5nVsFkuvX2SyaN17hN2B22PNvDWM
        Hnu/LWDx2LSqk81j+7cHrB73u48zefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGqwu32Av+
        cFSs3PSdsYGxl72LkZNDQsBE4ufiM6wgtpDACkaJ3/vsuhi5gOwvjBJP1pxlhnA+M0rM2tnE
        BNNx4tl2dojEckaJj4/vMEE4bxkl3v05zwhSJSwQJrH8UwsLiC0iEC6x6OQRsFHMAi8YJT49
        nQI2ik3AUKLrbRcbiM0rYCcx481EsDiLgKrEi+bbYLaoQITEpweHWSFqBCVOznwCNpRTQFOi
        /dI7sDizgLzE9rdzmCFscYlbT+aDXSQhcItdYt/ByUALOIAcF4lD+xUhXhCWeHV8CzQAZCT+
        74Spb2aUeHhuLTuE08MocblpBiNElbXE4eMXWUEGMQNtXr9LHyLsKPHyRSs7xHw+iRtvBSFu
        4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRaSz2Yh+WYWkm9mIexdwMiyilE8tbQ4
        Nz212DgvtVyvODG3uDQvXS85P3cTIzCBnf53/OsOxn1/kg4xCnAwKvHwWuhUxQqxJpYVV+Ye
        YpTgYFYS4fV5UxkrxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJ
        g1OqgVHl73O7mXMdLi2vyOuv/vL3ZegtPb0LV3QzFGenF84/bfgw/fez4ysf6Si+XcsX9rxy
        wTqGSI2dAX16pguizR8Usz2xSpL9LvKgfrY296XwkH4vh9oW5RNXLB2frJ934Zx99ckbxh8S
        Oj8/vZWes2vtbQuxnqoL080W3vsc/0Gb9ev7Nc/r365VYinOSDTUYi4qTgQAKJNCfFwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7qOcdWxBrvn8FjcWneO1aL33Ekm
        i//bJjJbzD8C5F75+p7N4vz5DewWl3fNYbOYcX4fk8WD5nVsFkuvX2SyaN17hN2B22PNvDWM
        Hnu/LWDx2LSqk81j+7cHrB73u48zefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gqwu32Av+cFSs3PSdsYGxl72LkZNDQsBE
        4sSz7UA2F4eQwFJGiUsT17JAJGQkTk5rYIWwhSX+XOtigyh6zSjRuuAZE0hCWCBMYvmnFrAG
        EYFwiSsL7jODFDELvGCUePzhHdTYe4wSP5qvsoFUsQkYSnS97QKzeQXsJGa8mQg2iUVAVeJF
        820wW1QgQuLwjlmMEDWCEidnPgHbwCmgKdF+6R3YScwCZhLzNj9khrDlJba/nQNli0vcejKf
        aQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgVG77djPzTsY
        L20MPsQowMGoxMNroVMVK8SaWFZcmXuIUYKDWUmE1+dNZawQb0piZVVqUX58UWlOavEhRlOg
        5yYyS4km5wMTSl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbm
        pqXHC6z2c3tPX8aoWvZF33WZ6NnOtvpNWzhklm1qizjG/3yW57r7Lh+3rir5yJ+7i7/FgE0n
        cjJrQKPrrHSDN5p7XxpdFTncKCrovXanQ2P1nbnH5mzavMBSg5e95eGa6RxXf0SoTFTlv9H7
        LWuCUb7Oe2OHy4s8VYR81Wapdk99oOqdG6vEUpyRaKjFXFScCAD/MUv48AIAAA==
X-CMS-MailID: 20190913091545eucas1p17e7a786e078fdc38ae56b1cd56e30543
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a
References: <20190912093315.5744-1-m.falkowski@samsung.com>
        <CGME20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a@eucas1p2.samsung.com>
        <20190912161538.4321-1-m.falkowski@samsung.com> <20190913062945.GA10283@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 9/13/19 8:29 AM, Krzysztof Kozlowski wrote:
> On Thu, Sep 12, 2019 at 06:15:38PM +0200, Maciej Falkowski wrote:
>> Convert Samsung Image Rotator to newer dt-schema format.
>>
>> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Just to make it clear, Marek's signed-off should appear for one of
> conditions:
>   - he contributed some source code to your patch,
>   - he took your patch, rebased, send by himself (not a case here, I
>     think),
>   - he contributed significant ideas, although for this there is a
>     "Co-developed-by" tag.
>
> If someone made just review - add Reviewed-by. If someone suggested the
> patch - add Suggested-by.

My signed-off here was added to mark that this patch is allowed to be 
submitted to the public mailing list, as I have required company 
permissions for such activity. It is not that uncommon that a given 
patch has more than one signed-off and still the main author has the 
first signed-off tag.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

