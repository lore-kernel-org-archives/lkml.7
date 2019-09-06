Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7428920842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfIFPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:13:34 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfIFPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:13:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1aQN-1i8BbC4BGV-0036MD; Fri, 06 Sep 2019 17:13:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/sa1100fb: Remove even more dead code
Date:   Fri,  6 Sep 2019 17:13:00 +0200
Message-Id: <20190906151307.1127187-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:I6rpL7gCiCsYUlp6FQGbVholK0223LnZWj/mxxwbsh2wD5HPO0Y
 MgVBcVUFLW1dBmdRHCg4XJVf13q17fakxkds8ehcBiRyzFyuzAUTxekyquLBSQNqi73GnuK
 sZ1vOwTnwrszmg9WFHWB62ED8ONFwcWv3gEjZGuyAsYaw9u5kWcwqrkY49JhR48ELym/ShX
 ICERUva5XHQeD9P6oD39g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KwBM+j6sNhA=:23ZTg/QTnEz4XrkmDljwtB
 MBdqWImY+6RZZCY1helSoVRJQZLQtlx5auA31z4ZCkerN2bGZpU1wJzHJyS3eYxPG3j8s1cQD
 fwfXNzSeCwMmx/WjnOUNHcoCdV4+0gdvurE0600hcdX36SAuuDPb39EvvtNkQn9nCUlv3cviV
 o1q20+yQjrQMmNgBeF/vknJhKykartW1vGh8Go+HJMheA49YbbEP5jT2f6IaGHKQ+7wMUB5HD
 EV3WDLIEnB7WWU1NqamJj2LKye4Q64TKReDxf4krxrJ2ACBRdI5TqFGwOhUv3opeDxrJBkun6
 eru8GRr9+SV18fjXTaYfQmDR0HFFn29T6v9fyddJGpyiu8ou2tYFrm7o5mTsjoLa8sV2Ga6eQ
 Eptf6a90avgIWO1+exad423axv8jx+SqSBZgcgsDogwLoyJ8a3N7xN1Z9SWHpQv8HclVxBcyJ
 5+8PcsWHxGtm+TL3aXhbz4yX471/4N7MC93cHi4RRdow7KtK/0ZdOWHJmD8Gwv56KzXcu1XB7
 tohcl6x0mR/GV+7S0mt/6CoKp/jIrBvH7AkMP5pDk7+1e3nLdFyGeHo0Sjk43MsrGjrV35k6W
 90mdy/DlvYvQ031hrGQPt1PDYmTEIDjRj10g+X3euhe7eJoZBgRU+nM1bMSUBZ3nALhfOB23K
 C+DXCT5KqzCzX1msEBVRROa50EsIZdnaGgn2PJVgF7kfbLNhpj9ZpkVoj89XFuguvAriVISPe
 0JB8/EcOeSJWhIzpcv3pe6G3s1sE3xH9t6aNDZWlG2LNjoLkvDpei0IwViHbimKzmXngWNfs8
 e6r4WtvvxVl0i9gPzIkF1IjltyWgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function lost its only call site as part of
earlier dead code removal, so remove it as well:

drivers/video/fbdev/sa1100fb.c:975:21: error: unused function 'sa1100fb_min_dma_period' [-Werror,-Wunused-function]

Fixes: 390e5de11284 ("fbdev/sa1100fb: Remove dead code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sa1100fb.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index ae2bcfee338a..81ad3aa1ca06 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -967,19 +967,6 @@ static void sa1100fb_task(struct work_struct *w)
 }
 
 #ifdef CONFIG_CPU_FREQ
-/*
- * Calculate the minimum DMA period over all displays that we own.
- * This, together with the SDRAM bandwidth defines the slowest CPU
- * frequency that can be selected.
- */
-static unsigned int sa1100fb_min_dma_period(struct sa1100fb_info *fbi)
-{
-	/*
-	 * FIXME: we need to verify _all_ consoles.
-	 */
-	return sa1100fb_display_dma_period(&fbi->fb.var);
-}
-
 /*
  * CPU clock speed change handler.  We need to adjust the LCD timing
  * parameters when the CPU clock is adjusted by the power management
-- 
2.20.0

