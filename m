Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F66C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434EA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZYyjbiU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfILG4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:56:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51930 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbfILG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:56:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190912065608euoutp02cdf2faeeb4ee7f852e55d9b2f853957e~DnoBCdoht1667116671euoutp02L
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:56:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190912065608euoutp02cdf2faeeb4ee7f852e55d9b2f853957e~DnoBCdoht1667116671euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568271369;
        bh=SXyZ7BFmp7DTbszG2J0W99CFEbiXjbkhhWkifCd4LFo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZYyjbiU+5YSPhYVOHlDNILuT9fvZrioaOBm6EouI8OLpN9BHEqXwCa7nj35q0PrLf
         Vvp5mzxlR4UtPTPeVhsruocIB1HhMPMjWSrgTE6sDIlaAbfgRdRkE4HYqRe07zaJf3
         wAV3FqWD8PLnjSZuRA/ZF9Zm63nXaSq0s1QbRg5U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190912065608eucas1p1d3035ea751c5df6756d6761027d0c172~DnoAXvxd82976929769eucas1p1c;
        Thu, 12 Sep 2019 06:56:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 29.5F.04469.70CE97D5; Thu, 12
        Sep 2019 07:56:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190912065607eucas1p181db5a82e2979b1fc44d6ab3218d0baa~Dnn-kUtQK1580015800eucas1p1U;
        Thu, 12 Sep 2019 06:56:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190912065607eusmtrp2f2499608759d8e0464f00a91259e2d45~Dnn-WLz4v1406714067eusmtrp2t;
        Thu, 12 Sep 2019 06:56:07 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-5f-5d79ec077324
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.EB.04166.70CE97D5; Thu, 12
        Sep 2019 07:56:07 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190912065606eusmtip11861b3157f5bf44dff9efabafe47586d~Dnn_tg_AT1027410274eusmtip1K;
        Thu, 12 Sep 2019 06:56:06 +0000 (GMT)
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <39cac04f-684f-ffa5-a5ba-d1734fa00477@samsung.com>
Date:   Thu, 12 Sep 2019 08:56:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTtmzfvzXNw7HNUvGkkDFRUNGa2PColoR8DEWT0I0vLKZ8LuTGL
        qW2mFjZJxoRok2SlZWnmkrmMWeqYa+6l4rSYI6mlJI0Sbpnjw/LfueecyzkXLk2IK0gnOiRc
        xSrC5aESSsgvrZ9u2yoYi/Hb9s6wm6mfLKGYeW29gMmsayOZFNMPgmlvLxQwxaYekunWZ1BM
        evtrHtPca6YYU+8ctV8om53RIllx7nVK9iL7sux9YzwpMxevO0weF+4LYENDoliFq6e/MPhb
        6oQgMhFHG+f6UBwyWmuQFQ14Bwx3zxMaJKTF+AmCh/oUyiKI8SSC9NaLnGBGMFP2m7+8YTbc
        JTkhB8GzqQ98bhhHkN2XhCwuO+wBNamdAgu2xzKom73Ks5gIPMEDfbyRZxEo7Aaacc1Sngh7
        QmFywuIyTfPxenhT6m6hHbAv5IwN8DmLLTTdGVrCVtgbRpo+LmUR2AXKxjMIDjtC/1DmUhbg
        ZgE0l1WSXO0D8LazleCwHXxvKBFweC0sVCwvJCD42pYv4IZkBN3x6Yhz7QVDQydpaUfgTVCg
        d+VoL7iiGeRZaMA20Dduy5WwAW1pGsHRIki6JubcG0DX8PxfbE1HF3ELSXQrTtOtOEe34hzd
        /9z7iJ+LHFm1MiyIVbqFs+ekSnmYUh0eJD0TEVaMFh+q5U/Dr3I01XW6FmEaSaxF+FO0n5iU
        RyljwmoR0ITEXjSQuEiJAuQxsawi4pRCHcoqa5EzzZc4is6vGjghxkFyFXuWZSNZxbLKo62c
        4pBvT8uRe+7zT3/mO++pmtLlywJdoh8cHB3zqUz2xpIOu12BHtUeM9XSnRPBqscuW0zTyRvV
        zM2sV/2qevzSkOd5rKDIR1jepU+zW6OivGI/kzfsyQveBdovJyOHH2kdpNtH/Kl5yqsiT2eY
        mjmadaiosSrBuDA8WDR6+1Klr2m1hK8MlrttJhRK+V8OsPZbTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rsbypjDdb2sFsc+7KFzeLvpGPs
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsTl3/zGbx+PofNgcuj9+/JjF6bFrV
        yeaxeUm9x5UTTawenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GU8m/qBvaBFoOL2nxuMDYy3eboYOTkkBEwkPh+ezdrFyMUhJLCUUeLq
        8jNsEAkZiZPTGlghbGGJP9e62CCKXjNKnO9ezwKSEBawlTg49SI7iC0i4CFx5HcrE0gRs8An
        JolHt6dAdUxlkvjd28cMUsUmYCjR9bYLbAWvgJ3Ehp5mxi5GDg4WAVWJ/duMQcKiAjES26ZO
        YoUoEZQ4OfMJ2DJOgUCJFyfvMILYzAJmEvM2P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0
        zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbnt2M/NOxgvbQw+xCjAwajE
        wytwtyJWiDWxrLgy9xCjBAezkgjvgxagEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucD00Ve
        SbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGdDMt7vSXk9dVLak+
        ZBvA6COyozVczP2N9dM1m7++udacfLrG99CTFcu0dO/989A32aqbePdSefK/qpmWD89dy/au
        W+cjq3pvwvbDUt2iLjd5FeI0H69eeuyYoGbfBK/SU9FhS5ZO7Pj7KNw/8oT7vY7XF48YdPlo
        +Gh+2vFWWD0xLVfxlm2rEktxRqKhFnNRcSIA4Pt9T98CAAA=
