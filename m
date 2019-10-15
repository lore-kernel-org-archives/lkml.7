Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45F3ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D372067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ff9/L7j3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BUOLmJSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJOHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:33:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfJOHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:33:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6928C60A0A; Tue, 15 Oct 2019 07:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124832;
        bh=BCgHd8RXgMM//Bud5oxei8XiZ28Z3DUoTBXWc3TdVrI=;
        h=From:To:Cc:Subject:Date:From;
        b=ff9/L7j3DMbXq/CLnOhsieOwqdtPL8DLhVNJT4VS+WtmHwSkPrlNz3zW9X8r9k7H9
         UzXbUta+xk7tL712qya0Mq0mwzOCrrkgJOihqVXJfLr2z6KMbttdPb6+OMTQfZFSSW
         lyHUxAZ0/Se9LmTaI/KG9vcrVTQ+bTRSBnFJTtmk=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A012360A0A;
        Tue, 15 Oct 2019 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124831;
        bh=BCgHd8RXgMM//Bud5oxei8XiZ28Z3DUoTBXWc3TdVrI=;
        h=From:To:Cc:Subject:Date:From;
        b=BUOLmJSzFce/5Qk7UDUteCjIiYF4Uef+5hHJhcuBmR07uErfDYiPCVg9h3uqZ7J6+
         2wO/uR3Wc2Y8+rjStpiUgvVL8Tj0T4r0nT6VsGJAcqC2UelcWEhLQV0jlsSok7/OTQ
         z0JU0enDokWYSFDuy02dpsnOiscOf7bXLKxgQrmc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A012360A0A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/3] time: Fix spelling mistake in comment
Date:   Tue, 15 Oct 2019 13:03:39 +0530
Message-Id: <1571124819-9639-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

witin => within

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5c54ca6..d31661c4 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -179,7 +179,7 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
 		return error;
 
 	if (tz) {
-		/* Verify we're witin the +-15 hrs range */
+		/* Verify we're within the +-15 hrs range */
 		if (tz->tz_minuteswest > 15*60 || tz->tz_minuteswest < -15*60)
 			return -EINVAL;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

