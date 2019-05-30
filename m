Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1EB2624C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559253583;
	bh=5qshIW5Gt3KAVKJzOXgOCt/l0/l0VeA73U46WzDaneQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E0w1rPKRozJwvVuMuZ/3hUFbA1+mRCrZ8bB7YevFOFuIu8bGoCSCvXEb1jPV50FU1
	 /85JygdwYpXcKhNS6ZHOVItR6mQzl5ShL2Ts2ESZmE2nJE6jA4aluOJ7Jyxf7VxNUB
	 Eq2rQ9/615JWUfD8mvo1zMjbXyGE09e5Mjw+tofI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE3V7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfE3V7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:59:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CD426242;
        Thu, 30 May 2019 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559253581;
        bh=5qshIW5Gt3KAVKJzOXgOCt/l0/l0VeA73U46WzDaneQ=;
        h=From:To:Cc:Subject:Date:From;
        b=n6sSxJzuf3xuFlAw42kcZMQtZwPqy4EA3EwSchHYq4dw9FZKzPMYsAdMQrpM/uCDL
         gy4f4NddeT1JGDWQgD1HuttweHMtIDWMxpBgFxGSbHCxaPvxAxYnRsSLwme2dWUJ+M
         IVWAu2z8T2PHmGT5Y5mBrf5sfnrn+wz14UHX9V54=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] scripts/sphinx-pre-install: fix "dependenties" typo
Date:   Thu, 30 May 2019 16:59:14 -0500
Message-Id: <20190530215914.67896-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typo ("dependenties" for "dependencies").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f6a5c0bae31e..78bcd29139b2 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -559,7 +559,7 @@ sub check_needs()
 	}
 	printf "\n";
 
-	print "All optional dependenties are met.\n" if (!$optional);
+	print "All optional dependencies are met.\n" if (!$optional);
 
 	if ($need == 1) {
 		die "Can't build as $need mandatory dependency is missing";
-- 
2.22.0.rc1.257.g3120a18244-goog

