Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76523C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4FE2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hyderabad.bits-pilani.ac.in header.i=@hyderabad.bits-pilani.ac.in header.b="Wj4xmeYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLSJFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:05:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:05:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so2776576pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hyderabad.bits-pilani.ac.in; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AJrQiLYNAF/E1S5b1mRsk2AKXE5RDFoq3eOqQWgOzh4=;
        b=Wj4xmeYtJjpM9+eir9kpHbU3gtjUwkOwdFw/EvV6YGe0tzGEoMse+DlGUjtcBn9AVk
         yO47EJj5NQKgrOeOIPnMUrgbu+AA4GfcezmWu/BdA94vaKjvQsY4g+/GfvFu/mfXGYcN
         lpfo/vUDhKF4SUgW8zx5yCFaqwukjL/NyeWi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AJrQiLYNAF/E1S5b1mRsk2AKXE5RDFoq3eOqQWgOzh4=;
        b=j23EosjN+QHvHHy5+7V0kdDOObZ1/uhIYz4G6D6mIChhU5G9yqXt9OMVjgELnmjAmM
         5BIMfRE9yPNTTXbdJmF9IkepGoqkCyAsqIrgDJt1UeeyG823TrbgxHGsOQSiX3Zf+KAS
         9p79hhWGyBExhtBV8H58eSElluV62HS5UC3gGZWdWeC4ZDoEOaK5WPsod7qak+V50Es+
         3pk+egqyLxbg5UtIUd9P+Ewxjl6ryedSBSvZGpR7Dud3Wo1aFInujN8dNWIBEeYGFlAI
         27d/54edwQTUaZ/cfLGR4LlZgt8b2xY8UAiW1gXTkTN6Nl9cGjKUzVsQbKnKz68cuVMe
         p36g==
X-Gm-Message-State: APjAAAW9WtKcByPK7KafFMCi/ZS4WEJprtwWJN9eUHAobWcNweOoluYm
        ZB+utqNOjITAl9isAN4Mia4ILQ==
X-Google-Smtp-Source: APXvYqywH5YqYI79B9shtzhIYrdCjNEdtTe+qTjaPdt1archPdCe6TtU6xTSOEzt/USyCkf1gUPrgQ==
X-Received: by 2002:a63:904c:: with SMTP id a73mr8027070pge.335.1576746334421;
        Thu, 19 Dec 2019 01:05:34 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:2800:cf9f:4401:9547:9e30:ea15])
        by smtp.googlemail.com with ESMTPSA id l127sm6502304pgl.48.2019.12.19.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 01:05:33 -0800 (PST)
From:   Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
To:     gregkh@linuxfoundation.org
Cc:     sudipm.mukherjee@gmail.comm, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Staging: sm750fb: sm750.h:Fixed Coding Style Issue
Date:   Thu, 19 Dec 2019 14:35:53 +0530
Message-Id: <20191219090553.13243-1-f20171454@hyderabad.bits-pilani.ac.in>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the checkpath error: function definition arguments
should also have identifier names

Signed-of-by: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ce90adcb449d..cf986bad7210 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -66,9 +66,9 @@ struct lynx_accel {
 						u32, u32, u32, u32,
 						u32, u32, u32, u32);
 
-	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
-							       u32, u32, u32, u32,
-							       u32, u32, u32, u32);
+	int (*de_imageblit)(struct lynx_accel *A, const char *B, u32 C, u32 D,
+		       						u32 E, u32 F, u32 G, u32 H, u32 I,
+							       	u32 J, u32 K, u32 L, u32 M, u32 N);
 
 };
 
-- 
2.17.1

