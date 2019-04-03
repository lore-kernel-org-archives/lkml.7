Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A629DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386E020700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hv/Jmibv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDCNxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:53:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56528 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:53:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190403135352euoutp01e2f033006b576f9608811c77a46f3799~R_0fmhGDf2214122141euoutp01I
        for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2019 13:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190403135352euoutp01e2f033006b576f9608811c77a46f3799~R_0fmhGDf2214122141euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554299632;
        bh=qf0xaaW1pFSY6bCAKm8dMd4djT9c9aATrqm5DPM+kXc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hv/JmibvYB/A9tjlkeUIR9nyaXxz/HDVo6cUq51spI4Ryc8d2C27JUYkjeQcaR/2e
         qgm/8eKBMQxJAD8IBUYyBSDL15NbtBLovg2m4elfVoO9OdLmbIhQFUxKubrRn59oQJ
         JETxHVVRuAvO6R+m2iGN4K6EXmJCTiLZxDAixHJc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190403135352eucas1p2a145c688a51a03a314b8a5d0bc78bdb4~R_0fC19EW1883418834eucas1p2Z;
        Wed,  3 Apr 2019 13:53:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.A5.04298.FEAB4AC5; Wed,  3
        Apr 2019 14:53:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190403135351eucas1p211f27a7f1ea77e83b6dfe8657b73c2e8~R_0eS9rJT2976529765eucas1p2S;
        Wed,  3 Apr 2019 13:53:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190403135351eusmtrp205793af612a9d8c4cec3b3e61874042d~R_0eE1krV2171621716eusmtrp2H;
        Wed,  3 Apr 2019 13:53:51 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-e3-5ca4baefa28e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.70.04140.EEAB4AC5; Wed,  3
        Apr 2019 14:53:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190403135350eusmtip1b92e92553450409f23b79546f63295d1~R_0dxfuja1027810278eusmtip17;
        Wed,  3 Apr 2019 13:53:50 +0000 (GMT)
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one
 maintainer.
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tom Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LFBDEV <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9c99beba-813d-e82a-6ce5-fd1ffec45022@samsung.com>
Date:   Wed, 3 Apr 2019 15:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7rvdy2JMfi/Vdviytf3bBYn+j6w
        WlzeNYfN4sDpKcwWa5bsYbSYNjPHgc1j56y77B73u48zeTy//5TNY/buXlaPz5vkAlijuGxS
        UnMyy1KL9O0SuDJWfZzLWvBbrOLi13dsDYwHhboYOTkkBEwkzl6/yg5iCwmsYJQ4v9YUwv7C
        KLH3XGQXIxeQ/ZlR4sCHr4xdjBxgDU1bRSDiyxklXh18zgzhvGWUaDi7mQ2kW1ggSOLm1/ks
        ILaIgKfEjZ4pTCBFzAIbGSWmT30Oto5NwEpiYvsqRhCbV8BOYs2bi2ANLAIqEiv+NLOBbBMV
        iJDoP6MOUSIocXLmE7ASToFAicvXZzOB2MwC8hLb384BO0JCYBG7xNv1f1khXnORmPHtKTOE
        LSzx6vgWdghbRuL/zvlMEA3rGCX+dryA6t7OKLF88j82iCpricPHL7KCXMEsoCmxfpc+RNhR
        Ytq/FWyQoOCTuPFWEOIIPolJ26YzQ4R5JTraoKGrJrFh2QY2mLVdO1dCneMhca3/IOMERsVZ
        SF6bheSdWQh7FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMLqf/Hf+0g/HrpaRD
        jAIcjEo8vD9WL4kRYk0sK67MPcQowcGsJMJ7pn9BjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        aoYH0UIC6YklqdmpqQWpRTBZJg5OqQZGlj1fdle9eLPa49jRm7vZVzCmz63ym7/Q69e+JTa7
        cvIWhlj1dDzxOi2zZabdSt7sCansiVf3zrtca83s0fPpXe6RWp4WrW3dKSLFS6MVBda48axP
        NyncNX+PXVFFxv4dKQW2UwKvMD/lzdi7P3tPCts5gZPnxCY//bXymqUqx/U9SZ1H1sUIK7EU
        ZyQaajEXFScCAO9BZ+YqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7rvdi2JMbh4y9riytf3bBYn+j6w
        WlzeNYfN4sDpKcwWa5bsYbSYNjPHgc1j56y77B73u48zeTy//5TNY/buXlaPz5vkAlij9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWfZzLWvBb
        rOLi13dsDYwHhboYOTgkBEwkmraKdDFycQgJLGWUODX9IyNEXEbi+PqyLkZOIFNY4s+1LjYQ
        W0jgNaPEn/euILawQJDEza/zWUBsEQFPiRs9U5gg5lxhkpgyt4kRxGEW2MwocejFfCaQKjYB
        K4mJ7asYQWxeATuJNW8ugnWzCKhIrPjTDLZBVCBC4tbDDhaIGkGJkzOfgNmcAoESl6/PBpvD
        LKAu8WfeJWYIW15i+9s5zBMYBWchaZmFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAuNm27GfW3Ywdr0LPsQowMGoxMP7Y/WSGCHWxLLiytxDjBIczEoivGf6F8QI8aYkVlal
        FuXHF5XmpBYfYjQFemIis5Rocj4wpvNK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqem
        FqQWwfQxcXBKNTBu/rr9r0nO74XRbNxPNixgVp81XWrSH70InYlSEQnbkiU/7Ttw3+GlipPi
        /cxyViafzLPCi2rr569ONFw54dv+5PNZB0OdFmolxyzZmLVN5da2pAOhyuUhN3f7G5jJMhqe
        2PM+aOkD/xXLmt2FJIU4DPNFt34UM0l+c+r06R/JS96FzT4ur7pdiaU4I9FQi7moOBEAXyTr
        urECAAA=
