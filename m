Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E2C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3035C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W6iE9iOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAGVEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:04:49 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:27848 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729064AbgAGVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578431080; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pM96uG7kOvxrdrZdRV9eTx7muU1tYbOYa1CmMpkX/ic=; b=W6iE9iObbquD9u5884Go/532ljVuZ9QIVNKIfudClYqsvpfhBgo2sjtDRV12dGOR7gRPqBga
 X+RlYQg2KdXgmcGqQnhRZ0eIks6n275+z3vTU/ED/i19ltHfri0wXCzN0SMopd+8OcWn7PoF
 YaeFMmRhYU9l5Pln6HvRvZFtdvo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14f267.7f77e90ae030-smtp-out-n02;
 Tue, 07 Jan 2020 21:04:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE17EC447A4; Tue,  7 Jan 2020 21:04:38 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAB05C447A6;
        Tue,  7 Jan 2020 21:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAB05C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        swboyd@chromium.org, Stephan Gerhold <stephan@gerhold.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/17] firmware: qcom_scm: Remove unused qcom_scm_get_version
Date:   Tue,  7 Jan 2020 13:04:12 -0800
Message-Id: <1578431066-19600-4-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused qcom_scm_get_version.

Change-Id: I7e638d3ece7a2d52b51f570bb680cf3c5dcdc347
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Brian Masney <masneyb@onstation.org> # arm32
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 36 ------------------------------------
 include/linux/qcom_scm.h       |  2 --
 2 files changed, 38 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 6e62f73..8b57240 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -292,42 +292,6 @@ static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
 	return r0;
 }
 
-u32 qcom_scm_get_version(void)
-{
-	int context_id;
-	static u32 version = -1;
-	register u32 r0 asm("r0");
-	register u32 r1 asm("r1");
-
-	if (version != -1)
-		return version;
-
-	mutex_lock(&qcom_scm_lock);
-
-	r0 = 0x1 << 8;
-	r1 = (u32)&context_id;
-	do {
-		asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r1")
-			__asmeq("%2", "r0")
-			__asmeq("%3", "r1")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc	#0	@ switch to secure world\n"
-			: "=r" (r0), "=r" (r1)
-			: "r" (r0), "r" (r1)
-			: "r2", "r3", "r12");
-	} while (r0 == QCOM_SCM_INTERRUPTED);
-
-	version = r1;
-	mutex_unlock(&qcom_scm_lock);
-
-	return version;
-}
-EXPORT_SYMBOL(qcom_scm_get_version);
-
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
  * @entry: Entry point function for the cpus
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 2c1d203..98e775d 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -78,7 +78,6 @@ extern int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 			       const struct qcom_scm_vmperm *newvm,
 			       unsigned int dest_cnt);
 extern void qcom_scm_cpu_power_down(u32 flags);
-extern u32 qcom_scm_get_version(void);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 extern bool qcom_scm_restore_sec_cfg_available(void);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
@@ -123,7 +122,6 @@ static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 				      const struct qcom_scm_vmperm *newvm,
 				      unsigned int dest_cnt) { return -ENODEV; }
 static inline void qcom_scm_cpu_power_down(u32 flags) {}
-static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
 qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
 static inline bool qcom_scm_restore_sec_cfg_available(void) { return false; }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
