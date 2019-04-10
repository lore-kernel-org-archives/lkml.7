Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB42C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF1A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890240;
	bh=2gVsSC1nBl4XPpL9550+J9sNhpNGHN2cWmlTuEOHu1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDajxlLp/7uFC8K+tEIurykXpqObYD52bsGvivWYyfVGYNEJQcs+UdjjABzz8NuYw
	 Pp4txceNzOEXBw5nFlG9DHuX8G1Yh9CTMAavE0d5d4eMb3NHOHIAj12LY2kU7vibCO
	 E1Kuz7W2Q3UfYR14hJ+pg04YH6rIQhysJMlaAr2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfDJJ5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:57:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbfDJJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T0SBZllgHqVlHqCRx9ICKVMFMCBWkpJnm5qm1nU/vMM=; b=lwJg9bv/lSDkmJxxuj2e2SONE7
        R3swTIuGN4zSdBnGJ7cPsGboKLpSqwnRAGb3PUk4PBGtGk/sYE/IJWZRn+Py6WL+k+raAtWBA2kJ7
        h6lgCQWoSlqrpqeA3KNKDkFLSgC8+GHjCemA9sEPd0mCoepPUIDr1qjis7xIu9eNoAbmdmv00Lbpl
        GZ2UAWu8asgHYl0ZeEMGiZNZKbGzYiJJi+6XooaOjToW5JoGVjZODtuU1oKechnPlREb2VigJJ7gt
        bfDHZStOw8vc++U5q5ZK1D1QxREncsyDCKqXVORlgimKh3WkdbXkA4r/QRYKmP27VEE4PLPZclTRZ
        Snbx3Row==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9y9-0003Cp-7z; Wed, 10 Apr 2019 09:56:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000o5-P1; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/8] docs: clearing-warn-once.txt: add a title for this document
Date:   Wed, 10 Apr 2019 06:56:22 -0300
Message-Id: <eb6ebd1482dfa60b2eeb2f90f77eab695c5e89ef.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document misses a title. Add it, in order to follow
the documentation standard.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/clearing-warn-once.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/clearing-warn-once.txt b/Documentation/clearing-warn-once.txt
index 5b1f5d547be1..4aa938262d0e 100644
--- a/Documentation/clearing-warn-once.txt
+++ b/Documentation/clearing-warn-once.txt
@@ -1,3 +1,5 @@
+Clearing WARN_ONCE
+------------------
 
 WARN_ONCE / WARN_ON_ONCE only print a warning once.
 
-- 
2.20.1

