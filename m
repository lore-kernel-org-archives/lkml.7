Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4459220838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oGFr/Yx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbfHAVjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:39:47 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:41893 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbfHAVjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:39:44 -0400
Received: by mail-pl1-f182.google.com with SMTP id m9so32640805pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTSTyTo6evUeD9vN87wB9846b+0jKcxNJYQscwXw5sw=;
        b=oGFr/Yx9DyGhI50VQm1FHg7m80SFWMNbUN+tYT0ynTmdIhVJrx0hDJmrxELW007H7y
         GwOLFmBgY4U68waEvukrSObbPl1mqmmiKjjYscKkfeOKtDeiM8gx2IpJk0Jn9eeV/hzO
         3kgpe7tzM4srhjNeWUHuzLe+K39ZGNnmbeuBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTSTyTo6evUeD9vN87wB9846b+0jKcxNJYQscwXw5sw=;
        b=AtwhbvUckbS3W7KfyjuiHlahtYguh+e0dh+KWSSZDVJOFd9wyapSBRiL8vqFjvye1r
         EySgYGHKXL9I/88IhN0jVad03sGWmVUH+wFXzkg5UKe2HOiOGFj23mxGLjG5Sc9RWxUV
         NGDbw6js8i9ArAyZGrIhcDbf7l4vRnZlPbURx38PEXp9mymYDsV72o1a6BqhlxJe7WLQ
         NhrJwI+G/8K0Mt3YsYawlAZzuOownqkLk7/ULj8Ftqyob5AUxhRl7NGA71G/IPaENnUi
         yo1+bKeCWOZC6en78sV3Ep3Zwo1OooIw8gwMhKhlocU2AsU4/XhIF6sYnHv48zp8kDou
         Uiuw==
X-Gm-Message-State: APjAAAXGL5EUjNO8JzLvf7k9+V76O7xFAx2fWfJFkkUQ+o9GZvfJvBZi
        QjGsEXI7c2P8vISrxrDMOgvg30ye
X-Google-Smtp-Source: APXvYqzlQW8pav1BVOJ8PWWMEYeSP1jsupHMeXiJzvHjoTgxYZ4mUSAJ8/P90V7PJA24mKYNwKGBug==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr121131011ply.251.1564695583663;
        Thu, 01 Aug 2019 14:39:43 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r61sm5940423pjb.7.2019.08.01.14.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:39:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: ['PATCH v2' 5/7] docs: rcu: Increase toctree to 3
Date:   Thu,  1 Aug 2019 17:39:20 -0400
Message-Id: <20190801213922.158860-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801213922.158860-1-joel@joelfernandes.org>
References: <20190801213922.158860-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These documents are long and have various sections. Provide a good
toc nesting level.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 94427dc1f23d..5c99185710fa 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -5,7 +5,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 3
 
    rcu
    listRCU
-- 
2.22.0.770.g0f2c4a37fd-goog

