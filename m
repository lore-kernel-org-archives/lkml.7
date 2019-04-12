Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3508C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC322077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfDLH1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:27:50 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:53796 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:27:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 0CF4B1806353E;
        Fri, 12 Apr 2019 09:27:48 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] MAINTAINERS: Update jffs2 entry
Date:   Fri, 12 Apr 2019 09:27:31 +0200
Message-Id: <20190412072731.23772-1-richard@nod.at>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the entry to represent the current state of jffs2.
I'll carry fixes via the UBIFS tree, David has the last word
on anything.
New features are not planned.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..089ab56eaecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8317,9 +8317,11 @@ F:	drivers/net/ethernet/jme.*
=20
 JOURNALLING FLASH FILE SYSTEM V2 (JFFS2)
 M:	David Woodhouse <dwmw2@infradead.org>
+M:	Richard Weinberger <richard@nod.at>
 L:	linux-mtd@lists.infradead.org
 W:	http://www.linux-mtd.infradead.org/doc/jffs2.html
-S:	Maintained
+T:	git git://git.infradead.org/ubifs-2.6.git
+S:	Odd Fixes
 F:	fs/jffs2/
 F:	include/uapi/linux/jffs2.h
=20
--=20
2.21.0

