Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfCFR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:56:27 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCFR40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:56:26 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mi2Bb-1gXDpf0oFd-00e3ag; Wed, 06 Mar 2019 18:56:14 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH] fs: 9p: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 18:56:12 +0100
Message-Id: <1551894972-5807-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:0oM5riiT0osFUYS0m/BLVUmNrei/ddKQWgSqS1xKCpWjxyIq/XX
 RyEbICcAa6nKECj6u7R0S+z+t2MHDP4BZ6l/STlXTMhetJftJxlB1mssNHbXRAsn2ix5/m7
 NTWZAbp/kWToxuhQ+pSc+KO4X+A/Maa28KGrLDD4kQkZP5xsDu6jVOLOUX6+KKawO8G5aDa
 CAT6/jjtKy6giiLdMtcWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qiaRqrXA1ZM=:1XTVZERo627+66H6Cwl8Sp
 jkBRddnlCJap+Gsl/CHDstDsFLsWyw0JBihbR0SlT5/rokt6LpdOm3gNPmpuv5ObI3tUWvV9l
 BVZfFTPfml2s/XHTVt6ZBmZJ4oxCxBICPudmJy6k/jACAGzjPtIxos84xq52ugrXBZIQI/omi
 lkiOun9+HzbOCxU8me/lWDaXMJreyUd99AwV7BrhYD666d3saluOWEKF1L8juqrdzpeCTkvGq
 fsMn+364kMyNwSk5wCKxRL4Cr9Y0r9HZXoSYIiNlWf8oCVE2le5IH7+lHLU8v43naw8kFGGCu
 2BEb4MB0jNA+QASbaUcxq/3ssyxDaTB1MjEu6IyTLT/avAbkh31VWKA2YHuKvpIAI1J2qSe54
 4L+TLFyhNVqZ0z76ftxkohpT/J/f4JvTp4gVX7c9JbuhBm8GLz7chckHyqwhF0trmrd1gsRPR
 IMjoWPELSOK4Rs3d2gQpUmOvYI+nsLm1Dpg9gV3yV1msitqJcbk0FkBK2J2K1ZmF4QKi1j1Si
 Bv/kjIMwrLZ0ajpxhlT5HDsMCeyP2xrhUWDgaCK2zeWRVfpX8WYco6nkbdiizy06kvNkvK7/y
 yNjLV1gs8tB1uC4qPiPt6GM/aFvrD642Bg4xhqI+Sjtuu0yP7IACWO8VNrsJU4swidNW91Gou
 rM7VsIQnYnvtHUjrutVFSg/RZUtXxA6m0pdK/9BQnRCAnZs4j3nHceVhEjYWB8Da4XfGXvVls
 ZEe01A5xSExqLPy39tFhlDu5/rcxN04jdQPAnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