X-CMS-MailID: 20190912065607eucas1p181db5a82e2979b1fc44d6ab3218d0baa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190912063304epcas2p43dce48bd815124121c65ea47fd2dfc26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190912063304epcas2p43dce48bd815124121c65ea47fd2dfc26
References: <20190911183632.4317-1-krzk@kernel.org>
        <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
        <CGME20190912063304epcas2p43dce48bd815124121c65ea47fd2dfc26@epcas2p4.samsung.com>
        <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2019-09-12 08:32, Krzysztof Kozlowski wrote:
> On Wed, 11 Sep 2019 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Hi,
>>>
>>> Unfortunately the patches were applied right after closing the linux-next.
>> Hi Krzysztof,
>>
>> I took a look at these and am not convinced this is right:
>>
>>> 1. Fix boot of Exynos7 due to wrong address/size of memory node,
>> The current state is clearly broken and a fix is needed, but
>> I'm not sure this is the right fix. Why do you have 32-bit physical
>> addressing on a 64-bit chip? I looked at commit ef72171b3621
>> that introduced it, and it seems it would be better to just
>> revert back to 64-bit addresses.
> We discussed with Marek Szyprowski that either we can go back to
> 64-bit addressing or stick to 32. There are not known boards with more
> than 4 GB of RAM so from this point of view the choice was irrelevant.
> At the end of discussion I mentioned to stick with other arm64 boards
> (although not all), so revert to have 64 bit address... but Marek
> chosen differently. Since you ask, let's go back with revert.

I decided to go with 32bit version to make the fix smaller and easier to 
backport. If you select revert, make sure that it is applied after 
moving gpu node under /soc, otherwise the gpu node will have incorrect 
(32bit) reg property. Also add the gpu related patch as an (optional?) 
prerequisite for it.

>> 2. Move GPU under /soc node,
>> No problem
>>
>>> 3. Minor cleanup of #address-cells.
>> IIRC, an interrupt-controller is required to have a #address-cells
>> property, even if that is normally zero. I don't remember the
>> details, but the gic binding lists it as mandatory, and I think
>> the PCI interrupt-map relies on it. I would just drop this patch.
> Indeed, binding requires both address and size cells. I'll drop it.

Ookay, I wasn't aware of that.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

