Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABAFC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF0220848
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pDDK85MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgACMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:40:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33767 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgACMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:40:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103124028euoutp02501d72f7d8b57e1cf0f6c221c11767ac~mYN6gsKL90382603826euoutp02-
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103124028euoutp02501d72f7d8b57e1cf0f6c221c11767ac~mYN6gsKL90382603826euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578055228;
        bh=JffEi5qFJrJ/USIj6NvL05rSOuUg7Mn159feIZCBDbQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pDDK85MHlsSnIBhwd08LA7MSuLbqMK0c3TO7qArQwGLGj9GbCbYWEWgwQGkXokchv
         9npMi1LRkbKjusyHhpuY572USfzRzzgWRawBy8NcS9zJRAyWDVaR5g047pUwgOM0VQ
         XbYK9z0GmrbrsBAlOKLd57fDfqbmUppTaMpMRsaw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103124028eucas1p11badec81973bbc58870fb933a5c7da8c~mYN6TVBZu2237022370eucas1p1b;
        Fri,  3 Jan 2020 12:40:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.FB.61286.C363F0E5; Fri,  3
        Jan 2020 12:40:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103124028eucas1p2a6b14c926bf0ea06e4e7b59cac2ed4d4~mYN59f1YZ0949509495eucas1p2U;
        Fri,  3 Jan 2020 12:40:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103124028eusmtrp1c38797ad7267552f42bf07c2604e6408~mYN586sB10989709897eusmtrp1u;
        Fri,  3 Jan 2020 12:40:28 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5a-5e0f363c8bab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.95.07950.C363F0E5; Fri,  3
        Jan 2020 12:40:28 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103124027eusmtip109bb11f9b69f0d3c27b9ecda4c5fa475~mYN5o_mAX1531215312eusmtip1Q;
        Fri,  3 Jan 2020 12:40:27 +0000 (GMT)
Subject: Re: [PATCH] omapfb/dss: remove unneeded conversions to bool
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5251890d-e12e-c78c-9790-fe8764501744@samsung.com>
Date:   Fri, 3 Jan 2020 13:40:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016180424.23907-1-afd@ti.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87o2ZvxxBvufilu8PzWR3eJE3wdW
        i8u75rBZvN9/mcmBxWPTqk42j+M3tjN5fN4kF8AcxWWTkpqTWZZapG+XwJWxZ+JPtoJ73BUX
        5yxlbmC8ydnFyMkhIWAiMffKFrYuRi4OIYEVjBKX9j5khXC+MEpM27mdEcL5zCixdvZ+NpiW
        Jz+2MUEkljNKfDl6GKr/LaPE7LOb2UGqhAVcJM6dPMcEYosIKEk0nOxmBbGZBRIlbqx8DTaJ
        TcBKYmL7KkYQm1fATuLFl//MIDaLgIpE0+GdLCC2qECExKcHh1khagQlTs58AhbnFDCQ6P76
        jxFiprjErSfzmSBseYntb+cwgxwkIdDPLnF29052iLNdJJaufMIIYQtLvDq+BSouI3F6cg8L
        RMM6Rom/HS+gurczSiyf/A/qaWuJO+d+AdkcQCs0Jdbv0ocIO0rMPjEPLCwhwCdx460gxBF8
        EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpXMExiVZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz
        01OLDfNSy/WKE3OLS/PS9ZLzczcxApPK6X/HP+1g/Hop6RCjAAejEg9vgjJ/nBBrYllxZe4h
        RgkOZiUR3vJA3jgh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4
        OKUaGNn/RmwNSd+Utd5KctHhw3zSG18zKsowss2bvTlqysHjkfx2WzNjvCVZRV7M/Ln+89xt
        G+YWLly0qmQzf7hyWHVyv29KiO2TRzPvXw/S42+9wqAf3DyZY6Fi+NdIlR8VB553sd/wnZIx
        UWB71LyWh4+9+Ju/WG+YH3vkIv+H/R/l1HjvBM5YY6PEUpyRaKjFXFScCAAfGTPMJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7o2ZvxxBguWsFi8PzWR3eJE3wdW
        i8u75rBZvN9/mcmBxWPTqk42j+M3tjN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexZ+JPtoJ73BUX5yxlbmC8ydnFyMkhIWAi8eTH
        NqYuRi4OIYGljBITLl1k7WLkAErISBxfXwZRIyzx51oXG4gtJPCaUeL+6woQW1jAReLcyXNM
        ILaIgJJEw8luVhCbWSBR4nNbHyPEzGZGiVUzN4M1swlYSUxsX8UIYvMK2Em8+PKfGcRmEVCR
        aDq8kwXEFhWIkDi8YxZUjaDEyZlPwOKcAgYS3V//MUIsUJf4M+8SM4QtLnHryXwmCFteYvvb
        OcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMoG3Hfm7Z
        wdj1LvgQowAHoxIPL4cif5wQa2JZcWXuIUYJDmYlEd7yQN44Id6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4HRndeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
        NUaFxsrwpOSfcfenvPmWvFBzltyvGrPXWovm3DBOsf+05ZHKJK/Lb27occ5i/1Xq1GlQ+KR7
        isgWrufcBg38yzKn+7x/X62TGduedYRL4cT899szFGKuCnvtXa522mvL2Xd1V7cy1BVWCW/k
        DWAsWC3MXTVvYYvobr6Coy/2bnRSFZ+WvvieEktxRqKhFnNRcSIALgskfbYCAAA=
X-CMS-MailID: 20200103124028eucas1p2a6b14c926bf0ea06e4e7b59cac2ed4d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191016180541epcas5p4d85d004250e99c95c876da3c03d4d46e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191016180541epcas5p4d85d004250e99c95c876da3c03d4d46e
References: <CGME20191016180541epcas5p4d85d004250e99c95c876da3c03d4d46e@epcas5p4.samsung.com>
        <20191016180424.23907-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/19 8:04 PM, Andrew F. Davis wrote:
> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> index 376ee5bc3ddc..ce37da85cc45 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> @@ -1635,7 +1635,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
>  {
>  	int scale_x = out_width != orig_width;
>  	int scale_y = out_height != orig_height;
> -	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
> +	bool chroma_upscale = plane != OMAP_DSS_WB;
>  
>  	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
>  		return;
> @@ -3100,9 +3100,9 @@ static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
>  		unsigned long pclk)
>  {
>  	if (dss_mgr_is_lcd(channel))
> -		return pclk <= dispc.feat->max_lcd_pclk ? true : false;
> +		return pclk <= dispc.feat->max_lcd_pclk;
>  	else
> -		return pclk <= dispc.feat->max_tv_pclk ? true : false;
> +		return pclk <= dispc.feat->max_tv_pclk;
>  }
>  
>  bool dispc_mgr_timings_ok(enum omap_channel channel,
