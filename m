Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9463621556
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rxmF2lup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLJQkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:40:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39944 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfLJQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575996023; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQEiwhZzXwQxjopyLACzbeQi0R34KC0lTmvzkFl3Opo=;
        b=rxmF2lupczuKnGE8lGPSwKOdfTs5PkrTcGVcLSTcGxk+9313NPIgoNOqKdHFDWrxty7Adu
        33VWKGFAUQ7ViJ1EPFqF84LBIa+wm9AtBsDJ1jwh5EUgr4Vmjw08c4d+8yJeP/91ovdulg
        UjpdAq+Ne80HMTp3iXJrdSAFG6qQNNY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 5/5] MAINTAINERS: Add myself as reviewer for Ingenic rproc driver
Date:   Tue, 10 Dec 2019 17:40:14 +0100
Message-Id: <20191210164014.50739-5-paul@crapouillou.net>
In-Reply-To: <20191210164014.50739-1-paul@crapouillou.net>
References: <20191210164014.50739-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the reviewer for the Ingenic VPU remoteproc driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v4: New patch

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..d82814ef2bee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8197,6 +8197,7 @@ F:	drivers/mtd/nand/raw/ingenic/
 F:	drivers/pinctrl/pinctrl-ingenic.c
 F:	drivers/power/supply/ingenic-battery.c
 F:	drivers/pwm/pwm-jz4740.c
+F:	drivers/remoteproc/ingenic_rproc.c
 F:	drivers/rtc/rtc-jz4740.c
 F:	drivers/tty/serial/8250/8250_ingenic.c
 F:	drivers/usb/musb/jz4740.c
-- 
2.24.0

