Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A829C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0B253E3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfE3JUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:20:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53811 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfE3JTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:19:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id d17so3466268wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXmoJNEbrPXtWcbWaevtm55gchiD7AFUrh4STNUZ8Vc=;
        b=nR/wDqAhThFQpDAt0t7fisYVPaGagEct2ncHBo3lqtvJiBaQQMsP+YIb048tnk9Ztm
         1kTcPA/BMG+dRLHtS21T146K0WbYoeo7e5q3xz0Jcx6QlACw6rarriRmMTCFd+/jZzD7
         q2K0eLVmg7GjA59vIZhYrzfa1GPUZZigQ9HjXTWGW58Uq7LZx1nUJm4MPHG9hYWo42V3
         eEIzAL6iYNISZPBX5B8oitYtt2lehRdOTEkjDD4ayjTUNFHxSONoWwrxRksMyz5TZtWi
         DmHuFV4ag72ZwI9SVy1bcAG3bszl2L02YiSVeUT1xrLK6KnGLsWRqOEg7iKILR8GIVTk
         z5ng==
X-Gm-Message-State: APjAAAUeJi5WitKIF0fyoiE4tCR22kvPxkuPpw01D+pGbBtYlOpQ/AR1
        Z10jKoE6zlZBNwKDOIPs8Ehk9A==
X-Google-Smtp-Source: APXvYqym7eo9mlaZEgk8nPuv2JK3WdsfJ+nEJnkLnO59sCZpkapBxwuZUf4hpQsVVYr6MgVmAweumw==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr1594795wmb.13.1559207993643;
        Thu, 30 May 2019 02:19:53 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id f24sm1513381wmb.16.2019.05.30.02.19.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 02:19:52 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tipc: remove two unused variables
Date:   Thu, 30 May 2019 11:19:52 +0200
Message-Id: <20190530091952.4108-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two variables which are unused after merging 6a33853c5773 and
generate the following warnings:

      CC [M]  net/tipc/sysctl.o
    net/tipc/sysctl.c:42:12: warning: ‘one’ defined but not used [-Wunused-variable]
       42 | static int one = 1;
          |            ^~~
    net/tipc/sysctl.c:41:12: warning: ‘zero’ defined but not used [-Wunused-variable]
       41 | static int zero;
          |            ^~~~

Fixes: 6a33853c5773 ("proc/sysctl: add shared variables for range check")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/tipc/sysctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 9df82a573aa7..180574ff3a3f 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -38,8 +38,6 @@
 
 #include <linux/sysctl.h>
 
-static int zero;
-static int one = 1;
 static struct ctl_table_header *tipc_ctl_hdr;
 
 static struct ctl_table tipc_table[] = {
-- 
2.21.0

