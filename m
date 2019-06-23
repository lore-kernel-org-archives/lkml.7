Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114EBC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D993B2073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFWOpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 10:45:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34736 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 10:45:22 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so30130iot.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 07:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOuGlUvj6Y52Av2r1WPq8pFEjxnJHawsCR+WxrVa7n0=;
        b=q/qtM1WyMbsnFVPpgj/x2zzR232iovKQMQmie2/xod00BpPAnTkrgP+adkDCddNxw4
         GNjp1jEsctTtARVaoz5zLjhkK3tNcW6fJHmmKOQTV0WT8e0Syv3GQKXPlkSNuNk/M7or
         v5U7ypF/X9AWcUp5UTWYXT4QHPvuNKId7/kkLAchfUBNzqrJujt+IvnX3myDhXtBP+/Z
         ZU1G1a+5/ZovXlf/IWuA9ai5fjWUQlpwSHkJEyWa9ek8XPN8ASIHu5NOkUABVc4FZqBm
         jIgwhMiqDVYyFC2bbGPvzgtXRvnChZS95Hjj3eWYeBvougk3z1cC5TMA/AXCCBTA+Brl
         S5PA==
X-Gm-Message-State: APjAAAWl0B69aoEOT3j30jCQT0bP9eiejIVSiXSxXsOMe7UomijA3ffL
        fGlGRxVt1yZwwzRMgAHETHE=
X-Google-Smtp-Source: APXvYqwGxRtDkkC/HYSf0Xa19EOVzPy4PDH0ijGyOCA3nY1iJcjvQeSpvF80Hn9dksyXl8H0ioDvUQ==
X-Received: by 2002:a02:c50a:: with SMTP id s10mr94304162jam.106.1561301121327;
        Sun, 23 Jun 2019 07:45:21 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id k8sm8057458iob.78.2019.06.23.07.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 07:45:20 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: stmfx.h: typo in the header guard
Date:   Sun, 23 Jun 2019 17:44:59 +0300
Message-Id: <20190623144459.21608-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guard macro MFX_STMFX_H in the header stmfx.h
doesn't match the #ifndef macro MFD_STMFX_H. The patch
fixes the typo.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/mfd/stmfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
index d890595b89b6..3c67983678ec 100644
--- a/include/linux/mfd/stmfx.h
+++ b/include/linux/mfd/stmfx.h
@@ -5,7 +5,7 @@
  */
 
 #ifndef MFD_STMFX_H
-#define MFX_STMFX_H
+#define MFD_STMFX_H
 
 #include <linux/regmap.h>
 
-- 
2.21.0

