Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7670C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1917205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055214;
	bh=LoOKtAgepXKzWcYBQN33AmbiFaYTUFQBsBgFCyk3CbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FYxm1FJeYcr/5bI0qSZYl5hyeKkduykfS0ZH1cKSCtO/b/kTbKSgou6YwQUukbWK/
	 +3dwAo1huZ7w8KijSypPyp1ZG92TvBP/u8gCfhLsYNkWgQKcVqzCVuzWqtfIQICINN
	 1TLzt6+E9LRhZLJiXfhmJIu/M1pYvELGyc0eFNpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfGBIHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfGBIHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:07:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09A2206A2;
        Tue,  2 Jul 2019 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054832;
        bh=LoOKtAgepXKzWcYBQN33AmbiFaYTUFQBsBgFCyk3CbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyJqFeMD66JVj1BEPbpuz8iMaoPZOqB7UHrIbRC7pP8xDTlQk2iG8gxXVIgzgoW3m
         bUOxlVHpvqHaFzQPQkw89qfH8BCMV9aYdD7c/KD0X+q2MoXyeTlQRyMd/LbMAlj0b2
         N80SqAxABiKNFFMcVG/aghOM/xRxiKw/vQcOFJ5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/72] net/9p: include trans_common.h to fix missing prototype warning.
Date:   Tue,  2 Jul 2019 10:01:22 +0200
Message-Id: <20190702080125.769419227@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 52ad259eaac0454c1ac7123e7148cf8d6e6f5301 ]

This silences -Wmissing-prototypes when defining p9_release_pages.

Link: http://lkml.kernel.org/r/b1c4df8f21689b10d451c28fe38e860722d20e71.1542089696.git.dato@net.com.org.es
Signed-off-by: Adeodato Simó <dato@net.com.org.es>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index b718db2085b2..3dff68f05fb9 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -14,6 +14,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
+#include "trans_common.h"
 
 /**
  *  p9_release_pages - Release pages after the transaction.
-- 
2.20.1



