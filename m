Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420CC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3EE26763
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559297802;
	bh=7WcP7geRnCdillAQ5KdZSxTQZjeTSwXA+zJ2pR9Vmew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QOZjvtrLrqBKALr4qr2Yt3lkxapS41MOHEvayiCUulZUlfplsRU1RCd6reV9c1DB0
	 GL/Nlcnj/dUznQR29LrZIVt7dtj7nMh7JI9ht9oycGBSCCnIky+jgArLzSJQqv5v9b
	 f6aquriUUxDE6uJCoMYvSy5dzQxEHZ+gSIAk8Hmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaKQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:16:41 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E5C24B7D;
        Fri, 31 May 2019 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559297800;
        bh=7WcP7geRnCdillAQ5KdZSxTQZjeTSwXA+zJ2pR9Vmew=;
        h=From:To:Cc:Subject:Date:From;
        b=A7a7vIvf/+gzll8Xx18yAaIBbUUAgYxWuegrvHa7Zgs22w00QHcMmLSIK8FfCxCjc
         UmJgWKGHmQQZlprtrRYoPeAIWgV2sdRvabvd8CVmHSJE3NBuLzJdfyR53REErd/u6v
         nBDjNmVLEmUiQ4CfZO+9cRPkbLgIBhW6PgiuMnR8=
From:   guoren@kernel.org
To:     arnd@arndb.de, torvalds@linux-foundation.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] MAINTAINERS: Add mailing list for csky architecture
Date:   Fri, 31 May 2019 18:16:10 +0800
Message-Id: <1559297770-11633-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add the newly created linux-csky@vger.kernel.org mailing list for patch
reviews and discussions.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..b5fadcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3474,6 +3474,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.7.4

