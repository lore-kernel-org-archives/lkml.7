Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78CEC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6F82147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724509;
	bh=ZSd3kZosps3w+y5xT/+9xL1EL1aI/jrzlVJptq/Tzi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cl3h6wd5tX1FR0gDEehOBvMFH/m4hj7kj4WyjiW/9gHZfQOEUAtSjxXxN3acdq4B1
	 Y+C3NNOBAGMJWDPT8bYMoFeO/s3Nq5jNyqgjcghs4EMHZuEdG2tvOM4FHShg1hNd65
	 6zwlt3u9FljVb7wY6Za/8pOzdkE0jQmiY5G4rVsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF1MUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfF1MUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8Y1nlnSVVHDrFk8myKIM30kznMDor9jOwj/L8T5CzXg=; b=mQVt0huyebE1lq65E7XNuD65+4
        19eK/Gg9kMvNRQ+2JDZq2F9fsr9Hq4LDb1qIWY556XtlEdwsr8wEhMjJkur6sbGCUF8bZJ3crQ8KC
        2ecZJU+SCz+dprKyTZOiEyJICWUksgM2CfDrJ0NyCJf+oFfr6Lmr/Xn7mNMEXv2wOWKmyBo41Zord
        HB1AAgMtfJKv2jvXMTfHw1DQEkcQuw0/57zghg0Nmgw4DOW2nDSjDW5pToBzEtAB5HFetv4kX4cRJ
        WZYzCQ9SyLAvs6AHWaTv+AcdXKyi7aivatMsnejWp/yMpFx+4idT/ftv3vc6gOIv8OUt2F6IY0Qsj
        jSt3tQ+g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000A8-Fg; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00058P-Iq; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 20/43] docs: rbtree.txt: fix Sphinx build warnings
Date:   Fri, 28 Jun 2019 09:20:16 -0300
Message-Id: <be9755a5ff5ac3e4a58c3d822e399bd369aac309.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
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

