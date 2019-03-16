Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9765C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629CF218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="S3pXtQso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCPIYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:24:54 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:35266 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfCPIYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1552724683;
        bh=/3wAmjeN0cIGzy5DZTJ/ziA60IIYWkbnOFSw9R06bQ4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        b=S3pXtQsoAIoG9QzHklBKDMvHOZAz9wIZ/KthQ0eFJw6armoA5NLSTUHi5CdzqXyCI
         sqfDipj3KFEqQo8ILvs70OjiV35HsFADbuRrI3g09eBDK03s+h8MY2G6FaNxKencSd
         XXBammQbslNmdwAHd/y30nstXt2wIkypbRMcTV9g=
X-QQ-mid: esmtp5t1552724681th1gb06nn
Received: from localhost.localdomain (unknown [221.220.226.231])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 16 Mar 2019 16:24:37 +0800 (CST)
X-QQ-SSF: 01000000000000F0FG4000000000000
X-QQ-FEAT: oIoGrveFQB8++20FdXkpMe83xp4aave0AsB6TO9mBXSzVeaiytYuMARLv9hzH
        /uGzwqhbOF+b9SEuD16XS4TySf2SNtSW93vvrviB9XyGLU54tL36wCIc6wgluyTjn2NzpXY
        3HVZ0u03tToXrEbEF3+g4Qi7Weeq9gnIcLpKt1kPgBIVsNEn4BWwWbzbDuKDzri3Sz6z6kO
        1s4RFXG2CBd/7aqIMI0x+rKa2kd71ifyVvPjQO2RL1NRn89XJWfEtk92+kvUQdCI2OJPJtv
        cMoBtdxknWhTZjV9HmMGlWHOY=
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, osandov@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: trivial - update comment for sbitmap_deferred_clear_bit
Date:   Sat, 16 Mar 2019 16:24:37 +0800
Message-Id: <20190316082437.2766-1-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"sbitmap_batch_clear" should be "sbitmap_deferred_clear"

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 include/linux/sbitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 14d558146aea..20f3e3f029b9 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -330,7 +330,7 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
 /*
  * This one is special, since it doesn't actually clear the bit, rather it
  * sets the corresponding bit in the ->cleared mask instead. Paired with
- * the caller doing sbitmap_batch_clear() if a given index is full, which
+ * the caller doing sbitmap_deferred_clear() if a given index is full, which
  * will clear the previously freed entries in the corresponding ->word.
  */
 static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
-- 
2.20.1



