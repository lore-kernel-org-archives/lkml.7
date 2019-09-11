Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3212ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AF221D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="C08mn024"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfIKF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:58:52 -0400
Received: from gateway30.websitewelcome.com ([192.185.198.26]:38007 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbfIKF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:58:52 -0400
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 01:58:51 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id BE51D3E2F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 00:36:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7vJ2iQ11jiQer7vJ2igpY3; Wed, 11 Sep 2019 00:36:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QW8Cjbds0p1BI81ZMmirUfnVh51hLTx7oCbg0nDi9BU=; b=C08mn0247w1HM7YgYgPU9P42ln
        lgAo+3lCI6Jcv/4DS7qbd+aKdAq82wyLPlZ/bM9w2GFID6wTc/iu1lYnLE4AWLs0oO38KLd64JPtV
        NZllHTqjWdv6dLptdCtG8k3o2yhWvntuvqRz80lYJP9RbVTvlxwiaB0JFz3B1pIfz8d1b9BkG0u94
        5SV2efmrHsg5iehwFVmci5pIj3Hn5/oP2t4Gm5Y743UdGJzLCpOqS5cOiA8bJs/xFCFhfBqplKyyf
        hA4V1SQRY7k/tLmnYxHFLMBY+bEvmnvf3lrbFLkeF+36AX63BKUGaASrryeta3n7tHdO+v1icAhT0
        /v4pvLUw==;
Received: from [148.69.85.38] (port=52756 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i7vJ1-003qzX-C1; Wed, 11 Sep 2019 00:36:39 -0500
Date:   Wed, 11 Sep 2019 06:36:04 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Timur Tabi <timur@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] video: fbdev: fsl-diu-fb: mark expected switch fall-throughs
Message-ID: <20190911113604.GA31512@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 148.69.85.38
X-Source-L: No
X-Exim-ID: 1i7vJ1-003qzX-C1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [148.69.85.38]:52756
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warnings (Building: mpc512x_defconfig powerpc):

drivers/video/fbdev/fsl-diu-fb.c: In function ‘fsl_diu_ioctl’:
./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1287:3: note: in expansion of macro ‘dev_warn’
   dev_warn(info->dev,
   ^~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1290:2: note: here
  case MFB_SET_PIXFMT:
  ^~~~
In file included from ./include/linux/acpi.h:15:0,
                 from ./include/linux/i2c.h:13,
                 from ./include/uapi/linux/fb.h:6,
                 from ./include/linux/fb.h:6,
                 from drivers/video/fbdev/fsl-diu-fb.c:20:
./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1296:3: note: in expansion of macro ‘dev_warn’
   dev_warn(info->dev,
   ^~~~~~~~
drivers/video/fbdev/fsl-diu-fb.c:1299:2: note: here
  case MFB_GET_PIXFMT:
  ^~~~

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index d19f58263b4e..3e410b9eb272 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1287,6 +1287,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		dev_warn(info->dev,
 			 "MFB_SET_PIXFMT value of 0x%08x is deprecated.\n",
 			 MFB_SET_PIXFMT_OLD);
+		/* fall through */
 	case MFB_SET_PIXFMT:
 		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
 			return -EFAULT;
@@ -1296,6 +1297,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		dev_warn(info->dev,
 			 "MFB_GET_PIXFMT value of 0x%08x is deprecated.\n",
 			 MFB_GET_PIXFMT_OLD);
+		/* fall through */
 	case MFB_GET_PIXFMT:
 		pix_fmt = ad->pix_fmt;
 		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
-- 
2.23.0

