Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D35C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B32F2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558323040;
	bh=7WcP7geRnCdillAQ5KdZSxTQZjeTSwXA+zJ2pR9Vmew=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k32m/ahacjVO2+WI68xGV/unMH4qSaXEo78FBLDcJ2vsxj6Q+B8w5+C5xl3mFdBaR
	 d7IqsGHcnRM+3bqi0/Do33TlNkV3/yL+BFXW2lRUnnhvhrc9m2uwMMcHsIA6hH7vJX
	 fPzpNaXbZUC4LYcOjq1QQmKh3jDm86ZACfNv6P4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfETDaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfETDai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:30:38 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0782082C;
        Mon, 20 May 2019 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558323038;
        bh=7WcP7geRnCdillAQ5KdZSxTQZjeTSwXA+zJ2pR9Vmew=;
        h=From:To:Cc:Subject:Date:From;
        b=0SnIZywVbZH0hJ9oAjMlka3xsvHP3J8+a9gXL+4vuvCU7YFNCdD6AJARXUBxs6Wth
         jlmP5rfrLpC3tIBr3ZyHqNgAYovTx79RXKL6NYgdZy9bs4M2twuZZ6FC5BK66xiyuI
         lgdyRduxjfEfq4R80WTsFsckEHZhtqPydV8G9mEE=
From:   guoren@kernel.org
To:     ren_guo@c-sky.com, han_mao@c-sky.com, yibin_liu@c-sky.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arnd.de, linux-csky@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add mailing list for csky architecture
Date:   Mon, 20 May 2019 11:27:59 +0800
Message-Id: <1558322879-12358-1-git-send-email-guoren@kernel.org>
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

