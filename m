Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C60BC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9C212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V6osQn01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfFGMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:23:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37996 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfFGMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:23:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607122314euoutp01156654a3ace9c60b12eef89600ae3634~l6g6q85SI2912429124euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:23:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607122314euoutp01156654a3ace9c60b12eef89600ae3634~l6g6q85SI2912429124euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910194;
        bh=ij0CHRSsbz3B1sP4qpNN4G9lp/PI1xazYBLkCGLAdn8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V6osQn01huSZ2qFngDzh6FgCrVnnbGGBJPksKT10SZmsBfP4RtKSDNX4pL3JQPn76
         aE9B0pfS279bVWxLES1ATz2xztU8q1I9yqDHGn5IW2iuY1Y1syQmdf/jzsP74hu5d4
         n+07ph6cmBxvIBPXYjJ82rwWZkBZnJD6Kxzv7sxw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607122314eucas1p2151e2a94f7d425b1207c6c87fb503441~l6g6V69CI3165931659eucas1p2y;
        Fri,  7 Jun 2019 12:23:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.84.04298.1375AFC5; Fri,  7
        Jun 2019 13:23:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607122313eucas1p221888f45771149f9ea67dbbacbea81f9~l6g5Jp9XS0604406044eucas1p2K;
        Fri,  7 Jun 2019 12:23:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607122312eusmtrp2d7bde8707d398f5235cfd42bbac0869d~l6g46GUOP0428004280eusmtrp2E;
        Fri,  7 Jun 2019 12:23:12 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-20-5cfa57319bf8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.C1.04140.0375AFC5; Fri,  7
        Jun 2019 13:23:12 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607122312eusmtip117a067948ef952a766d1ac9f676a9076~l6g4n4nFd1730017300eusmtip1B;
        Fri,  7 Jun 2019 12:23:12 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: atafb: remove superfluous function
 prototypes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b1b4d156-ca2a-2c2f-fce1-097a1eb270dc@samsung.com>
Date:   Fri, 7 Jun 2019 14:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVbFaY583xJMd9kkW=-dQDY_yPAeToQT854kWFvokECLw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzneV3D8F8xBuc+G1pc+fqezeLZrb1M
        Fif6PrBaXN41h82BxePQ4Q5Gj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MrY/8G54A1zxe9p
        Z5gbGOcydzFyckgImEgc+LyRHcQWEljBKHG9y7yLkQvI/sIo8XnCD1YI5zOjxPwPH4A6OMA6
        Tq7xgYgvZ5R49P40G4TzllHiwcF/YGOFBYIkDu+8ygrSICKgKzHnJxNIDbPAekaJN8+3soLU
        sAlYSUxsX8UIUsMrYCfx468USJhFQEVid3MvWImoQITE/WMbwGxeAUGJkzOfsIDYnAKBEtOv
        rQZbxSwgLnHryXwmCFteYvvbOcwguyQE+tklvj4+BvWmi8TGFxuhbGGJV8e3sEPYMhL/d85n
        gmhYxyjxt+MFVPd2Ronlk/+xQVRZSxw+fhHsG2YBTYn1u/Qhwo4STU9ns0FChU/ixltBiCP4
        JCZtmw4NLF6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFu
        emqxYV5quV5xYm5xaV66XnJ+7iZGYDI5/e/4px2MXy8lHWIU4GBU4uH1YP8ZI8SaWFZcmXuI
        UYKDWUmEt+zCjxgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwc
        nFINjBprOrmXLMySkVp9aveff48mL7hcdF5z79n1W4JjUhPzHul46C5T+TL/bdRNprhqsReM
        CY1zmoz+5T1d3czifc/3hPK8Cpvls1vYnv+Lqqjf33LqgYCTxjfjid0XXa5kLm/fdfLXsi1q
        eVPrb5ir8uqlH7j1XGF+i9Dl25tCD8fU6+teFP676rISS3FGoqEWc1FxIgCWiUk/IgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7oG4b9iDM5P0bK48vU9m8WzW3uZ
        LE70fWC1uLxrDpsDi8ehwx2MHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex/4NzwRvmit/TzjA3MM5l7mLk4JAQMJE4ucan
        i5GLQ0hgKaPEzcU7oOIyEsfXl3UxcgKZwhJ/rnWxQdS8ZpRYeaKFESQhLBAkcXjnVVaQehEB
        XYk5P5lAapgF1jNK9Fz5ygLRcJNR4s2JXUwgDWwCVhIT21cxgjTwCthJ/PgrBRJmEVCR2N3c
        ywpiiwpESJx5v4IFxOYVEJQ4OfMJmM0pECgx/dpqZhCbWUBd4s+8S1C2uMStJ/OZIGx5ie1v
        5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwerYd+7ll
        B2PXu+BDjAIcjEo8vDOYfsYIsSaWFVfmHmKU4GBWEuEtu/AjRog3JbGyKrUoP76oNCe1+BCj
        KdBzE5mlRJPzgZGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDUwoY
        RRG+UixdL4ovvoq22+NmzeqS4NO/cdbUeW6X43Q+h2V+ZZlj+4TR+q/LQ5ZL1o8v2j4oWm4v
        IvyJ2bXDqY3Jqtn12KTGi2F6/umPUiMeP9I5xvqZX+vP2d+vjR2OF3BwzWF8vPKnZoLjtDR/
        1tOz1Zl/agQzl/pU3JvVsoHvkmbkBxvOqGNKLMUZiYZazEXFiQAIMlRhtAIAAA==
X-CMS-MailID: 20190607122313eucas1p221888f45771149f9ea67dbbacbea81f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c
References: <CGME20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c@eucas1p2.samsung.com>
        <50411fd1-9da0-aab6-709e-749d5e0ce509@samsung.com>
        <CAMuHMdVbFaY583xJMd9kkW=-dQDY_yPAeToQT854kWFvokECLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/19 4:12 PM, Geert Uytterhoeven wrote:
> On Tue, May 21, 2019 at 4:02 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> No need for them.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Thanks, I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
