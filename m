Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C29C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F8C2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XDEIu4eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392056AbfHBTPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:15:46 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.43]:41088 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391984AbfHBTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:15:46 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C462F20427
        for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2019 14:15:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id td1khCzLt90ontd1kh3pj7; Fri, 02 Aug 2019 14:15:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oc4AOSiWl2lCiQnPdkuEFM9SDJW1XSDtDJ29fXEPlhM=; b=XDEIu4eu/j9WOOXkZ01OOBh6hM
        aTPH9Y69Pjb/5SEGg9xCm0PFJs1pnlEiy9UQOwgqbaLQbL3W14G83xmdN/GxM3enfu+/kPWguQ4V+
        JB2k6IyHnydpveoNrSXMzNYhboBwdflY3x3ZdVPvOUH3n0kA1enCOuTpPiuwugAG8imKN0k6VGrYP
        R7Ku0eMHPbQProwP7aLhOEetU4ucRuqc0OYF/Yg5ijLFu4OMMN2jfKPxWOYpKKblV5b4s3/WbM87J
        7z6+H6qUr5CnauHlYua5HqEqbWfD6BodqRsHzRk27/r+2jDXWnrbXHVrd1HI/BFVVOdGTIHSApkbv
        P9kSmEiw==;
Received: from [187.192.11.120] (port=33024 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1htd1j-002zj8-JL; Fri, 02 Aug 2019 14:15:43 -0500
Date:   Fri, 2 Aug 2019 14:15:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] video: fbdev: omapfb_main: Mark expected switch fall-throughs
Message-ID: <20190802191542.GA32751@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1htd1j-002zj8-JL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:33024
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: omap1_defconfig arm):

drivers/video/fbdev/omap/omapfb_main.c:449:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1549:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1547:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1545:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1543:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1540:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1538:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/video/fbdev/omap/omapfb_main.c:1535:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 90eca64e3144..702cca59bda1 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -447,6 +447,7 @@ static int set_color_mode(struct omapfb_plane_struct *plane,
 		return 0;
 	case 12:
 		var->bits_per_pixel = 16;
+		/* fall through */
 	case 16:
 		if (plane->fbdev->panel->bpp == 12)
 			plane->color_mode = OMAPFB_COLOR_RGB444;
@@ -1534,20 +1535,27 @@ static void omapfb_free_resources(struct omapfb_device *fbdev, int state)
 	case OMAPFB_ACTIVE:
 		for (i = 0; i < fbdev->mem_desc.region_cnt; i++)
 			unregister_framebuffer(fbdev->fb_info[i]);
+		/* fall through */
 	case 7:
 		omapfb_unregister_sysfs(fbdev);
+		/* fall through */
 	case 6:
 		if (fbdev->panel->disable)
 			fbdev->panel->disable(fbdev->panel);
+		/* fall through */
 	case 5:
 		omapfb_set_update_mode(fbdev, OMAPFB_UPDATE_DISABLED);
+		/* fall through */
 	case 4:
 		planes_cleanup(fbdev);
+		/* fall through */
 	case 3:
 		ctrl_cleanup(fbdev);
+		/* fall through */
 	case 2:
 		if (fbdev->panel->cleanup)
 			fbdev->panel->cleanup(fbdev->panel);
+		/* fall through */
 	case 1:
 		dev_set_drvdata(fbdev->dev, NULL);
 		kfree(fbdev);
-- 
2.22.0

