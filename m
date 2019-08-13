Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F83C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7204C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHMF65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:58:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40703 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMF65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:58:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so75911801lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 22:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cKF5OPDPR6lsToUJ5ub0RqfyHDWKLwL98RWj0ivUfs=;
        b=pDXCt2nusqmRbHzbG5y81OzJdjTR6nt9iiQ+DdOW1rGY6xwCrJPEQOlchliTb0+lqH
         KPBLeUuxWprTXxizLy5bE4/TLKbm7SqXiT1WohVgOhEubVIyzgZ6q559ffRFejHIIg81
         MREJhWGEVfm+odbXm5lptWiCNDj8AafRVY1j8rFe9yS+6tcjH+x2nYOzE1ajWXKVe4ZV
         ToAmi2hlDwTEbfSE98WsAVD0hKt0h8aemZV93yhdjVlyZ9GU8leDAml0+bWr3Pg6yRqt
         sxvPp01CccI01CyCiQVb55gpptA6jjVvjFBUazE/EaWEx2UVpNhZST7LWXG2XMPqGn6O
         LIsg==
X-Gm-Message-State: APjAAAXJ1iiTpxr+P6wbXvbcY5mjtPhQ6nRum9dHwD3PFguFhlQEJ/3u
        5zriV+uFSXaffY7JJrVxiWajvTbq7oM=
X-Google-Smtp-Source: APXvYqwBYYhnC0tCFyVxpL59g/olpbVelKEQ1JQiCNTLz8txt9J+e/oZOFt1AJG3pXoyLccnKFePpA==
X-Received: by 2002:ac2:550c:: with SMTP id j12mr17112807lfk.171.1565675934858;
        Mon, 12 Aug 2019 22:58:54 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id p9sm21642147lji.107.2019.08.12.22.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 22:58:54 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] MAINTAINERS: altera-sysmgr: Fix typo in a filepath
Date:   Tue, 13 Aug 2019 08:58:41 +0300
Message-Id: <20190813055841.9816-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo (s/sysgmr/sysmgr/) in the header filepath.

Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>
Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..bf5f0467988c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -723,7 +723,7 @@ ALTERA SYSTEM MANAGER DRIVER
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/altera-sysmgr.c
-F:	include/linux/mfd/altera-sysgmr.h
+F:	include/linux/mfd/altera-sysmgr.h
 
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
 M:	Thor Thayer <thor.thayer@linux.intel.com>
-- 
2.21.0

