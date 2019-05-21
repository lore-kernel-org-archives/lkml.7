Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641ECC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FEA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lCPI3x/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfEUOCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:02:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47889 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfEUOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:02:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521140245euoutp0157ce15e951dfc730e6a53b32945ee986~gt58-K3u10193901939euoutp01v
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 14:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521140245euoutp0157ce15e951dfc730e6a53b32945ee986~gt58-K3u10193901939euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558447365;
        bh=l6M7Kgw/u9cdmIuexWPozWhYDjVdWoz4ybdUdatYm6Q=;
        h=To:Cc:From:Subject:Date:References:From;
        b=lCPI3x/5T0dqjhvCYEX3/aAY7ITjDsXa9B1P4m3wP5xnAdY0LjYN+0UbOk2gH5nVR
         m12reggub/bONUUUXMm3efvFZ2pNtObqfHWGIe/7pVfXrWVA3KZaxw6N65HWm3XLp7
         Byw/z3BOkqegk5EhW4C3/Yuc2Q/rAS5NVUik1jaE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521140245eucas1p21ffe2befeaa9f9bbeb0f706b7c6364d6~gt58pJPn41436614366eucas1p2c;
        Tue, 21 May 2019 14:02:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 07.A2.04298.40504EC5; Tue, 21
        May 2019 15:02:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c~gt57qG4jp0623806238eucas1p2d;
        Tue, 21 May 2019 14:02:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190521140243eusmtrp2a771ae2ddba704f9e7a497d19c48dd58~gt57ajZT00523705237eusmtrp2B;
        Tue, 21 May 2019 14:02:43 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-41-5ce405047e28
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.34.04146.30504EC5; Tue, 21
        May 2019 15:02:43 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190521140243eusmtip298bff93f3a48fc44783a5af991707dd6~gt57KOC0h0610306103eusmtip21;
        Tue, 21 May 2019 14:02:43 +0000 (GMT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: atafb: remove superfluous function prototypes
Message-ID: <50411fd1-9da0-aab6-709e-749d5e0ce509@samsung.com>
Date:   Tue, 21 May 2019 16:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzneV1W1icxBt8tLK58fc9m8ezWXiaL
        E30fWC0u75rD5sDicehwB6PH/e7jTB6fN8kFMEdx2aSk5mSWpRbp2yVwZXTcryw4xl1xv/MB
        WwPjIc4uRk4OCQETiSlHJjB2MXJxCAmsYJRY8WsvM4TzhVFiQscydgjnM6PE093vWWBa/v14
        wgaRWM4o0fx6PhOE85ZR4tPnv0AtHBwiAroSc34ygTQwCyRInF50D6yZTcBKYmL7KkYQW1jA
        R+LA+UawGl4BO4k9/xtYQWwWAVWJ3eumg9miAhES949tYIWoEZQ4OfMJC8RMcYlbT+ZDzZeX
        2P52DtjZEgKf2STuPPvCBnGpi8TXU7tYIWxhiVfHt7BD2DIS/3dCHC0hsI5R4m/HC6ju7YwS
        yyf/g+q2ljh8/CIryDfMApoS63fpQ4QdJZqezmYDCUsI8EnceCsIcQSfxKRt05khwrwSHW1C
        ENVqEhuWbWCDWdu1cyVUiYfEm2XCExgVZyH5bBaSz2Yh+WwWwgkLGFlWMYqnlhbnpqcWG+al
        lusVJ+YWl+al6yXn525iBCaT0/+Of9rB+PVS0iFGAQ5GJR5ei4ePY4RYE8uKK3MPMUpwMCuJ
        8J4+9ShGiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA6Oq
        BiPn1AmartevvuuT76q7IpIYtvxb8u+YL48emB1pkvrByeR+c7FefLqQrt+JwPiYULPYiFsX
        A+qEzm+xj7nZuOO1wk2e5lP7As4zzmL9eapW4s7vK3rrWBvfrRB+daCKb76Wnd+pE7Ne5AWx
        S33pZH+9QjE6eHrM5H7dinV/Sqt2FygUuiixFGckGmoxFxUnAgCanzzxIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4PV1m1icxBpe/mVtc+fqezeLZrb1M
        Fif6PrBaXN41h82BxePQ4Q5Gj/vdx5k8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvouF9ZcIy74n7nA7YGxkOcXYycHBICJhL/fjxh
        62Lk4hASWMoo0bjqG3sXIwdQQkbi+PoyiBphiT/XuqBqXjNKLO2+xwRSIyKgKzHnJ5jJLJAg
        8WxeCkg5m4CVxMT2VYwgtrCAj8SB841MIDavgJ3Env8NrCA2i4CqxO5108FsUYEIiTPvV7BA
        1AhKnJz5BMxmFlCX+DPvEjOELS5x68l8JghbXmL72znMExgFZiFpmYWkZRaSlllIWhYwsqxi
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjIVtx35u3sF4aWPwIUYBDkYlHt4H9x7HCLEmlhVX
        5h5ilOBgVhLhPX3qUYwQb0piZVVqUX58UWlOavEhRlOghyYyS4km5wPjNK8k3tDU0NzC0tDc
        2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PwaX6NJ6WTbl0zPtF7fkpj/vyFGcU/
        BOSq0myvPPWY6eD77OvF/uqLW9jrfv82WspftW1a1v1z068piL3WXnMs4FdQvNmfM67KtZf/
        fl4fvydoyeSfa9983LhkrbSiosR0jZz/Kmx/rVeW7FabNyHevu2PY+DTo1PXbJjeon3j3Se7
        HWrPtu/IUWIpzkg01GIuKk4EAL1xOhebAgAA
X-CMS-MailID: 20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c
References: <CGME20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for them.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/atafb.c |   21 ---------------------
 1 file changed, 21 deletions(-)

Index: b/drivers/video/fbdev/atafb.c
===================================================================
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -77,29 +77,8 @@
 #define SWITCH_SND7 0x80
 #define SWITCH_NONE 0x00
 
-
 #define up(x, r) (((x) + (r) - 1) & ~((r)-1))
 
-	/*
-	 * Interface to the world
-	 */
-
-static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
-static int atafb_set_par(struct fb_info *info);
-static int atafb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-			   unsigned int blue, unsigned int transp,
-			   struct fb_info *info);
-static int atafb_blank(int blank, struct fb_info *info);
-static int atafb_pan_display(struct fb_var_screeninfo *var,
-			     struct fb_info *info);
-static void atafb_fillrect(struct fb_info *info,
-			   const struct fb_fillrect *rect);
-static void atafb_copyarea(struct fb_info *info,
-			   const struct fb_copyarea *region);
-static void atafb_imageblit(struct fb_info *info, const struct fb_image *image);
-static int atafb_ioctl(struct fb_info *info, unsigned int cmd,
-		       unsigned long arg);
-
 
 static int default_par;		/* default resolution (0=none) */
 
