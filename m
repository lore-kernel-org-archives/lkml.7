Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4183CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F520862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n69ESweJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P4L2ewrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfJDJZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:25:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJDJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:25:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E44F60A4E; Fri,  4 Oct 2019 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570181129;
        bh=dOvwbRjHgOQsf29Gm6H+Y3leAlPnmKqU+HhghAIxm/8=;
        h=From:To:Cc:Subject:Date:From;
        b=n69ESweJcWq0Bgshd0CQF+cd92+u3PQLOI5i/yFWUvI4pwv2P0vYC2T183WzPeBQi
         Rt9cdVkrc5B52cxSLo3NWjJ4qnl53NFm6sEMb8dBCf913lvLq2KV/9dXM1gYvNXBGF
         olmv59Y+7X4MkPWWxX+hSaigOcsVpx3gtI/Zzqcg=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BAB46016D;
        Fri,  4 Oct 2019 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570181128;
        bh=dOvwbRjHgOQsf29Gm6H+Y3leAlPnmKqU+HhghAIxm/8=;
        h=From:To:Cc:Subject:Date:From;
        b=P4L2ewrrGwjUbeaRcG85BGjuW3wkkdxCeXRAAmppAlCtegY4cOGf2D96SlqsVp9lk
         l8VFFwidPC1r/k0tH3Hx33byB6x7Xe1EmulrXV3PdfI7BlhPg0Ufd9cIiUdzkg9kXA
         umTagsyQqKaLdvhPIPh9gxrc55nOVNS+GeELdhu4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BAB46016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] seqlock: Minor comment correction
Date:   Fri,  4 Oct 2019 14:54:44 +0530
Message-Id: <1570181084-4455-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

write_seqcountbeqin => write_seqcount_begin

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf2..370ef8f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -42,7 +42,7 @@
 /*
  * Version using sequence counter only.
  * This can be used when code has its own mutex protecting the
- * updating starting before the write_seqcountbeqin() and ending
+ * updating starting before the write_seqcount_begin() and ending
  * after the write_seqcount_end().
  */
 typedef struct seqcount {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

