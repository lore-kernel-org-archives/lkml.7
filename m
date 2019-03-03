Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F186C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D56A2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="lS8vo+k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfCCQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:55:58 -0500
Received: from tomli.me ([153.92.126.73]:42626 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfCCQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:55:56 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 855162e8;
        Sun, 3 Mar 2019 16:55:54 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 03 Mar 2019 16:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=In5+wEpZ+A7H086V4WiG1jXm7trt64OIVFCTapa2uOo=; b=lS8vo+k8GX3j6Vzl4mTn50Y1uor5kSc19GJuU0AspKjFxa+G5sBf52xowOSi9MANa9nbXz7EXwgzQ3FoeUCUKkDN4kpcbZQioD25+Pc/D6/8f8EkvCcUo2M02OgX6j0CL1nxyTaB38Z3gRWUlMium5LGoXD3naMKlCw/XlqiSX57e+8SNPrVC533U/wOKPWaPbX/qyHrLd1N7BVexwAEhEBjQ7v0e2bOp5EffB4HFjiK+r62i1gbbGAd4ZIMzoUHtIfVgWnoW487PeWD8f6mrkrWfgLrMLpiExb9x0qDe9lmaNsDvG1d6p34ScaOouAnb2BSbHxmAbckxD/TQPGCsA==
From:   Yifeng Li <tomli@tomli.me>
To:     Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org, Jin Chen <nobijinc@gmail.com>
Subject: [RESEND][PATCH 2/2] staging: sm750fb: trivial Camel Case removal for setDisplayControl().
Date:   Mon,  4 Mar 2019 00:55:32 +0800
Message-Id: <20190303165532.23727-3-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
References: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function setDisplayControl() to set_display_control().
This fixes the following checkpatch.pl warning:

    CHECK: Avoid CamelCase: <setDisplayControl>

Suggested-by: Jin Chen <nobijinc@gmail.com>
Signed-off-by: Jin Chen <nobijinc@gmail.com>
[tomli@tomli.me: resent as trivial patch, reworded the commit message]
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/staging/sm750fb/ddk750_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1273e7d18925..f38051eedb6c 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -5,7 +5,7 @@
 #include "ddk750_power.h"
 #include "ddk750_dvi.h"
 
-static void setDisplayControl(int ctrl, int disp_state)
+static void set_display_control(int ctrl, int disp_state)
 {
 	/* state != 0 means turn on both timing & plane en_bit */
 	unsigned long reg, val, reserved;
@@ -137,12 +137,12 @@ void ddk750_setLogicalDispOut(enum disp_output output)
 
 	if (output & PRI_TP_USAGE) {
 		/* set primary timing and plane en_bit */
-		setDisplayControl(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
+		set_display_control(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
 	}
 
 	if (output & SEC_TP_USAGE) {
 		/* set secondary timing and plane en_bit*/
-		setDisplayControl(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
+		set_display_control(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
 	}
 
 	if (output & PNL_SEQ_USAGE) {
-- 
2.20.1

