Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35716C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB745214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ji5nrVHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfDYBqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:46:15 -0400
Received: from m15-114.126.com ([220.181.15.114]:50434 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388113AbfDYBqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=gaY9dKmBdVmBI4Frdg
        XAALBbgfcPU9dKJoy6To4wo04=; b=ji5nrVHYnTPdfAOKGn7xMpTYAg8k2YPT9V
        HNcpyXmaPsapZUWwcQIAqcpMgng9PAYFmrti74nHqQwRxB1aVAEsQb74U6CLovzD
        gfQkX2By8A7gLa1vilEdGwf7BuhqvRp0Xgx/0765m/Zno9V2fPTC1PaLaCAGr8+y
        p+8v3Jifo=
Received: from localhost.localdomain (unknown [221.237.156.247])
        by smtp7 (Coremail) with SMTP id DsmowADXIvldEcFcZEtKBA--.41606S2;
        Thu, 25 Apr 2019 09:46:07 +0800 (CST)
From:   jojo_zeng@126.com
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jojo Zeng <jojo_zeng@126.com>
Subject: [PATCH]  of/device.c: fix the wrong comments
Date:   Thu, 25 Apr 2019 09:45:54 +0800
Message-Id: <1556156754-18993-1-git-send-email-jojo_zeng@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsmowADXIvldEcFcZEtKBA--.41606S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1UtFy5ZFyDZF15ZFyfCrg_yoW3WrX_Cw
        1jvFW7Xw10yF1xuF1fKa1fZr9IyF12grWkZF1Sqas3JryaqrW3ZrZFyryxKa4UWFWUuF1U
        uw1qqr4IyrnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5D73DUUUUU==
X-Originating-IP: [221.237.156.247]
X-CM-SenderInfo: 5mrm0sp2hqwqqrswhudrp/1tbikx+hMFpD8T7OlwAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jojo Zeng <jojo_zeng@126.com>

the comments which discribed the input parameters of of_match_device(). 
the name is changed, so fix it.

Signed-off-by: Jojo Zeng <jojo_zeng@126.com>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a..da81583 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -17,7 +17,7 @@
 
 /**
  * of_match_device - Tell if a struct device matches an of_device_id list
- * @ids: array of of device match structures to search in
+ * @matches: array of of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an platform_device present in the
-- 
2.7.4

