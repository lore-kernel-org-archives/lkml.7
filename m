Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A1C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8AA21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891299;
	bh=ZSd3kZosps3w+y5xT/+9xL1EL1aI/jrzlVJptq/Tzi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vktBeBMBBh1lCdYuh0wdbgq5biMGWjj4mKPRxuqsEIYoWDNULLe5K2sJguysL66dM
	 b0763RiVFMogQOCxRPi6XrACnTxWE2hE+H33si2dlOKX2oqWA5MXtEsP2bbZLg4i2V
	 f67swDCJmpHhapBmMNIGkHJc7vfLtGeSLGzoTBqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfFRUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFRUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8Y1nlnSVVHDrFk8myKIM30kznMDor9jOwj/L8T5CzXg=; b=QIjEpoeSOGdiCCPfo4Kl553GJA
        s065+YLwVkDvnVkhUg28XcTtdwrjhb1WfwvsZ5AOHIpgZTx0XRVbnFnz77vtP9uwzF2rSsXkwRkNG
        fQnwb2qEmrroho5gqklVKhOCjNfjvtEtEJ3YJNNGd2J93nz55WsjVvA0sjFtO/CbCE+H2t35ZVNqe
        BtTEX+eqboJlHFJ2cdybspQ+1Gfaeo6ZEgq+zDo5XZ6xlF6cUb5lwYxyV3kdjy5hOEIzJiWwlUyoM
        clNGIOuR+M8efrg5++kUGJY/7qb3f5rEpJ7ZRXtcuphyVXrdxu61pDXqMBJVQdMfEdZTX8gGmcw6w
        nO/2U76w==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL78-0008TI-1B; Tue, 18 Jun 2019 20:53:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL70-0001zt-2o; Tue, 18 Jun 2019 17:53:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 16/29] docs: rbtree.txt: fix Sphinx build warnings
Date:   Tue, 18 Jun 2019 17:53:34 -0300
Message-Id: <f5c25942548585e9765ab6681b40832243ed7d46.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ths file is already at ReST format. Yet, some recent changes
made it to produce a few warnings when building it with
Sphinx.

Those are trivially fixed by marking some literal blocks.

Fix them before adding it to the docs building system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/rbtree.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index c42a21b99046..523d54b60087 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -204,21 +204,21 @@ potentially expensive tree iterations. This is done at negligible runtime
 overhead for maintanence; albeit larger memory footprint.
 
 Similar to the rb_root structure, cached rbtrees are initialized to be
-empty via:
+empty via::
 
   struct rb_root_cached mytree = RB_ROOT_CACHED;
 
 Cached rbtree is simply a regular rb_root with an extra pointer to cache the
 leftmost node. This allows rb_root_cached to exist wherever rb_root does,
 which permits augmented trees to be supported as well as only a few extra
-interfaces:
+interfaces::
 
   struct rb_node *rb_first_cached(struct rb_root_cached *tree);
   void rb_insert_color_cached(struct rb_node *, struct rb_root_cached *, bool);
   void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
 
 Both insert and erase calls have their respective counterpart of augmented
-trees:
+trees::
 
   void rb_insert_augmented_cached(struct rb_node *node, struct rb_root_cached *,
 				  bool, struct rb_augment_callbacks *);
-- 
2.21.0

