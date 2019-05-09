Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E37C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359DF21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUGxOu3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfEIVOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47095 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEIVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so1937509pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/80tNNoqNchHETXJchLO/lOWqI7WgjPd5nso/co8eY=;
        b=AUGxOu3DHNF8Z86pQz5bIBLujbaK2WibpbQN8fpI80OL1P03ICeh4AplsYpo0qFBRQ
         r5uZOGgYhHqkAkBQk+TDLrEskDWUQKyqbOE1OL82v2vJPV8fy0aE9Fl+cumt3MStvrBm
         Pr+Q2OMf5iZpkU1jtgjbGkbVs6J5r2IZzJJ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/80tNNoqNchHETXJchLO/lOWqI7WgjPd5nso/co8eY=;
        b=mmF+S/3qQNWKvJMDgvF8SgcTUzup9ygdMZFoH31ttbJPbwliyrUIooU1hCetDojDxf
         Z7EHWlbPugVqQSQdjF6cm0z+pst6TCCVxDUFANJyMPHZbOWCCADnyGtmer3fHH92GBUP
         X52t0cZGLpiNyxcrJE7keCswePr4UOUPnRmpv1Tbzwknw8eYbaz5NlZFel997gwblqdM
         +vBZektOG1COzpIEvDrSThcnIxt4244kDG2+K0KtOIKPaUo9eXBcAuqSgKk5CfSGNc1w
         9fdwhDHUMAQX7frHs/9ZfGyNbtc8rhjLxMV1TjaAgfpObGYXzbqhFbLxEla4L9Q18waV
         k4hA==
X-Gm-Message-State: APjAAAW3DE8Ar7SVi0xdJpmoZKrfgZ3hMUEINX3nOBUBjGkOVfoi7GLB
        khSwuHPhg1thmBD9S2Kw163jAQ==
X-Google-Smtp-Source: APXvYqzyrCsBLpH98WnNvOPuqptMkqpqV1bnMw3nBAhqRCEzxFqDIvc2gG7qEY/DBoFVTYYkBzObvQ==
X-Received: by 2002:a63:7c54:: with SMTP id l20mr5267168pgn.167.1557436444004;
        Thu, 09 May 2019 14:14:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l21sm5186810pff.40.2019.05.09.14.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:03 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 01/30] mfd: cros_ec: Update license term
Date:   Thu,  9 May 2019 14:13:24 -0700
Message-Id: <20190509211353.213194-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..48292d449921 100644
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
2.21.0.1020.gf2820cf01a-goog

