Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F966215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfFYItE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:49:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44589 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfFYItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:49:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so8593099pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=XYfawICoHdlPGy5ZH9tUEdA5L/x6tBrf6K4qM9kf5sg=;
        b=oNp4avoS6DBd2m12DPn740kAENuxx1ny4b1XaNpVXzdYuKu4F6zlTqEQWsTH+cG2kY
         uKLmY1lvzzR22Rlc4OrxWW2k7TkA7VS5dvYASsPwgEWr/hxe/JsgwnPOpeXJSPKF7znc
         Ck03OCvff3PDf2mZnxEztkkEypFf9DSUaBBn66dlME88KzGjv/xnAN9GBrsDbawtotxf
         KdZzQlF9js4061IXkMGXZRRTlrD5wd3pPLUoOe1kU8XTs6PlMNJeFPe1nYM+xlwh4C5L
         18CfFCHQhpdSZhlNCiEdn/B3ABPpA7Zl2Z92/QoBg11yN5ny+oCCBysvFIqe2JyffiPq
         YDCA==
X-Gm-Message-State: APjAAAVJyyQ4zWlSmef9MY1/It1s/ydk/ycPNSra7sAOlLL25OQMXeng
        iTx6tXpVk7cVXhdbq2MsGPitFjNUECJ+brVu
X-Google-Smtp-Source: APXvYqwCNa0WsbZn8ggYUDLUE5+wy/qL+5LrgWFpRBkC745SFq+uYDzFVAJBlrt9/380thYgGcwsdA==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr31015596pjb.30.1561452541650;
        Tue, 25 Jun 2019 01:49:01 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id p27sm19264906pfq.136.2019.06.25.01.49.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:49:01 -0700 (PDT)
Subject: [PATCH v2 2/2] net: macb: Kconfig: Rename Atmel to Cadence
Date:   Tue, 25 Jun 2019 01:48:28 -0700
Message-Id: <20190625084828.540-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625084828.540-1-palmer@sifive.com>
References: <20190625084828.540-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     nicolas.ferre@microchip.com, harinik@xilinx.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help text makes it look like NET_VENDOR_CADENCE enables support for
Atmel devices, when in reality it's a driver written by Atmel that
supports Cadence devices.  This may confuse users that have this device
on a non-Atmel SoC.

The fix is just s/Atmel/Cadence/, but I did go and re-wrap the Kconfig
help text as that change caused it to go over 80 characters.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/net/ethernet/cadence/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 64d8d6ee7739..f4b3bd85dfe3 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Atmel device configuration
+# Cadence device configuration
 #
 
 config NET_VENDOR_CADENCE
@@ -13,8 +13,8 @@ config NET_VENDOR_CADENCE
 	  If unsure, say Y.
 
 	  Note that the answer to this question doesn't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the remaining Atmel network card questions. If you say Y, you will be
+	  kernel: saying N will just cause the configurator to skip all the
+	  remaining Cadence network card questions. If you say Y, you will be
 	  asked for your specific card in the following questions.
 
 if NET_VENDOR_CADENCE
-- 
2.21.0

