Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D21CC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ADD20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfFGLfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:35:15 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:33620 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:35:15 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id MnbC2000V3XaVaC01nbC0d; Fri, 07 Jun 2019 13:35:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD9M-0004Fw-SF; Fri, 07 Jun 2019 13:35:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD9M-0003vC-Py; Fri, 07 Jun 2019 13:35:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mm/vmalloc: Spelling s/configuraion/configuration/
Date:   Fri,  7 Jun 2019 13:35:09 +0200
Message-Id: <20190607113509.15032-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7350a124524bb4b2..08b8b5a117576561 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2783,7 +2783,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
  * Note: In usual ops, vread() is never necessary because the caller
  * should know vmalloc() area is valid and can use memcpy().
  * This is for routines which have to access vmalloc area without
- * any informaion, as /dev/kmem.
+ * any information, as /dev/kmem.
  *
  * Return: number of bytes for which addr and buf should be increased
  * (same number as @count) or %0 if [addr...addr+count) doesn't
@@ -2862,7 +2862,7 @@ long vread(char *buf, char *addr, unsigned long count)
  * Note: In usual ops, vwrite() is never necessary because the caller
  * should know vmalloc() area is valid and can use memcpy().
  * This is for routines which have to access vmalloc area without
- * any informaion, as /dev/kmem.
+ * any information, as /dev/kmem.
  *
  * Return: number of bytes for which addr and buf should be
  * increased (same number as @count) or %0 if [addr...addr+count)
-- 
2.17.1

