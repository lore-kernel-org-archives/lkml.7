Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5422082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IoecKMVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDALum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:50:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39207 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDALum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:50:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401115040euoutp01178e91db0bf9df95be0946cca5c5597f~RV2WcpLBc0559805598euoutp01B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 11:50:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401115040euoutp01178e91db0bf9df95be0946cca5c5597f~RV2WcpLBc0559805598euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554119440;
        bh=O/ARt2njWv5FZoU4U4S9sgPKPGPwSLkJ9DziwCEXIzc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IoecKMVSGwN7YXnRgpqzkdC3aros47hF7cLTZQ0FD9bOrbyZ8s7zA4suodS3cweAS
         tgd8yFHHgZkrxq6aKGsyaqhC6sGka8eqRj72glnvDEZlJKZmICCXhmOvmfBp4rdd+w
         oBHWd4B8gGFFeJRQ52KCrLHiO997aKnub13JpQe0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401115039eucas1p12f391026969040dfac0a8545c12b303f~RV2V0fS5l1968419684eucas1p1p;
        Mon,  1 Apr 2019 11:50:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3A.C9.04377.F0BF1AC5; Mon,  1
        Apr 2019 12:50:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401115038eucas1p25b9dd080dec19a63c2a0b07cf6a24e5a~RV2VEqEBg2126221262eucas1p2k;
        Mon,  1 Apr 2019 11:50:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401115038eusmtrp28b4511733d0963501a16cc5cc65b8db9~RV2U2tTQ41256712567eusmtrp2d;
        Mon,  1 Apr 2019 11:50:38 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-40-5ca1fb0ff578
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F7.97.04140.E0BF1AC5; Mon,  1
        Apr 2019 12:50:38 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401115038eusmtip26cda70f12ef4223fba5bdc6ea5faff7a~RV2UcXQ031426214262eusmtip2R;
        Mon,  1 Apr 2019 11:50:38 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: savage: fix indentation issue
To:     Colin King <colin.king@canonical.com>
Cc:     Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c3e89ae6-6a47-2d64-42b1-37548df1f170@samsung.com>
Date:   Mon, 1 Apr 2019 13:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190212133444.7669-1-colin.king@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7r8vxfGGEy+I2Lxs/sLm8Xv1b1s
        Fle+vmez2HpL2uJE3wdWi8u75rA5sHnMauhl89g56y67x/3u40wenzfJBbBEcdmkpOZklqUW
        6dslcGXMO2FUMI254uqeeWwNjKeZuhg5OSQETCQm7uhi6WLk4hASWMEocW/fJDYI5wujxLcV
        C5kgnM+MEjOmPWKGafl59gU7RGI5o8Tf+beh+t8ySnw+uAWoioNDWMBB4uBTIxBTREBT4vy5
        IpASZpAVK5YtYQMZxCZgJTGxfRUjiM0rYCfxZ+1cdhCbRUBF4sDcO+wgvaICERL9Z9QhSgQl
        Ts58wgJicwrYShw+ugHMZhaQl9j+dg4zyHwJgX52iXv7b0D95iLR+fUx1NHCEq+Ob2GHsGUk
        /u+czwTRsA7ogY4XUN3bGSWWT/7HBlFlLXH4+EVWkCuYgT5Yv0sfIuwosbTxERtIWEKAT+LG
        W0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM2q6dK6HO8ZBoObWWdQKj4iwkr81C8s4shL0L
        GJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKaU0/+Of9nBuOtP0iFGAQ5GJR7eCqaF
        MUKsiWXFlbmHGCU4mJVEeM/0L4gR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1
        OzW1ILUIJsvEwSnVwMi0Quf8E68bN3ZkdkbYSSiuY2/7qOI2wf9E8Faz09Z8zKFnel4H7QqV
        S4y1Uoh+dmXmKg4Wqd86Ml4rrR7srmx3PrXmoJ/Xo7RpmXcXGUYpTt5Y1NyYPcP9ZBOHiOM5
        X5+NjzddWqDb1+vFseey2dc0/qYpt51NJ0ScO7Btbr/q+fQ2X2+ZX0osxRmJhlrMRcWJAE3h
        L5YlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7p8vxfGGBw/Lmvxs/sLm8Xv1b1s
        Fle+vmez2HpL2uJE3wdWi8u75rA5sHnMauhl89g56y67x/3u40wenzfJBbBE6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXMO2FUMI254uqeeWwN
        jKeZuhg5OSQETCR+nn3BDmILCSxllJi11qiLkQMoLiNxfH0ZRImwxJ9rXWxdjFxAJa8ZJe6+
        m8wOUiMs4CBx8ClYuYiApsT5c0UQJRMYJbq2HmUHcZgFVjBKXL5ygRFkEJuAlcTE9lVgNq+A
        ncSftXPB9rIIqEgcmHsHzBYViJC49bCDBaJGUOLkzCdgNqeArcThoxvAbGYBdYk/8y4xQ9jy
        EtvfzmGewCg4C0nLLCRls5CULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYKduO/dyy
        g7HrXfAhRgEORiUe3gqmhTFCrIllxZW5hxglOJiVRHjP9C+IEeJNSaysSi3Kjy8qzUktPsRo
        CvTERGYp0eR8YBTnlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg
        TFkmOPGZrqHUwsCoMvEuUZ15zWFuN8KSPpRt3bBrQ32E/dqX4fu4Dh7sWH4pgvnYFW2HZJEn
        W41O/2eK7bVfxeapFHO28mISZwDvojsBepP+/HVfZPPY48b1mMSdJ/ycHh/StNna/CUkYnr5
        dzYp9k2/lMROi3576cqu29awvvGMf+xTrW2KSizFGYmGWsxFxYkAJBROdqoCAAA=
X-CMS-MailID: 20190401115038eucas1p25b9dd080dec19a63c2a0b07cf6a24e5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212133451epcas2p23174f946cea09cabd29472e118fd4741
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212133451epcas2p23174f946cea09cabd29472e118fd4741
References: <CGME20190212133451epcas2p23174f946cea09cabd29472e118fd4741@epcas2p2.samsung.com>
        <20190212133444.7669-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/12/2019 02:34 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The indentation in the if statement is not indented correctly, fix
> this with extra level of indentation.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
