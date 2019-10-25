Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E95CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275C521E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439219AbfJYLNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:13:51 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50460 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408721AbfJYLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:13:47 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HnDl2100x5USYZQ01nDl2r; Fri, 25 Oct 2019 13:13:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-RW; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvn0-0006CJ-7Z; Fri, 25 Oct 2019 11:21:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] scripts/dtc: dtx_diff - make help text formatting consistent
Date:   Fri, 25 Oct 2019 11:21:45 +0200
Message-Id: <20191025092145.23782-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the help texts use capitalization, except the one for the -T
option.  Drop the capitalization for consistency.
Split the single long line that doesn't fit in 80 characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
---
v2:
  - Add Reviewed-by.
---
 scripts/dtc/dtx_diff | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index 00fd4738a5877948..e9ad7834a22d9459 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -27,7 +27,8 @@ Usage:
        -s SRCTREE   linux kernel source tree is at path SRCTREE
                         (default is current directory)
        -S           linux kernel source tree is at root of current git repo
-       -T           Annotate output .dts with input source file and line (-T -T for more details)
+       -T           annotate output .dts with input source file and line
+                        (-T -T for more details)
        -u           unsorted, do not sort DTx
 
 
-- 
2.17.1

