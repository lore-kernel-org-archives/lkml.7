Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DDB20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503330AbfJXPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:38:02 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:38806 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503151AbfJXPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:38:02 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id HTdz2100b5USYZQ01Te0tX; Thu, 24 Oct 2019 17:38:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNfBX-0007CB-T1; Thu, 24 Oct 2019 17:37:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNfBX-0008Id-QU; Thu, 24 Oct 2019 17:37:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
Date:   Thu, 24 Oct 2019 17:37:56 +0200
Message-Id: <20191024153756.31861-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-i3c mailing list is moderated for non-subscribers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f361fba6c4070ae..937017266a2edf08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7746,7 +7746,7 @@ F:	drivers/i2c/i2c-stub.c
 
 I3C SUBSYSTEM
 M:	Boris Brezillon <bbrezillon@kernel.org>
-L:	linux-i3c@lists.infradead.org
+L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
 C:	irc://chat.freenode.net/linux-i3c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 S:	Maintained
-- 
2.17.1

