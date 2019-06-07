Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673BAC468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC27208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559936701;
	bh=n+3Sw/P9Edjb/WQZTIlVmNy5Vbg1PHkTk5IHHvvsEdw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JrHJLHtFj+tmQq24K2EHplub0/Kr+lqOQXv4TJMC8ABuA6rAXaHhHUT4PfqgFxchw
	 CsdehKRCMAXDxLkOt1+jL7d2uL06vM2fSSL/1bNdEa/mPRrt0FP+4Rs9TzJx6clrZ3
	 ajnWXsK0TcJzabn+L29Tyo+TgRm1T89cSKLJtpyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfFGTpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbfFGTpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:45:00 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CFE20868;
        Fri,  7 Jun 2019 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559936699;
        bh=n+3Sw/P9Edjb/WQZTIlVmNy5Vbg1PHkTk5IHHvvsEdw=;
        h=From:To:Cc:Subject:Date:From;
        b=keuDiN46VAX426027Ek7ZhfHrrLZ+7LmzFjuTfC9cmVWvXvnwLMzO5UNlHW2g4etB
         sULqXu0w1bwKfEKPKnBn6zQrKRN+KRgcznA5AAxxUe7aOKzAa/TUvFkTaHwp7Br4WP
         CJN/U/4GrtR6AnBf9K/sZr6aceSFkgWvEDXWRngc=
From:   Andy Gross <agross@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>, arm@kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: [PATCH] MAINTAINERS: Change QCOM repo location
Date:   Fri,  7 Jun 2019 14:44:51 -0500
Message-Id: <1559936691-15759-1-git-send-email-agross@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Qualcomm SoC repo to a new location.

Signed-off-by: Andy Gross <agross@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..de1e935 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2079,7 +2079,7 @@ F:	drivers/tty/serial/msm_serial.c
 F:	drivers/usb/dwc3/dwc3-qcom.c
 F:	include/dt-bindings/*/qcom*
 F:	include/linux/*/qcom*
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.7.4

