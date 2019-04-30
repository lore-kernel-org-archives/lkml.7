Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EBE21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TF2lfkTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfD3KwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfD3KwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dC/qP4NdN6lQuDcg0MFhcntTmuZFwV41wwE9EhdfDJ4=; b=TF2lfkTGEd28tPwvqNK7+O9SXc
        UGDUGWkYy9fJUhMA/ziVW9Oq5vVE2m6z3B7k3+s+Esotspjht7WD+2yCT+vIuK3H0uTppojeJh9zy
        6q9stFUf0bF8kK54t/ZGWPwM54ar/xbSQS0e5OSj6i3YNndzYfvFP0JDS9nAWjTGULYtWw8tKfMsS
        w+RvDu/Oi4wJqPPdZDoerGWO9GN1Ak1ZQ6VPqRNA6a0GqY9VDhuCACMMNlzABYws13TXar+5I7N5r
        3HPgkJhBZIHBEw7uheHTfqvsXZa7JtMCozlRcYvqp4gRffEKBhI3GXNZTcESlxZ0NsjtzfdzgGmoP
        l3NUiwaw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQMs-0007E8-99; Tue, 30 Apr 2019 10:52:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] docs: Don't reference the ZLib license in license-rules.rst
Date:   Tue, 30 Apr 2019 06:51:28 -0400
Message-Id: <20190430105130.24500-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105130.24500-1-hch@lst.de>
References: <20190430105130.24500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never had a file called LICENSES/other/ZLib in the tree, so don't
reference it.  Instead mention the GPL v1 as an (bad) example.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/process/license-rules.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 6b09033a8e9e..ade495fe6811 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -255,9 +255,9 @@ kernel, can be broken down into:
    Contains the Internet Systems Consortium license text and the required
    metatags::
 
-      LICENSES/other/ZLib
+      LICENSES/other/GPL-1.0
 
-   Contains the ZLIB license text and the required metatags.
+   Contains the GPL version 1 license text and the required metatags.
 
    Metatags:
 
-- 
2.20.1