X-CMS-MailID: 20190403135351eucas1p211f27a7f1ea77e83b6dfe8657b73c2e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190402211010epcas2p3721fd8da621ee64c2b1a373d41cc89e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190402211010epcas2p3721fd8da621ee64c2b1a373d41cc89e7
References: <20190322051759.15007-1-tomli@tomli.me>
        <20190322051759.15007-8-tomli@tomli.me>
        <20190331190801.hxl57om56jskku5s@debian>
        <20190401174103.GF15736@localhost.localdomain>
        <CGME20190402211010epcas2p3721fd8da621ee64c2b1a373d41cc89e7@epcas2p3.samsung.com>
        <CADVatmPtQAfSC=UkYWHKUx98JK=PMcSZB29ULeQKTBLD9iPnkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2019 11:09 PM, Sudip Mukherjee wrote:
> On Mon, Apr 1, 2019 at 6:41 PM Tom Li <tomli@tomli.me> wrote:
>>
>> On Sun, Mar 31, 2019 at 08:08:01PM +0100, Sudip Mukherjee wrote:
>>> Technically I donot have any problem with this, you seem to know more
>>> about SM712 than I know. But Teddy Wang is also an existing maintainer
>>> and I think there should be an ack from him before this is accepted.
>>
>> Okay, I'll write a personal mail to Teddy. I think it could be a separate
>> patch to allow more time for communication, but the problem is that, if

The first version of the patchset was posted on 2nd February and
Teddy was on Cc:. Unless there is an explicit NACK (with valid
rationale) from him lets assume that he is fine with having another
co-maintainer.

>> the MAINTAINERS and the new changes are not merged at the same time, users
>> who have problems may unable to see my name and E-mail address for reporting
>> problems.
> 
> git will not forget that you have done the changes. :)
> So anyone who has a problem only needs to do a "git blame" to see who
> has done it and the user will get your name and email to contact you.
> If that is the only reason you think your name is added as a

The original patch description suggests that there is more than
that:

"I have working on the sm712fb driver for a while and have some
familiarity with this hardware, I'll be helping working on and
testing problems of this driver, so add myself to the MAINTAINERS
file."

> maintainer then I guess that is not a valid concern and then in that
> case I am not seeing any need to add your name in maintainer.
> 
> Bartlomiej can you advise please.

2D acceleration seems to be an important contribution to the driver
(functionality wise and code wise -> it grows the driver source code
by ~25%) and it shows that Yifeng knows the driver well.

He has also access to SM720 (you have SM712 only) to verify potential
issues with the future driver changes (I assume that he don't mind
getting Cc:ed on all driver related patches, not that there should be
much of them).

Thus I think that it would be beneficial to add him as the driver
co-maintainer but I would prefer to keep the current ordering in
the MAINTAINERS file, IOW something like this:

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS	2019-04-01 13:12:10.607271933 +0200
+++ b/MAINTAINERS	2019-04-03 15:39:54.404646279 +0200
@@ -14143,6 +14143,7 @@ SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
+M:	Yifeng Li <tomli@tomli.me>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/sm712*


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
