Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BAC468B0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA1921473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfFPI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:58:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfFPI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:58:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so6664357wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 01:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sgxUU390W2PtuQ88MMXWGwjdnv5ZXrQD67uDLz3qgg=;
        b=akokCc4aeSsHGKnHmL988FiySRsn/eZMHbUxABNls/89iicJchtbgu3/lBhYUSQCcA
         /JMVn+cChXjzhwanwoVUqwkzaBsWwTDCC1Oba+eZuHbtRype4EB92bccsUuw5W+Az92W
         NxjkkzT0zIjneCncX/z7UcdZ7cDwkkivMASzXubQHojSQkU6Th2A/v94HAwiJu/25fBz
         B6xYkvLqXPCOWTcVdqz6jrlSXic3zZPa95/xGBpWWTDh68YljRrGFnP6A4OkJb4OfeOx
         NXw4jjnQEV+eNKrNCcvglNL87M2w789ePwUXF7rgp5lNybqY63661ktXjiTa+qnMddAD
         TuXQ==
X-Gm-Message-State: APjAAAVNpre3pRXL3jtliV7itiNNO7pPrLcjfY+f2fcsFzMrvgOXjGUr
        0uS1le6C5IZyqQ4b6PsGS7peTg==
X-Google-Smtp-Source: APXvYqwX2256HeSx7fk/qLqgGOiy/mrmlvd+nYfLi1zyyw8W3Dtaz40qJJqmoIRaEQdsdMHYjWP9JQ==
X-Received: by 2002:adf:f610:: with SMTP id t16mr9367740wrp.3.1560675522190;
        Sun, 16 Jun 2019 01:58:42 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h90sm18578838wrh.15.2019.06.16.01.58.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:41 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 3/5] mm: include uio.h to madvise.c
Date:   Sun, 16 Jun 2019 10:58:33 +0200
Message-Id: <20190616085835.953-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't compile it w/o this header.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 70aeb54f3e1c..9755340da157 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -25,6 +25,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/uio.h>
 
 #include <asm/tlb.h>
 
-- 
2.22.0

