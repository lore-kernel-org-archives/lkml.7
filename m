Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8842086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fd7GuDcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDANQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:16:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34550 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfDANQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:16:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401131633euoutp02ef75e5a3a25988bc26c8b503ce2adb3d~RXBVcTqFK2477824778euoutp02n
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:16:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401131633euoutp02ef75e5a3a25988bc26c8b503ce2adb3d~RXBVcTqFK2477824778euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554124593;
        bh=mibWue7QuNNezncQWsgWSAUwZNKCA5Ta+n61eyFIY74=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Fd7GuDcJSLZ1amTWWlVNdkMZOEhngpCOyu9VfpTp/KaLj8VH4TUH9hKdyCYrII+FV
         pbZAlaZJeLZKwmZtCk7iWTBbCsckrmgURCBGJQiPKzylMqK1CtCEe9bJf1hMsY2rz/
         mTbNiXJOAWyakxcO2M36rnJTThgJgEb12KmIkZQs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401131632eucas1p18b5752c6c5c9a56b7d8c6c8e58739106~RXBVJu4Ca1292312923eucas1p1w;
        Mon,  1 Apr 2019 13:16:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.3E.04325.03F02AC5; Mon,  1
        Apr 2019 14:16:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401131632eucas1p299b882abdd04fcb032c41a23b4e41a9f~RXBUXDEy_0091200912eucas1p2m;
        Mon,  1 Apr 2019 13:16:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401131632eusmtrp1102518d8e6595396243a4a4aea2b69c5~RXBUU4lEO2400724007eusmtrp1P;
        Mon,  1 Apr 2019 13:16:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-7c-5ca20f30291e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 27.B4.04140.F2F02AC5; Mon,  1
        Apr 2019 14:16:31 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401131631eusmtip2f36eb40f91ca15125549954a99d67982~RXBUB8fpX3140331403eusmtip2l;
        Mon,  1 Apr 2019 13:16:31 +0000 (GMT)
Subject: Re: [PATCH] drivers: video: fbdev: Kconfig: pedantic cleanups
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c5378abe-a2e5-720b-e8de-f90547210d78@samsung.com>
Date:   Mon, 1 Apr 2019 15:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1551898908-24695-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzneV0D/kUxBjNWalhc+fqezeJm424m
        ixN9H1gtLu+aw2Yxe0k/iwOrx/3u40weEz68ZfP4vEkugDmKyyYlNSezLLVI3y6BK+Pfxu+s
        BauYKx5O4m5gvM3UxcjJISFgIvHm/V1mEFtIYAWjxJoHiV2MXED2F0aJr3P3MEI4nxklDm48
        wQrTca7hNStEYjmjxI1L3VBVbxklfu7aCDZLWMBNoqtxCQuILSJgLvH4yUKwbmaBGoklx7aA
        1bAJWElMbF/FCGLzCthJNHxeClbDIqAisf3RLSCbg0NUIEKi/4w6RImgxMmZT8BGcgrYS1zp
        XM0IMdJA4siiOVDj5SW2v53DDHKPhEAzu0TXtl6oP10kVl7rhfpAWOLV8S3sELaMxOnJPSwQ
        DesYJf52vIDq3s4osXzyPzaIKmuJw8cvQnU7Slyat5gN5DoJAT6JG28FITbzSUzaNp0ZIswr
        0dEmBFGtJrFh2QY2mF1dO1cyQ9geEgfb37FPYFScheS3WUj+mYXknwWMzKsYxVNLi3PTU4uN
        81LL9YoTc4tL89L1kvNzNzECk8jpf8e/7mDc9yfpEKMAB6MSD28F08IYIdbEsuLK3EOMEhzM
        SiK8Z/oXxAjxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg
        lIg+7rgr8vHcxA1tG6I//164nsnwk8XKuc0P7fVm/Nz22fSG1LWDdS8DWD8Kss+7sunznptV
        mqdZXF9OE056bXgvbNmSH0fO2a3+aPt9QpRc0Nq2xBlbDvc/u2KcbflL9PjEj+4iXzYzSspf
        28ft9ehTmFm82r8Lgb/nqaifCKucZvp08n7dRalKLMUZiYZazEXFiQBr44GMHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7r6/ItiDBa3WVtc+fqezeJm424m
        ixN9H1gtLu+aw2Yxe0k/iwOrx/3u40weEz68ZfP4vEkugDlKz6Yov7QkVSEjv7jEVina0MJI
        z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pfxu+sBauYKx5O4m5gvM3UxcjJISFg
        InGu4TVrFyMXh5DAUkaJ+9PuMXcxcgAlZCSOry+DqBGW+HOtiw2i5jWjxN+eB2wgCWEBN4mu
        xiUsILaIgLnE4ycLoQZNYpTY/qGZFSTBLFAj0TV/Adg2NgEriYntqxhBbF4BO4mGz0vBalgE
        VCS2P7oFZosKREjcetjBAlEjKHFy5hMwm1PAXuJK52pGiJl6Ejuu/4KaLy+x/e0c5gmMgrOQ
        tMxCUjYLSdkCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgbGx7djPLTsYu94FH2IU4GBU
        4uGtYFoYI8SaWFZcmXuIUYKDWUmE90z/ghgh3pTEyqrUovz4otKc1OJDjKZAT0xklhJNzgfG
        bV5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkaudyq39LO7k6f2
        LDm0s2LRmzMXy6atscz4+rFi9vIlCyc8/pA+TXhr86+9Hl9Y67Uaq5WnKNzNFpkfuuNE+POL
        8R8tueKyP/VHzeuc61l5oY2ri9mK5SPXt3+u+1IfKjYXmzS7Sqpxs8Rcv3wxR5Pl9y0b02O3
        t+46aCu2cMXuXZN3VW6bUfpEiaU4I9FQi7moOBEAAgs0TaMCAAA=
X-CMS-MailID: 20190401131632eucas1p299b882abdd04fcb032c41a23b4e41a9f
X-Msg-Generator: CA
X-RootMTR: 20190306190156epcas2p30a9d639eb71d0a5c72b17193c41c98e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190306190156epcas2p30a9d639eb71d0a5c72b17193c41c98e7
References: <CGME20190306190156epcas2p30a9d639eb71d0a5c72b17193c41c98e7@epcas2p3.samsung.com>
        <1551898908-24695-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/06/2019 08:01 PM, Enrico Weigelt, metux IT consult wrote:
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch queued for v5.2 with

"Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up."

added as a patch description, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
