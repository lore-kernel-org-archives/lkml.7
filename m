Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DD0214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfE0Tp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:45:56 -0400
Received: from sauhun.de ([88.99.104.3]:36392 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfE0Tpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:45:55 -0400
Received: from localhost (p5486CF59.dip0.t-ipconnect.de [84.134.207.89])
        by pokefinder.org (Postfix) with ESMTPSA id 0FAC72C04C2;
        Mon, 27 May 2019 21:45:54 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: Karthikeyan Ramasubramanian is MIA
Date:   Mon, 27 May 2019 21:45:45 +0200
Message-Id: <20190527194545.20013-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mail just bounced back with "user unknown":

550 5.1.1 <kramasub@codeaurora.org> User doesn't exist

I also couldn't find a more recent address in git history. So, remove
this stale entry.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

I'd happily drop this patch if we can get a sign of life and a recent
email address.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 429c6c624861..9e38c8be2de4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13043,7 +13043,6 @@ F:	Documentation/devicetree/bindings/net/qcom,dwmac.txt
 
 QUALCOMM GENERIC INTERFACE I2C DRIVER
 M:	Alok Chauhan <alokc@codeaurora.org>
-M:	Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
 L:	linux-i2c@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
-- 
2.19.1

