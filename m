Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6B42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eiwUf6EU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eiwUf6EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfG2H4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:56:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfG2H4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:56:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3CDB6030E; Mon, 29 Jul 2019 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564386969;
        bh=Q3GrgOXXJ5DPh+opvjNnjdxQLGAJvH18gDZjL4btvwI=;
        h=From:To:Cc:Subject:Date:From;
        b=eiwUf6EUoSDmVOr0mHNiFXEU8PH4vsF0rM3Cameeiaz6xX80foLVR6RgWuTel8f9h
         6qVZzhpgsexRnuSS292/I5YnpFE8zDjVy6j1RRmlxtyuMas8GiAezV7rDu+NFYUUMO
         X/b5FWttoAY1IOffS6IbJxmIROhClDzDNNa1ROrQ=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3EC5602AE;
        Mon, 29 Jul 2019 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564386969;
        bh=Q3GrgOXXJ5DPh+opvjNnjdxQLGAJvH18gDZjL4btvwI=;
        h=From:To:Cc:Subject:Date:From;
        b=eiwUf6EUoSDmVOr0mHNiFXEU8PH4vsF0rM3Cameeiaz6xX80foLVR6RgWuTel8f9h
         6qVZzhpgsexRnuSS292/I5YnpFE8zDjVy6j1RRmlxtyuMas8GiAezV7rDu+NFYUUMO
         X/b5FWttoAY1IOffS6IbJxmIROhClDzDNNa1ROrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3EC5602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     paulmck@linux.ibm.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] rcu: Fix spelling mistake "greate"->"great"
Date:   Mon, 29 Jul 2019 13:25:57 +0530
Message-Id: <1564386957-22833-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in file tree_exp.h,
fix this.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index af7e7b9..609fc87 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -781,7 +781,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * other hand, if the CPU is not in an RCU read-side critical section,
  * the IPI handler reports the quiescent state immediately.
  *
- * Although this is a greate improvement over previous expedited
+ * Although this is a great improvement over previous expedited
  * implementations, it is still unfriendly to real-time workloads, so is
  * thus not recommended for any sort of common-case code.  In fact, if
  * you are using synchronize_rcu_expedited() in a loop, please restructure
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

