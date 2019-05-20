Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52917206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LzcDMs6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfETIFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40728 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190520080521euoutp010896e16f4f345ac5a18967c069c747d7~gVYnVPm7-2042520425euoutp01i
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:05:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190520080521euoutp010896e16f4f345ac5a18967c069c747d7~gVYnVPm7-2042520425euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558339521;
        bh=kbyN3TjyDx8oqa74b4izYV9eIuvgOoK3g1XdrHecRGY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LzcDMs6EFgsJFBQrpFGrsqvuvQV9EGN9FB+89CGeQiwRNuM980dA39XU1H+SbQDst
         QG17gEesI5PDlt68tzkQD8+fcCIiU3JapL8lDsLt7V7PJeU6gpSafKT6QbcK4yGVRu
         iMpCHqzuV5nSOV7fj9NQMmHfLbONiviRN5qkkj68=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190520080520eucas1p11d8bfb238865f0d54f1d8911fb03a991~gVYmz07Oq2609826098eucas1p1M;
        Mon, 20 May 2019 08:05:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.0F.04325.0CF52EC5; Mon, 20
        May 2019 09:05:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190520080520eucas1p10a60f58f21cf785ffe449c213daecdc1~gVYmCBIlQ2358323583eucas1p1Z;
        Mon, 20 May 2019 08:05:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190520080520eusmtrp2f5847286dfd832358321f43a292a3299~gVYmBcNjX0781107811eusmtrp2r;
        Mon, 20 May 2019 08:05:20 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-e5-5ce25fc08206
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.15.04140.0CF52EC5; Mon, 20
        May 2019 09:05:20 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190520080519eusmtip238cfac07af457a6f10ed1f969256f4bb~gVYlq8eCV1233512335eusmtip2W;
        Mon, 20 May 2019 08:05:19 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        architt@codeaurora.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc:     jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <4e46d26e-675c-23db-5b5d-5030f64cda56@samsung.com>
Date:   Mon, 20 May 2019 10:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5cdd8109.1c69fb81.6e003.b84b@mx.google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87oH4h/FGOy9pW7Re+4kk0VTx1tW
        iytf37NZXLvawGzROXEJu8XlXXPYLC59PMTkwO5xua+XyWPnrLvsHrM7ZrJ6bP/2gNXjfvdx
        Jo/Pm+QC2KK4bFJSczLLUov07RK4Mo53P2cu+M9ecWjxRrYGxlNsXYycHBICJhLbu5exdjFy
        cQgJrGCUeD+tgQnC+cIo8e3ya3YI5zOjxOzJb9lhWrp/NUNVLWeUWN79mRHCecsocWHmfVaQ
        KmEBa4m2zuVg7SICDYwSt7bfB9vILBApMffOAkYQm01AU+Lv5ptgcV4BO4meTfPAVrAIqErM
        vj8TzBYViJC4f2wDK0SNoMTJmU9YQGxOAUuJZT0bGCFmyktsfzuHGcIWl7j1ZD7YeRIC29gl
        2k9tY4K420Vi1foHrBC2sMSr41ug/pGR+L9zPlRNvcT9FS3MEM0djBJbN+xkhkhYSxw+fhGo
        mQNog6bE+l36EGFHiQOnnzGBhCUE+CRuvBWEuIFPYtK26cwQYV6JjjYhiGpFiftnt0INFJdY
        euEr2wRGpVlIPpuF5JtZSL6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMCE
        dPrf8a87GPf9STrEKMDBqMTD6zH9YYwQa2JZcWXuIUYJDmYlEV5j9fsxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhg17k2Uv+2Y84Mr+52r4Hd+uUON
        QesO/+gJ4rOydHExDZb4yqXhxy1tr6NxtVJrXc+0FOusi2wPcsL35ipt1fm9IDpwp8PaOyYz
        v1uf3HJP2XvmLRXNKcEn1GXP/FWMqJJMLkoXYHU74uzuw/bx8xXf6qTktL0Sc7dxTz18VOX3
        FbkNVd4/GJVYijMSDbWYi4oTAVyVth5EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oH4h/FGDx+yGrRe+4kk0VTx1tW
        iytf37NZXLvawGzROXEJu8XlXXPYLC59PMTkwO5xua+XyWPnrLvsHrM7ZrJ6bP/2gNXjfvdx
        Jo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov0
        7RL0Mo53P2cu+M9ecWjxRrYGxlNsXYycHBICJhLdv5qZuhi5OIQEljJKfJp3lhEiIS6xe/5b
        ZghbWOLPtS6wBiGB14wSf5fGgNjCAtYSbZ3L2UGaRQQaGCUabk8Bcjg4mAUiJd6fYYeo72GU
        OHQvDMRmE9CU+Lv5JtgcXgE7iZ5N88BqWARUJWbfnwlmiwpESJx5v4IFokZQ4uTMJ2A2p4Cl
        xLKeDWC3MQuoS/yZd4kZwpaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIERt+2Yz+37GDsehd8iFGAg1GJh/fDlIcxQqyJZcWVuYcY
        JTiYlUR4jdXvxwjxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAx5JXEG5oamltYGpobmxub
        WSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYNS82SXQm/AhtK131cZ7Wqkbrj+Xf+5XN6Gu
        WPUAX+a2X4uanoY7ngvrNPI8LmMMTDSvov7nRdwPvJ59SWzPPYveSerRueZOByZK98fGuem3
        bZmpsW/Jz9pbG2YbKOwI+590VCf2SfORO3Yf1ouYe+2TlnY4eeqQ28r5eQc2GZ79+fWlb+XN
        RUosxRmJhlrMRcWJAJkXpBLUAgAA
X-CMS-MailID: 20190520080520eucas1p10a60f58f21cf785ffe449c213daecdc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190516152606epcas1p153959c396cb312da9ecc0e164bfcc8d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190516152606epcas1p153959c396cb312da9ecc0e164bfcc8d3
References: <CGME20190516152606epcas1p153959c396cb312da9ecc0e164bfcc8d3@epcas1p1.samsung.com>
        <5cdd8109.1c69fb81.6e003.b84b@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2019 17:25, Sabyasachi Gupta wrote:
> Remove duplicate header which is included twice
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>


Queued to drm-misc-next.


Regards

Andrzej


> ---
> v2: rebased the code against drm -next and arranged the headers alphabetically
>
>  drivers/gpu/drm/bridge/panel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 38eeaf8..000ba7c 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -9,13 +9,12 @@
>   */
>  
>  #include <drm/drmP.h>
> -#include <drm/drm_panel.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_probe_helper.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
>  
>  struct panel_bridge {
>  	struct drm_bridge bridge;


