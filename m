Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D12CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9899521734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="TGRoCxKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfKAT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:28:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfKAT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:28:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 8so2982688wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mutma0I285HLAM6Sw5PmtAvnBP2OZbW46A3J1dY9kk=;
        b=TGRoCxKACJ9VtmiTGZQHEaYEdxpZQOpr/Q2KzvtQoVIJMdZqdG5NtWy3ZhNQyoIlWL
         rUCsxm3aeT62XLB1CWUyTKX/z2ChTvUZ6BfGjDCFBhZMkOCcnLnoJHIgcCdUHKvgqiXn
         F6+3ChT8uGSArJQlizjjRlF/C8sN/OZq4Nrsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mutma0I285HLAM6Sw5PmtAvnBP2OZbW46A3J1dY9kk=;
        b=m+iQ7QVjxt/VJvXI0Ytnsk/OeyXmPvqicP2Ka8sALa37XUreecvxmVXZW8T0F1DFFO
         WlDw3CXJPmY+vp622tXK2hdkq3mYKOJvoAZBlaii8mjW6Tq9Wr5ovupU03pr2pkgxl8A
         O6DhJz64bJ4eC/AyVk/IPqX6jytAdm34BWEFuutASdzLKa6OrVLuZdbe6fNUm+Gnx7L+
         2S9LHmGSf9OhbnIzDMsaj+/XtfjvOL0z/Ti/AELSjGbPeWfK0LTVjZlTl/vc8CwNOgXN
         cayHcp2d2OXKNfbfDW77euMMJe7yps2AZgo/6InHoLvaZaoXxOs8vHwY8l99CBg77OY/
         ybww==
X-Gm-Message-State: APjAAAVYpAx/y16bf2S2B2S8xQsp4etvAA6+Kvn13bky8tZLFzbkcz78
        DUEC5IHaSdSS1ocsPpsNkOA3ew==
X-Google-Smtp-Source: APXvYqzLIKewNStvLv8a4CM24iYDjlSWZc7mf3HWJvdAslTWYLuXcXhtD9k/sua9kX7hD0Tu22Zn/g==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr11509610wmj.126.1572636535053;
        Fri, 01 Nov 2019 12:28:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.245])
        by smtp.gmail.com with ESMTPSA id a8sm9786395wme.11.2019.11.01.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:28:54 -0700 (PDT)
From:   Louis Taylor <louis@kragniz.eu>
To:     georgi.djakov@linaro.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] docs: driver-api: make interconnect title quieter
Date:   Fri,  1 Nov 2019 19:33:14 +0000
Message-Id: <20191101193314.67994-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it consistent with the other headings in the Linux driver
implementer's API guide.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 Documentation/driver-api/interconnect.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index c3e004893796..cdeb5825f314 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =====================================
-GENERIC SYSTEM INTERCONNECT SUBSYSTEM
+Generic System Interconnect Subsystem
 =====================================
 
 Introduction
-- 
2.23.0

