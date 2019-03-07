Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131C20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X1OSCZwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCGABZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:01:25 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55442 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCGABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:01:14 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8F3EC10C21AE;
        Wed,  6 Mar 2019 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551916874; bh=uBmYKqGunxgMMz8mMmGUwSRfl0ij6sdb0ZXR2jJF+2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1OSCZwKQ0UFZQZSyPf+/BgI39GlN5XJvvFVptlxgx4oDsXO2Cfd1ijC2x8MMtiCe
         QSPR0i5YikmA1rx56MzxX/lHYn59Ub1nk1jqLv3Y8JLkJ3Xya/ymn+QUsRZIPg9odm
         DmPLD8WR9g2RGUIo8km9XgCoOXLOHEtCKD34pdfTGhqy2HyVd4UeWcjYdIaREHIbar
         k5u01zVRQ5kzkKPNSDlXRgsZqYQD6xu+yzwYX28K4ojSqiTXoUY9W2zHY9RmkmEbzZ
         B4vkAuUZWFrPpWKVftPM7rqVoL4CtItyvD8V7RIIawpAIMZw0kdsO7iAIXzwvZJr9v
         LsNL56rq+ZZkA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 48D17569C;
        Wed,  6 Mar 2019 16:00:42 -0800 (PST)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     bbrezillon@kernel.org
Cc:     linux-i3c@lists.infradead.org, joao.pinto@synopsys.com,
        linux-kernel@vger.kernel.org,
        Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH v2] i3c: master: dw: remove dead code from dw_i3c_master_*_xfers()
Date:   Thu,  7 Mar 2019 01:00:41 +0100
Message-Id:
 <6dcb0e17851cfb6913dda388d0960e0d1f15f853.1550587318.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <01dfc316793360cb601922caefe23153ca2db194.1550587318.git.vitor.soares@synopsys.com>
References: <01dfc316793360cb601922caefe23153ca2db194.1550587318.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190307000041.gB389Vc3RNHjHQgE7ErGtFkp6TTmySRD3bGWtKXfm9s@z>

Detected by CoverityScan (Event result_independent_of_operands):
"(i3c_xfers + i).len > 65536" is always false regardless of the values
of its operands. This occurs as the logical operand of "if"

"(i2c_xfers + i).len > 65536" is always false regardless of the values
of its operands. This occurs as the logical operand of "if"

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---

V2:
 In the previous version I didn't remove patch serie index from Subject
 Removed now

 drivers/i3c/master/dw-i3c-master.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index bb03079..eef6fae 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -840,11 +840,6 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		return -ENOTSUPP;
 
 	for (i = 0; i < i3c_nxfers; i++) {
-		if (i3c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
-			return -ENOTSUPP;
-	}
-
-	for (i = 0; i < i3c_nxfers; i++) {
 		if (i3c_xfers[i].rnw)
 			nrxwords += DIV_ROUND_UP(i3c_xfers[i].len, 4);
 		else
@@ -973,11 +968,6 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		return -ENOTSUPP;
 
 	for (i = 0; i < i2c_nxfers; i++) {
-		if (i2c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
-			return -ENOTSUPP;
-	}
-
-	for (i = 0; i < i2c_nxfers; i++) {
 		if (i2c_xfers[i].flags & I2C_M_RD)
 			nrxwords += DIV_ROUND_UP(i2c_xfers[i].len, 4);
 		else
-- 
2.7.4

