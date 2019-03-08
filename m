Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCHJaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:30:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:53361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCHJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:30:29 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuDoR-1goNVN0NUj-00uVob; Fri, 08 Mar 2019 10:30:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH v2] fs: 9p: Kconfig: pedantic cleanups
Date:   Fri,  8 Mar 2019 10:30:15 +0100
Message-Id: <1552037415-8454-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <116c5c69-b071-ad84-ce3b-1733e669b308@metux.net>
References: <116c5c69-b071-ad84-ce3b-1733e669b308@metux.net>
X-Provags-ID: V03:K1:5Dvl3oOaoykqbUaQhJ2lf4HOLwCXHX2UpBU2yg2IQyP3L1nRlwy
 /ljPUzchehWTTo8wSagx6C0nxkjDuICkkGVzD558Uqz1FtgLMKAp4jxWadIChaBlsk4AoOM
 wd+f/bI5sojYXKb1mfK64il2Txp1yHwVOxYGWhCvYch5j5nYBGAhJvyJxWyWIrSrwX1uria
 9xfeOhLyBUqz9o+nJ1y/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AAhs1dyDp/I=:miYE6RDgOIHkopSCDs/YcE
 kEShAYV49LXOfvhz0qCEiqIoVa8XqhYOUFXC/rgE7q4rur+rDsml/hdrGRJY6c9hoPHD4CRSW
 jOGbl2xnW/ooGw3m4ZHKeYl200MrYhAqGtAybeeXwjmpGHfTQEDU4QLsKoteFvU8eew+MRSwY
 KNY1HyMfu/13J5m99sfOWuPu97exxd36MU+E6nxs0TUFR1x7vmbIUZcI5xQLmeEX8PCgJ/mAI
 Ww+ZlEUWZ3GYkC4ZBXPfOFbjmEE1UyZTtpcAqIY0mTpn1HL2PwBJPKn2Lg48JhFcQxTKbQZZC
 ib6XhobRpOMUJBgzuE1UGAxoiPs8fJZfmfM5vecp5beGNzaO6NRATAGsDvwSy2z4anbj9zm4M
 9/vu8gGWHxIGZD7az7T3E9nf1l+j04CXlpJ3LO8kPBQLysQ5jlyetrU7uzZJj2mR391qEsYyB
 K4hX4XLIceTYnDcV3yMHQhKurta2Ov1bAc2fg1xvDK0bxwWrPJVNcR5psCJnlD1Rzvg/IzWsW
 gbXq0rU8gd5NqiVn5vZXXXVZAesca7nUsakJBwukQk1QUyshnn/dTV0QExogvzjOOHcNUO9EQ
 CluidFfSYmfpNBJR8VGNqOkxzDTBsT1y3Y1pFEwX6VXdxYC1wfhpVEWXmlTJy8eUXZk6PYV+K
 dCU3ZOgmpl2ySbgfR7536L6Cm9Ecw8nHBrYhH+5Qfug8a3Z6GQGLoc3EAmGWQOlxSm/r8dHeV
 OfkOKHG2XYWgCTXpxrFjx1aNclL/oh/ARuff5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take a damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/9p/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index 11045d8..e416057 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -31,13 +31,13 @@ endif
 
 
 config 9P_FS_SECURITY
-        bool "9P Security Labels"
-        depends on 9P_FS
-        help
-          Security labels support alternative access control models
-          implemented by security modules like SELinux.  This option
-          enables an extended attribute handler for file security
-          labels in the 9P filesystem.
-
-          If you are not using a security module that requires using
-          extended attributes for file security labels, say N.
+	bool "9P Security Labels"
+	depends on 9P_FS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the 9P filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
-- 
1.9.1

