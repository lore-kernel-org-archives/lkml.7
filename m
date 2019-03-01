Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F242C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5520675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OdNmHymi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfCAOuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:50:14 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57917 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbfCAOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:50:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190301145011euoutp013e30735bc1636ebb41821d0dc58a3708~H3TPuHQse2967129671euoutp010
        for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2019 14:50:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190301145011euoutp013e30735bc1636ebb41821d0dc58a3708~H3TPuHQse2967129671euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551451811;
        bh=8b5/0gDb7ME8Bvsrk2KZd3L0YwcNKXOKJ08/ArFJ0d0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OdNmHymiaKMZDZ22rkXzMu2WXyVxGjm+BbRSb5EpPHJt6W/ye12P18g5rlr2aIFdn
         pYDyy7MTuJImTvhnLB9T8KlpPmO6Tzb7wpW9RHuHwVuvuNiV9+yBkwKuL/rup58Aoh
         u5fBZDjBudjL5GgkV5c6KIdopPQ/4wdFg5FhwI9w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190301145011eucas1p26c54c9a24e1c3019f989897c5fb9a5f1~H3TPPfh450181001810eucas1p29;
        Fri,  1 Mar 2019 14:50:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8D.FF.04294.2A6497C5; Fri,  1
        Mar 2019 14:50:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190301145010eucas1p1839d533def9e94cb7882fa6567ba5f86~H3TOgpk240841308413eucas1p19;
        Fri,  1 Mar 2019 14:50:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190301145010eusmtrp161aaa88f1994c4a32fca97413becdfcd~H3TOSOqET2653126531eusmtrp1h;
        Fri,  1 Mar 2019 14:50:10 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-10-5c7946a2d509
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.CE.04128.2A6497C5; Fri,  1
        Mar 2019 14:50:10 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190301145009eusmtip17056ec7a86c90151a2969b5594021daf~H3TN8iibV2919429194eusmtip1Y;
        Fri,  1 Mar 2019 14:50:09 +0000 (GMT)
Subject: Re: [PATCH -next] fbdev: omap2: omapfb: trivial code cleanup
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     trivial@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f14aa8d6-7cd7-4295-11d9-ee0aefdaa7c0@samsung.com>
Date:   Fri, 1 Mar 2019 15:50:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190301015342.28888-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7qL3CpjDL79sLC48vU9m0Xz4vVs
        Fif6PrBaXN41h81i9pJ+Fov3+y8zWdz5+pzFgd2j5chbVo9NqzrZPPbPXcPucb/7OJPH501y
        AaxRXDYpqTmZZalF+nYJXBnrv1gVPOCqeP7rJmsD41eOLkZODgkBE4nu3S+Zuxi5OIQEVjBK
        XFw0gRHC+cIo8etnE1TmM6NE4/If7DAtc97+YIFILGeUmPLkJSNIQkjgPaPEmjPJILawgKvE
        utmTwRpEBNQlXmzdB2YzC6xjlFj5Jg7EZhOwkpjYvgqol4ODV8BO4mVjHIjJIqAicXyaFogp
        KhAh0X9GHaSYV0BQ4uTMJywgNqeAtcTjZ59YIAYaSBxZNIcVwpaX2P52DtjJEgLL2CW+bZoC
        dbKLxPIv3xkhbGGJV8e3QMVlJE5P7mGBaJjOKPHm11IoZz3IK8eYIKqsJQ4fv8gKYTtKbPiy
        G+xmCQE+iRtvBSE280lM2jadGSLMK9HRJgRRrSaxYdkGNphdXTtXMkPYHhJfd+1kncCoOAvJ
        b7OQ/DMLyT8LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaa0/+Of9nBuOtP0iFG
        AQ5GJR7eCq3KGCHWxLLiytxDjBIczEoivDMsgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxke
        RAsJpCeWpGanphakFsFkmTg4pRoYOxrP2ZVdWProcXB9UWN9iQAXt+9C7VWL2bwOMMsUHee8
        ujtsWVbYks9TNz881PXOdDNLSr1T48/tFd9X3RRfEHAnM41x2vsLUgv/p+++1VrNwfFowaO0
        bUy3n1u5SJlNkFQ88GHzwrXXvJcufHn/rWGRrF/Rj4yZNqsqntr9PLN1wwHNSP9Je5RYijMS
        DbWYi4oTAVEiXB8wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7qL3CpjDI43cVtc+fqezaJ58Xo2
        ixN9H1gtLu+aw2Yxe0k/i8X7/ZeZLO58fc7iwO7RcuQtq8emVZ1sHvvnrmH3uN99nMnj8ya5
        ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYz1
        X6wKHnBVPP91k7WB8StHFyMnh4SAicSctz9Yuhi5OIQEljJK9Fx6xdTFyAGUkJE4vr4MokZY
        4s+1LjaImreMEg1z/zODJIQFXCXWzZ7MDmKLCKhLvNi6jx2iqI9RovHEM7AOZoF1jBLLp7cw
        glSxCVhJTGxfxQiygVfATuJlYxyIySKgInF8mhZIhahAhMSthx0sIDavgKDEyZlPwGxOAWuJ
        x88+gdnMAnoSO67/YoWw5SW2v53DPIFRcBaSlllIymYhKVvAyLyKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMIK2Hfu5ZQdj17vgQ4wCHIxKPLwVWpUxQqyJZcWVuYcYJTiYlUR4Z1gChXhT
        EiurUovy44tKc1KLDzGaAv0wkVlKNDkfGN15JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNL
        UrNTUwtSi2D6mDg4pRoYbwSvPPt+PsNepazAKOMLV405+eL3vChunK/yqKJ43cE3y4QkzLRX
        h8wOW72dpSeD81vjln/nXuby7rFj3LbjbNrcBxNu2F4926F1bHJ27ExGxWMPEyd/7L8xwzo1
        /qLEy/ZdrmY/Jq+3tlMO3jAtRvz1yXo96flm0d93Vfo/WWC2eeL2ko4yIyWW4oxEQy3mouJE
        AB9Rd0i2AgAA
X-CMS-MailID: 20190301145010eucas1p1839d533def9e94cb7882fa6567ba5f86
X-Msg-Generator: CA
X-RootMTR: 20190301015537epcas4p242dee277b9b0b4953775bb948985775c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190301015537epcas4p242dee277b9b0b4953775bb948985775c
References: <CGME20190301015537epcas4p242dee277b9b0b4953775bb948985775c@epcas4p2.samsung.com>
        <20190301015342.28888-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 03/01/2019 02:53 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> After commit 60d2fa0dad06 ("fbdev: omap2: no need to check
> return value of debugfs_create functions"), there are corner
> code need to be cleaned.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks but I've already applied earlier patch from Anders Roxell:

https://marc.info/?l=linux-fbdev&m=155004766902831&w=2

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
> index 7e6a3eb..b5956a1 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
> @@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
>  }
>  void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
>  {
> -	return 0;
>  }
>  #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
>  
> @@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
>  
>  static int __init omap_dss_probe(struct platform_device *pdev)
>  {
> -	int r;
> -
>  	core.pdev = pdev;
>  
>  	dss_features_init(omapdss_get_version());

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
