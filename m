Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA25C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9231921479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891263;
	bh=6hWCXccZfaSsbUWzVC0OKlLah4pXQdi91y3PPQS4KMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=joqJBtv4R75iMtWr9C0HDma6MwTHQZQYSlFJkHVPpE1gBxIj0NLsL/cF2d8mhwMRd
	 rcOs3tNaw139Cz2yDKKVlMe/n6QhUIMxwxsfRXE3PQKColwsCKL0eqGZoFY/vZ5dYP
	 V+12WnoRE0gZYFpJVAAyJb5wbYNH7FeeSEwnvadc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfFRUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:54:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfFRUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kIG3TqTXNYXrXjWMuxoIyxE0UnlHCYqdcFqGb4s7JWQ=; b=u14KIP9UpsMsR6YHgFh1ndftdI
        BoHxMECTD8VdvGDeAbcOCBvyNXu/b6C0Jn22A4p/sQC9OuYB2bOaMNojYRD+aTPQ2JbcwN675jBZV
        F/rl4pU2gcnnvOAmAD7bUXpYsuLydPCC/oxh+m9vtT3ERPFOAxTwbrsSaEDE0n2R1eRjXvPKb1GWJ
        pSJt/1o9IiAWY+CPOeDGeX0tSPQHqEJP6A7G+Nzbxk692wGZ4jY9SFbLeZHnepvtOXMvsziqsQH9f
        ut7RK+8v+D7KoGNEy4VyTrNCikILAc7QuEEj53kWPcSsGzoDCKP+Wwj/gOTqWPY9++ExNxoYcdcIW
        p9P5HQZg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008RX-4y; Tue, 18 Jun 2019 20:53:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL6z-0001zA-Nh; Tue, 18 Jun 2019 17:53:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/29] docs: cma/debugfs.txt: convert docs to ReST and rename to *.rst
Date:   Tue, 18 Jun 2019 17:53:23 -0300
Message-Id: <286440d2a7e728c2f8488a278d6474146e71aeca.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs interface for CMA should be there together with other
mm-related documents.

Convert this small file to ReST and move it to its rightful place.

The conversion is actually quite simple: just add a title for the
document. In order to make it to look better for the audience,
also mark the "echo" command as a literal block.

While this is not part of any book, mark it as :orphan:,
in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/cma/{debugfs.txt => debugfs.rst} | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 rename Documentation/cma/{debugfs.txt => debugfs.rst} (91%)

diff --git a/Documentation/cma/debugfs.txt b/Documentation/cma/debugfs.rst
similarity index 91%
rename from Documentation/cma/debugfs.txt
rename to Documentation/cma/debugfs.rst
index 6cef20a8cedc..518fe401b5ee 100644
--- a/Documentation/cma/debugfs.txt
+++ b/Documentation/cma/debugfs.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+=====================
+CMA Debugfs Interface
+=====================
+
 The CMA debugfs interface is useful to retrieve basic information out of the
 different CMA areas and to test allocation/release in each of the areas.
 
@@ -12,7 +18,7 @@ The structure of the files created under that directory is as follows:
  - [RO] count: Amount of memory in the CMA area.
  - [RO] order_per_bit: Order of pages represented by one bit.
  - [RO] bitmap: The bitmap of page states in the zone.
- - [WO] alloc: Allocate N pages from that CMA area. For example:
+ - [WO] alloc: Allocate N pages from that CMA area. For example::
 
 	echo 5 > <debugfs>/cma/cma-2/alloc
 
-- 
2.21.0

