Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAA5206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yj26GiEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfDALtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:49:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38630 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDALtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:49:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401114859euoutp011dd0390afaf0e06312b09efd33529d3c~RV04ngsmn0400004000euoutp01X
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 11:48:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401114859euoutp011dd0390afaf0e06312b09efd33529d3c~RV04ngsmn0400004000euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554119339;
        bh=nvTELAq9RUsQyYxN9ZlQrqxvYLQdXt1noep0alVVe0Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Yj26GiEytZjRoxcLPgTVvMXYARJDCeglgTp83FzIhjfGW+50EegmbGywclt+ahrv7
         KYtlgy4mUplLz2ILRdGGnwblJvqqZjraqvOvIVoTKHxwRKLJ7fNwnQaEiucSE+ZUUt
         dvye4sq0Dccuxprz7g8QukYxmXWFHVJwq7gPljfw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401114859eucas1p221ac4e813ce9d37cb6a2ef8ee53d191e~RV04PcchD0725707257eucas1p2N;
        Mon,  1 Apr 2019 11:48:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.9E.04298.AAAF1AC5; Mon,  1
        Apr 2019 12:48:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401114858eucas1p2a9dc45c289d5a2368499ce5dd75a6777~RV03gPZT_3156731567eucas1p2g;
        Mon,  1 Apr 2019 11:48:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401114858eusmtrp26bdd95d086bb38af0ae6a6fa94fcc309~RV03STPKD1145111451eusmtrp2d;
        Mon,  1 Apr 2019 11:48:58 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-bb-5ca1faaa4311
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.57.04140.AAAF1AC5; Mon,  1
        Apr 2019 12:48:58 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401114857eusmtip2c50c3d25bb4f4f1c9121cd8fda31cf93~RV029W-Vs1175211752eusmtip2U;
        Mon,  1 Apr 2019 11:48:57 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: vesafb: fix indentation issue
To:     Colin King <colin.king@canonical.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bc50205e-34f0-baee-a50f-7bb302327d21@samsung.com>
Date:   Mon, 1 Apr 2019 13:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190212132905.7307-1-colin.king@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned1VvxbGGNz4aG7xe3Uvm8WVr+/Z
        LLbekrY40feB1eLyrjlsDqwesxp62Tzudx9n8vi8SS6AOYrLJiU1J7MstUjfLoErY8qcCYwF
        J5krGu+2szQwfmDqYuTgkBAwkeg+VN/FyMUhJLCCUeJDwxVWCOcLo8Ten0+BHE4g5zOjxNn9
        piA2SMOK/kXsEEXLGSXae2cyQThvGSU+/m5gB6kSFnCQ2LOwgw1khYiApsT5c0UgNcwCjYwS
        tyZuYwSpYROwkpjYvgrM5hWwk5i5thusl0VARaL1yV2wXlGBCIn+M+oQJYISJ2c+YQEJcwrY
        Spx6UgcSZhaQl9j+dg4zxG3t7BLH2qohbBeJf783M0HYwhKvjm9hh7BlJP7vnA92soTAOkaJ
        vx0vmCGc7YwSyyf/Y4OospY4fPwiK8gyZqD71+/Shwg7SrycspsNEnJ8EjfeCkLcwCcxadt0
        Zogwr0RHmxBEtZrEhmUb2GDWdu1cCXWmh0TT371MExgVZyF5bBaSb2Yh7F3AyLyKUTy1tDg3
        PbXYMC+1XK84Mbe4NC9dLzk/dxMjMHWc/nf80w7Gr5eSDjEKcDAq8fAqMCyMEWJNLCuuzD3E
        KMHBrCTCe6Z/QYwQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYO
        TqkGRjb1GMZF9Z+X5i3ZVN6wSvbm5GrTRWKMXuLprKulvFe95Yz68Cfs54UjH1llNm13nC78
        a++kwyFXZh2L8/q1fkv13xlBQe/dFhn31O37o3P/jv9Pl0V7/phd3FfqNWuz1pJD2h0z1jLd
        6u/6J66/lakh8JxY2/ZUme5C1dUGJiG1innF7f/c5iixFGckGmoxFxUnAgCc16aDGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Pd1VvxbGGLQeYbH4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2B1aPWQ29bB73u48zeXzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMWXOBMaCk8wVjXfbWRoYPzB1MXJySAiY
        SKzoX8TexcjFISSwlFHiz/5vLF2MHEAJGYnj68sgaoQl/lzrYgOxhQReM0rMXV8KYgsLOEjs
        WdjBBlIuIqApcf5cEcSYCYwSL2ZMYgZxmAUaGSWu/5zKCNLAJmAlMbF9FZjNK2AnMXNtNzuI
        zSKgItH65C7YAlGBCIlbDztYIGoEJU7OfAJ2D6eArcSpJ3UgYWYBdYk/8y4xQ9jyEtvfzmGe
        wCg4C0nHLCRls5CULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYF9uO/dyyg7HrXfAh
        RgEORiUe3gqmhTFCrIllxZW5hxglOJiVRHjP9C+IEeJNSaysSi3Kjy8qzUktPsRoCvTDRGYp
        0eR8YMzmlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgDP+VKyn3
        rzfFg3eZ0nrBvOPFcXknm5O3rGMSqD458VeiT9SxEh21Iu+9U4u9ispO3V4vuuTUlg1pP2Ir
        fq37VX++8MDnLXy9cw7zZ5aUc1pseSW6vtJprc/eddunsXI/5do4LWGSZ4BOQfTCxSwcNuml
        ZVdL/1bockX5Ze/76HG/6Y4ml6eSEktxRqKhFnNRcSIApfmMUKECAAA=
X-CMS-MailID: 20190401114858eucas1p2a9dc45c289d5a2368499ce5dd75a6777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212132918epcas1p4211cd6eb2d090c8ccd2996ee0d13ca78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212132918epcas1p4211cd6eb2d090c8ccd2996ee0d13ca78
References: <CGME20190212132918epcas1p4211cd6eb2d090c8ccd2996ee0d13ca78@epcas1p4.samsung.com>
        <20190212132905.7307-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/12/2019 02:29 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of statements that are indented too deeply, fix
> this by removing tabs. Also add a space after a comma to clean up
> a cppcheck warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
