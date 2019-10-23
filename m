Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B6ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577B6214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfJWFyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:54:07 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34140 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727719AbfJWFyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:54:06 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5s50e005894
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:54:05 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5s0jN030037
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:54:05 -0400
Received: by mail-qt1-f200.google.com with SMTP id t25so20190750qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 22:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XpCZHMTbKXINebAUsqqTWQnMeRldTzQA3tx+o31MY8A=;
        b=ANixQJ4KpaM+tJ4uxCKN6+ureSeQMcBLOCEx9GxIlM/Gk2edAPI4B5J2wzinj73Jrd
         L1qm8qUtCONeFwi0VOeoekrtiUlTkrYhZVHRu0jPiALMvlU5cedgbaTGwwAmTsW5y1g0
         hKn0EaeLkxSF5LlyM7SUHZClH7pCevc0jCnysLHuzc0YZAfNLjp9WmJ4wQR6QVt2Gq7G
         6pIlez7083aW6zjxxQ36fTV2Bx30Wp6yOvJn/WUVZPnvbZsTu8kIA5IQA4yWGHeIO1I7
         23EUXGTnsQodNp2VMzptQiLNM3VizpHwXBzPLTlUf+NHIcOi19GVq5dwPc+CTmtaNUTt
         RXBQ==
X-Gm-Message-State: APjAAAWc+JWvwYAagkJS/YZ8pUvp35X88IcWn5z7yVD6xY2N8Xa25Dqk
        90fJi/2MDBM1WAp4T3Lz08EV5v2tlZFOByK648SFgSbaH3WxbdDIbhjknO6L29NKVzKYDZXozWm
        zfPLM5Z/gjC8Du81yulhjReYnMXC2XOwWhgI=
X-Received: by 2002:ac8:7289:: with SMTP id v9mr7378757qto.139.1571810040120;
        Tue, 22 Oct 2019 22:54:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0O5lzS2JrJB3r/ZBWxG9Vjh+mJTh2FC0VZrknY0ujap517FKrms/YSu7aQCuDbJ9x2Zo+3w==
X-Received: by 2002:ac8:7289:: with SMTP id v9mr7378749qto.139.1571810039904;
        Tue, 22 Oct 2019 22:53:59 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id c8sm7478656qkk.46.2019.10.22.22.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:53:58 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH 1/1] staging: exfat: Update MAINTAINERS file
Date:   Wed, 23 Oct 2019 01:53:53 -0400
Message-Id: <20191023055353.695275-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a L: tag so get_maintainers.pl output includes the linux-fsdevel list

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d09efe69508..1884350000ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6186,6 +6186,7 @@ F:	include/uapi/linux/mii.h
 
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
+L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/exfat/
 
-- 
2.23.0

