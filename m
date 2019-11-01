Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6686CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163A217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfKAPU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:20:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38276 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKAPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:20:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id z19so5212021wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 08:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMEz8D3S6e/piMAQ+pM8XO5S9kvzfBwBTg3kkWGraWM=;
        b=CuqZy7TfU3S2sL4ZXlJsqkBIcEq6PZP7NTpl4vuKQyB1tH9l6sIo+35iF93Qshghwn
         3nGUaFqBdwE/XOE81pA12DTPMjYq2n9jZ9Mz1AVL/ayzZ8Lfa9rPFGP8ZZ7Et/5huyik
         Q13354zKEKG23xMhmhUJiehLDuclwqq6iHb3AxzlRqXHYZ0IUxmsg7vVAFhYOTSCs8Y5
         BG1zZ2g3/tqF1T89Fi2BdB8hf5PWc41Sw9wmm/TujyohdWP1VNNZeObYt4ac5A2/O4oF
         OruhPYpOjjfapzvVxJ/BXeD6q565Vh6Us2oTGtkp1sSXpd2AqwnifmhnJABzUXlIgXXA
         QxGg==
X-Gm-Message-State: APjAAAVZ67NVAQit9XwiYPUXdNwmRkR2VA73IZ9ujSyS4TWMUFYbGpIP
        m2H0L5aJojRACyw42wd2t0IqPrZ5HsU=
X-Google-Smtp-Source: APXvYqyPYnwLX0ztKWCWcp147LlXxzyXXV46TIFC3kuUqPVizYEW02nQ+IlnuIyUYuZm6hhZO6qE9Q==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr1866481wmd.39.1572621626378;
        Fri, 01 Nov 2019 08:20:26 -0700 (PDT)
Received: from localhost.localdomain ([2a03:b0c0:1:e0::503:c001])
        by smtp.gmail.com with ESMTPSA id c137sm4872163wme.37.2019.11.01.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:20:25 -0700 (PDT)
From:   Julien Grall <julien@xen.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH] docs/arm64: cpu-feature-registers: Rewrite bitfields that don't follow [e, s]
Date:   Fri,  1 Nov 2019 15:20:22 +0000
Message-Id: <20191101152022.8853-1-julien@xen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

Commit "docs/arm64: cpu-feature-registers: Documents missing visible
fields" added bitfiels following the convention [s, e]. However, the
documentation is following [s, e] and so does the Arm ARM.

Rewrite the bitfields to match the format [e, s].

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

This is based on the branch for-next/elf-hwcap-docs from the tree
arm64/linux.git.
---
 Documentation/arm64/cpu-feature-registers.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index ffcf4e2c71ef..7c40e4581bae 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -193,9 +193,9 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
-     | SB                           | [36-39] |    y    |
+     | SB                           | [39-36] |    y    |
      +------------------------------+---------+---------+
-     | FRINTTS                      | [32-35] |    y    |
+     | FRINTTS                      | [35-32] |    y    |
      +------------------------------+---------+---------+
      | GPI                          | [31-28] |    y    |
      +------------------------------+---------+---------+
-- 
2.17.1

