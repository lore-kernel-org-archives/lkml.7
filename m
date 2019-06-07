Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF47C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7EF208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZTOKJShH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfFGMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:34:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41807 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfFGMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:34:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607123417euoutp019b6e654466d38ecb6a8a68ac5ae684f8~l6qkQ864C0331003310euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607123417euoutp019b6e654466d38ecb6a8a68ac5ae684f8~l6qkQ864C0331003310euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910857;
        bh=C9zZYL4Oupw/s/ug0pe1BkeLpxedG0UIeuMqKs7Ti7o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ZTOKJShHElhACzIrbF+5cn1usNRy9gq/7Pqzqd/zq3DLqLLr2l3mCljLadeJyNPeo
         XC38DpMX4EaJF3dFGBBXWB1VyPDF6pGQrOx2igjkh229UcWBr8ncRur6M7FWfFL6BQ
         cUWdsJBm0n2gGgj/W2ky37QYYdA4Iy73t01r1nVQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607123417eucas1p1579ac77f6dab482898a969b95f3dbdfe~l6qj77LNs0536405364eucas1p1g;
        Fri,  7 Jun 2019 12:34:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.D5.04298.8C95AFC5; Fri,  7
        Jun 2019 13:34:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123416eucas1p26b0c4a07ba6e0df82b1eda761a0f1826~l6qjGVbCk2754527545eucas1p2q;
        Fri,  7 Jun 2019 12:34:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607123416eusmtrp27950baecf5100ddb99a2a527e05e1aff~l6qi21qGO1092410924eusmtrp2W;
        Fri,  7 Jun 2019 12:34:16 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-76-5cfa59c89800
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.13.04140.8C95AFC5; Fri,  7
        Jun 2019 13:34:16 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123416eusmtip2486eea84d94d6a978bbe2134d9f1f9d0~l6qiohWtd2452524525eusmtip2A;
        Fri,  7 Jun 2019 12:34:16 +0000 (GMT)
Subject: Re: [PATCH 1/2] video: fbdev: pvr2fb: remove function prototypes
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <48846eb7-efdc-b26e-d331-d3ad1d8dbea4@samsung.com>
Date:   Fri, 7 Jun 2019 14:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2a32648a-69c8-47a6-109a-6c2f764b2534@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned2Tkb9iDCbNYLS48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujL29qgVXmCr6zv5jb2CcwdTFyMkh
        IWAiMevbYcYuRi4OIYEVjBJP57xhg3C+MEqcPr+GDaRKSOAzo8SB1SIwHccvX4AqWs4ocfva
        J6j2t4wSsy+eBusQFvCUeLPzACuIzSZgJTGxfRUjiC0ikCCxYvoMMJtXwE5i1qwJYDUsAioS
        D3pnsYDYogIREvePbWCFqBGUODnzCVicU8BeYt3TxcwgNrOAuMStJ/OZIGx5ie1v5zCDHCEh
        8J5N4sOVCcwQp7pIzNo6kxXCFpZ4dXwLO4QtI/F/J0gzSMM6Rom/HS+gurczSiyf/I8Nospa
        4vDxi0DdHEArNCXW79KHCDtK/Fv1jgkkLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJbFi2
        gQ1mbdfOlVCneUg8f7yXaQKj4iwkb85C8tosJK/NQrhhASPLKkbx1NLi3PTUYsO81HK94sTc
        4tK8dL3k/NxNjMDkcfrf8U87GL9eSjrEKMDBqMTD68H+M0aINbGsuDL3EKMEB7OSCG/ZhR8x
        QrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhij+RtC9t+Y
        +Mag49gP04WfLbV0FQyTAyMVfSYeubNmju3u04lsyhl6pVlxKr7zRIsn9pVH3720MeZP+vka
        ln1qbO4mtXaHX66auChbyG6z8XWO01M2ZFs9mHmb22rpPP+I035SNSyCgkFJc0/se7cp7YPH
        xRJB2R/fHl3n2TRP/HZPZk1LR6USS3FGoqEWc1FxIgC0EyYHGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd0Tkb9iDB4u4be48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jL29qgVXmCr6zv5jb2CcwdTFyMkhIWAicfzyBbYuRi4OIYGljBIb
        lk5m7GLkAErISBxfXwZRIyzx51oXVM1rRon9G5eygiSEBTwl3uw8AGazCVhJTGxfxQhiiwgk
        SDx9PZ8NxBYSsJP4uPABmM0LZM+aNQGsnkVAReJB7ywWEFtUIELizPsVLBA1ghInZz4BszkF
        7CXWPV3MDGIzC6hL/Jl3CcoWl7j1ZD4ThC0vsf3tHOYJjIKzkLTPQtIyC0nLLCQtCxhZVjGK
        pJYW56bnFhvpFSfmFpfmpesl5+duYgTGxLZjP7fsYOx6F3yIUYCDUYmHdwbTzxgh1sSy4src
        Q4wSHMxKIrxlF37ECPGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MF7zSuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwnrmppBqf8+dy9oS1tdymBT9tfPjuTXx0
        8YTrjFO+Iqkx9YqCr7Tlsnda75tcnBHVyS7UXzF3c8RctkkbQi+odty3a8xPu6rzWvBk9fpz
        huVubQ13maMOmZkvei34au4hoYsFYnnOelJr7mao204LPpO9VPBKBRtXWPfXfRNb+hM1qudX
        bNmuxFKckWioxVxUnAgAKyLG+J8CAAA=
X-CMS-MailID: 20190607123416eucas1p26b0c4a07ba6e0df82b1eda761a0f1826
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607123416eucas1p26b0c4a07ba6e0df82b1eda761a0f1826
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607123416eucas1p26b0c4a07ba6e0df82b1eda761a0f1826
References: <2a32648a-69c8-47a6-109a-6c2f764b2534@samsung.com>
        <CGME20190607123416eucas1p26b0c4a07ba6e0df82b1eda761a0f1826@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/22/19 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> Reorder code a bit and then remove no longer needed function
> prototypes.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
