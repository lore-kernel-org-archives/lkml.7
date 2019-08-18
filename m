Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD087C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA40206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHRPGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:06:17 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:26458 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:06:16 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d11 with ME
        id qf6B2000T0Dzhgk03f6Ber; Sun, 18 Aug 2019 17:06:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Aug 2019 17:06:14 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8712: Improve naming of include hearder guards
Date:   Sun, 18 Aug 2019 17:06:09 +0200
Message-Id: <20190818150609.3376-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Choose a better name for the include hearder guard used in rtl871x_io.h.
'_IO_H_' is to generic and does not match the comment after the #endif.
Use '_RTL871X_IO_H_' instead.

Also make the comments in the #endif /* XXX */ match the name used in
#ifndef.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
__RTL871X_RF_H_ could have been turned into _RTL871X_RF_H_ (one leading
'_' removed) but there does not seem to be a clear logic in the way the
header guards are named in this directory. So leave it as-is in order to
limit the diff.
---
 drivers/staging/rtl8712/rtl871x_io.h | 7 +++----
 drivers/staging/rtl8712/rtl871x_rf.h | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index 28941423b7ed..c20dd5a6bbd1 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -11,8 +11,8 @@
  * Larry Finger <Larry.Finger@lwfinger.net>
  *
  ******************************************************************************/
-#ifndef _IO_H_
-#define _IO_H_
+#ifndef _RTL871X_IO_H_
+#define _RTL871X_IO_H_
 
 #include "osdep_service.h"
 #include "osdep_intf.h"
@@ -234,5 +234,4 @@ void r8712_write_port(struct _adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 uint r8712_alloc_io_queue(struct _adapter *adapter);
 void r8712_free_io_queue(struct _adapter *adapter);
 
-#endif	/*_RTL8711_IO_H_*/
-
+#endif	/*_RTL871X_IO_H_*/
diff --git a/drivers/staging/rtl8712/rtl871x_rf.h b/drivers/staging/rtl8712/rtl871x_rf.h
index cc54453cd424..7d98921a48fa 100644
--- a/drivers/staging/rtl8712/rtl871x_rf.h
+++ b/drivers/staging/rtl8712/rtl871x_rf.h
@@ -52,5 +52,4 @@ enum {
 	RTL8712_RFC_2T2R = 0x22
 };
 
-#endif /*_RTL8711_RF_H_*/
-
+#endif /*__RTL871X_RF_H_*/
-- 
2.20.1

