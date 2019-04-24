Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5358C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AF214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isn3T/AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfDXX3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35426 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfDXX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id j24so498250pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUikYk2AXM/tRe7bRNnjKsn80lzWeJQBXtOvswFrUdE=;
        b=isn3T/AFJcGV9DNClXdS6lJzK2SFEt+dj53XfLytTyORaJ+Bx0LK/xp/ySOCtsi1Cw
         5B9gLhml2cu789FkoMJRNAtcZXo1umiqw3wSNKuHwAGvKNg1YmkKmU90aHEO+wXh/IH1
         PMcAH7qEwpjZk4OydfVX+4JmbGuTY+1GQg1Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUikYk2AXM/tRe7bRNnjKsn80lzWeJQBXtOvswFrUdE=;
        b=q8ia/E91wlHcT14uKRnnSfhYVT+OEwC/K/+F2C90mhz/wAQXzoLtf43aFi5o3xz38V
         sHEVYF8rJtQ/8CwE269xmKE9eNJku0hRever1SlXzgEZCIRpg9FqI/5inWlZNc0IzNnH
         9MPoeKa7485grlmlphm+4EAlXoYZQJmO+UNoOsc9iRBnCgUOu5I+k9LkD6U3MjdJlbSm
         cFhth9MLgF1xxBpYgkH+1glwutOP555Y4cjUYYN9Y3g5YTP/cSCR+TtPV5UqwbqRfhwO
         Im+UGxU55pLq/R/JQAnAdcpn3ANcO6GwVtBmIeBlSnyUMusCDMAxSbsfO6u5F1uUR607
         qd5g==
X-Gm-Message-State: APjAAAWQkRRiEFw8akTHferxuKn0hRKUGuGyQEyr9ltTQvA30Qs0s58/
        +ANiRHvBKeKCsYUOBWK/zl7CLA==
X-Google-Smtp-Source: APXvYqySOIcqsScVYwOP22/rnPWEVxIzqTKWSwanriSgBt+V6jFXsrvSJ9TnmyllNFW0EWk+DlnWvg==
X-Received: by 2002:aa7:9ae9:: with SMTP id y9mr30401960pfp.111.1556148569547;
        Wed, 24 Apr 2019 16:29:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n5sm22089311pgp.80.2019.04.24.16.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:28 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 01/30] mfd: cros_ec: Update license term
Date:   Wed, 24 Apr 2019 16:28:49 -0700
Message-Id: <20190424232918.243308-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to SPDX-License-Identifier, GPL-2.0

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 43bee4f7d137..6fa508643da3 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,25 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Host communication command constants for ChromeOS EC
  *
  * Copyright (C) 2012 Google, Inc
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- *
- * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
- * project in an attempt to make future updates easy to make.
+ * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
+ * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
  */
 
+/* Host communication command constants for Chrome EC */
+
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
-- 
2.21.0.593.g511ec345e18-goog

