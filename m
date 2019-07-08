Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D4BC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411C821537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599106;
	bh=+erWMCoHTiSsklg2eI6FKFJT38mbys5O4ZaxKE9Ogkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPm2CvuvQHxBt4uHXIoGVcVRFXCyHbxGCxv4PatqY3vKU+vDRvA38ArOyJhz2yHXC
	 MyW+T4hwv9NM3ke3TENU3Uvl2eGyEQQ2UqpsOj9E5hpLcQ579G3h5wdR5uVsS4JfLC
	 Fo1GA0neZfTbK142Slteruqxl8h1Ji/L0iOQbdw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfGHPSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733013AbfGHPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220812171F;
        Mon,  8 Jul 2019 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599100;
        bh=+erWMCoHTiSsklg2eI6FKFJT38mbys5O4ZaxKE9Ogkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCmMan01dj6MvjpE1U0aYQSzOxExGa8v/EF5mdK3u7wbbeJ3cFgPpzc6fvWi5q78k
         9Lxuy2GheRCO4JVgfjumejj1INQbfIC4U3VHTGesMkqrMwSsNegihh8tjUb6aoi0kc
         YOGk8GMbjnA0EkcpBEYkTrZFX2BEPFUxtlRb0oJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 35/73] net/9p: include trans_common.h to fix missing prototype warning.
Date:   Mon,  8 Jul 2019 17:12:45 +0200
Message-Id: <20190708150523.187158218@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
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
index 38aa6345bdfa..9c0c894b56f8 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -14,6 +14,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
+#include "trans_common.h"
 
 /**
  *  p9_release_req_pages - Release pages after the transaction.
-- 
2.20.1



