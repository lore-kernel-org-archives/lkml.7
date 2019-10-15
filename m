Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45415ECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E042067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F0mI6uH3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F0mI6uH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfJOHfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:35:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJOHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:35:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE83E60A0A; Tue, 15 Oct 2019 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124921;
        bh=Uvd6h4vg0QhCpEywqoj+T4jripJu/TEtAazZuasn2aM=;
        h=From:To:Cc:Subject:Date:From;
        b=F0mI6uH3R59ph2gNfZpsZrrKaMFNxvBZsaamrhjITC5EbswSyi+cCIs82xDad4Qkh
         0heLoozXVrSg2i5LZx57cCIa/Qf59kqF9l+EXZzEsQthtEqyPz5F8IKOnhhyBjQr4r
         YcMCq5+wwsdIrHQbC+yCl2JaBu5Vkep6DF5JD0l8=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B28D060A0A;
        Tue, 15 Oct 2019 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124921;
        bh=Uvd6h4vg0QhCpEywqoj+T4jripJu/TEtAazZuasn2aM=;
        h=From:To:Cc:Subject:Date:From;
        b=F0mI6uH3R59ph2gNfZpsZrrKaMFNxvBZsaamrhjITC5EbswSyi+cCIs82xDad4Qkh
         0heLoozXVrSg2i5LZx57cCIa/Qf59kqF9l+EXZzEsQthtEqyPz5F8IKOnhhyBjQr4r
         YcMCq5+wwsdIrHQbC+yCl2JaBu5Vkep6DF5JD0l8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B28D060A0A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     trivial@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 3/3] cpuidle: Trivial fixes
Date:   Tue, 15 Oct 2019 13:05:12 +0530
Message-Id: <1571124912-10019-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iterrupts => interrupts
stratight => straight

Minor comment correction.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa..2df8ae1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -158,8 +158,8 @@ static void cpuidle_idle_call(void)
 	/*
 	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
-	 * activity happens here and in iterrupts (if any).  In that case bypass
-	 * the cpuidle governor and go stratight for the deepest idle state
+	 * activity happens here is in interrupts (if any).  In that case bypass
+	 * the cpuidle governor and go straight for the deepest idle state
 	 * available.  Possibly also suspend the local tick and the entire
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
 	 * until a proper wakeup interrupt happens.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

