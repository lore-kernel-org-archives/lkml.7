Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72908C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D320673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfE0MYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:24:10 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:47220 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE0MYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:24:10 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id HQQ82000B3XaVaC01QQ8ji; Mon, 27 May 2019 14:24:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEfg-0001U2-Bd; Mon, 27 May 2019 14:24:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEfg-0001YZ-A7; Mon, 27 May 2019 14:24:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] scif: Spelling s/EACCESS/EACCES/
Date:   Mon, 27 May 2019 14:24:07 +0200
Message-Id: <20190527122407.5939-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct spelling is EACCES:

include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/scif.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/scif.h b/include/linux/scif.h
index eeb250b73c4b9505..329e695b8fe5c0b2 100644
--- a/include/linux/scif.h
+++ b/include/linux/scif.h
@@ -657,7 +657,7 @@ int scif_unregister(scif_epd_t epd, off_t offset, size_t len);
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -733,7 +733,7 @@ int scif_readfrom(scif_epd_t epd, off_t loffset, size_t len, off_t
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -815,7 +815,7 @@ int scif_writeto(scif_epd_t epd, off_t loffset, size_t len, off_t
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
@@ -895,7 +895,7 @@ int scif_vreadfrom(scif_epd_t epd, void *addr, size_t len, off_t roffset,
  * the negative of one of the following errors is returned.
  *
  * Errors:
- * EACCESS - Attempt to write to a read-only range
+ * EACCES - Attempt to write to a read-only range
  * EBADF, ENOTTY - epd is not a valid endpoint descriptor
  * ECONNRESET - Connection reset by peer
  * EINVAL - rma_flags is invalid
-- 
2.17.1

