Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0689FC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA53D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbfFJKES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:04:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46781 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388647AbfFJKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:04:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so3440648pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VL7W9fZL6/Afil2J/mxLoXGQm5gFl+AhFAq1/FWfRX0=;
        b=LLeI2f/TkcPUfkwseoItq5/orwupFTxunFfHx5cVNNbNrS0v9LbMs3WXqSvdP+kd/j
         mZG7jJ3F3bAfZUFNsI6LF3jY+/mNa8llRRKfXj/3Eurc9K0FNxGxvwQcel3okGCkV13R
         ofrPMNjh6MYyn8lEmDY12LXVrdAh8m+4VfNrbkPjIkevxwCIpI2WOYGDzVYECbY/e00p
         sJzAg3kYY4o9CLzG4253D166Hmk9OirKLKME/p2p9zNDsOSHDdYovSkgW8TICArljR8L
         IAndLdYFYxdrC68RtOiK2Qq2p1yqhhTUL7GkFyv3FsNCTozpqYED4L92e184G5ZxWKyb
         nUDA==
X-Gm-Message-State: APjAAAVsa7CrNhWhQAcDTII4sRXN5y4UDiusNpCu5Dd6LxXTAf6YjZ77
        E9ZzQ8Ve3xa1ZfF4a7lhmA9WTrpJk7g=
X-Google-Smtp-Source: APXvYqzDr0J6ZRVKUD/yAIczeaILFdnQzJjOKMYBERKQCtn7Uet/99gmQt1F+I8Z8yK6peHQ1a6GTg==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr24078094plb.269.1560161057781;
        Mon, 10 Jun 2019 03:04:17 -0700 (PDT)
Received: from localhost ([122.177.221.32])
        by smtp.gmail.com with ESMTPSA id p2sm5604993pfb.118.2019.06.10.03.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:04:16 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     arnd@arndb.de, bhsharma@redhat.com, bhupesh.linux@gmail.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RESEND PATCH] Documentation/stackprotector: powerpc supports stack protector
Date:   Mon, 10 Jun 2019 15:33:39 +0530
Message-Id: <1560161019-3895-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc architecture (both 64-bit and 32-bit) supports stack protector
mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
add stack protector support")].

Update stackprotector arch support documentation to reflect the same.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Resend, this time Cc'ing Jonathan and doc-list.

 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 9999ea521f3e..32bbdfc64c32 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
-- 
2.7.4

