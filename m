Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCDTxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:53:02 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:38917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCDTxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:53:01 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5fQq-1gus1p3JvO-007AE3; Mon, 04 Mar 2019 20:52:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: mbx: fix a misspelled variable name
Date:   Mon,  4 Mar 2019 20:52:30 +0100
Message-Id: <20190304195249.971696-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j0OchP5xh01wVB9iofwyR9iMpO2auVbr9yCqhmDCRvC814ivy/o
 J9JKkA+/kFqOEfKEIpgQ3+4Axg2U9pwJGiOHcHx/H+vSsOuRuVK1ckDdJefANImUYebDv4t
 Vbxc5swlaCmpS4b6oynyKiF2F7Q2RJt4wAwzSxTEH/7DeK7EaxYpMHEpiAc12GL+KXB1g2E
 q/ORNEn3Qv5KLI/kujAFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dXzIlMlfeMI=:CNDfLql6sqgxGANVlQDGJd
 xpO/T0VrzewZgAhVaGE+q5ePo3zqkerRX0pYu7X9LbrsgpYY9/EYX65ItQGw1/7Y1ZSqGF0WX
 aTdkWVN0iRthQscEYbn740NI1j6Sq3ZhdL/4tDpuglGpnhkUfimZMu5jp0rDWsQ6Iejzac0ie
 5Yx5WYHoInEq9K+4ysv+Fq5nUgmMuYmN1ScA//2Ii1nbGFKlP7uyHf+4t+kC5od/gRgkiDeI/
 B73ZbY13xxIij37zyLMgkylXdDTWqQL9hEZ0fdUBWeCuYd/ec6kqlUH5AgnyCOfQom+YKRFxJ
 AVN4MhzSYLu9ef3BV9bkzpVt8geDoEVuv84OxVNz2cJ3h6Ar/KlBDpykWAnYRxeJPF6FJYm2w
 z/bwFtCznW9JSHzYaimg5b8T7atiIH3gFX9vy71QJWPQiqrwnR2xiVAibD728LpVux2fUtNAm
 ZrXg+aQEwKi67bw9tB4qH37zcIRG3d+++1mKnJ4bQro+UgSn8xkXS9RTAaWw6w/Ay9uXMBaku
 u54zp/lpSAlPR2XH+mlE5LCcXsUhFY9bYwCWilZC+L4+rvm1eX43Xl5NTxkZcMWIgxMjNGw7J
 9VVjihgZ+HwlBqdV8+8abD+oJiXUcU3H9vODq4b9g+e+tAcijpWmeUY7LIILu1siRtAsAYpOW
 I7fW2jvuAOj5PnWj66+c5/IbcD7QFT31kbP6qmo8tSd+RDWf6D0dACq3yhawopReONkOLzkpH
 D829qRRLU6204T12hVpgluFCAVTLhvMv+EH+3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent cleanup introduced a build failure when a variable
was spelled incorrectly:

In file included from drivers/video/fbdev/mbx/mbxfb.c:881:
drivers/video/fbdev/mbx/mbxdebugfs.c: In function 'mbxfb_debugfs_init':
drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: error: 'mbfi' undeclared (first use in this function); did you mean 'mfbi'?
  mbfi->debugfs_dir = dir;
  ^~~~
  mfbi
drivers/video/fbdev/mbx/mbxdebugfs.c:217:2: note: each undeclared identifier is reported only once for each function it appears in
drivers/video/fbdev/mbx/mbxdebugfs.c:213:21: error: unused variable 'mfbi' [-Werror=unused-variable]
  struct mbxfb_info *mfbi = fbi->par;
                     ^~~~

Fixes: 72aed9e31344 ("fbdev: mbx: fix up debugfs file creation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mbx/mbxdebugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mbx/mbxdebugfs.c b/drivers/video/fbdev/mbx/mbxdebugfs.c
index 52cfe0132b25..09af721638fb 100644
--- a/drivers/video/fbdev/mbx/mbxdebugfs.c
+++ b/drivers/video/fbdev/mbx/mbxdebugfs.c
@@ -214,7 +214,7 @@ static void mbxfb_debugfs_init(struct fb_info *fbi)
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mbxfb", NULL);
-	mbfi->debugfs_dir = dir;
+	mfbi->debugfs_dir = dir;
 
 	debugfs_create_file("sysconf", 0444, dir, fbi, &sysconf_fops);
 	debugfs_create_file("clock", 0444, dir, fbi, &clock_fops);
-- 
2.20.0

