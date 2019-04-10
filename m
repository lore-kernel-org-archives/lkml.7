Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11069C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA6F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890229;
	bh=cgN+dODAOaN6LyHGlZJN5JU2zOdcLCbzLozHtcJzXs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sSerVmg4rRtUPHBiVKep+uRZdLim022//EIxppF+xKQeD+4VdwGUeqn7hCkKDm6BN
	 ptfFmc4Onh/hTkTP41vqI+RQfv6QjSWQ8A/A5lBnc9/hUX779sH7XTLxphuanAFrwA
	 VNMYMRoyF8NFDvCvhZZwA7OxZD2EFWZJyUMA+c7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfDJJ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDJJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2Sj1gak9r1pUPmZa4YjvqHe4h1HixwMeGF5Pmb63syE=; b=gXI3KsbEakq5h4FW/cyXBBXJ5n
        YmRMJYRAEg68bElqemBk6RgcivvFwCLC3x4oTHGLnwuNIBREs0m6SrbuvUdr/0zygVSGyphXcZOVj
        qHWCUlj7FKqtYaaf3LOJtzpPDnZ/rSPXlMZb/LzjIIYd8RsYHGGAYUJy/BnGf4XcmzcQdcUjxreB4
        CFujYNOB4bXAVomiwtsmM81HkgqYb4bzW9mIwNLfDeY1Nqd4P8rwsLVRaxfchLWiHJvv8idPuHR3E
        KydI9nfci222+cNSCsWW/xj9QwLEzALmPph/fQjXO9+2kuj/AcdjW1c6FiBR6pafOceQSV4I7sIMA
        EMmZuAaA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9y9-0003Co-6r; Wed, 10 Apr 2019 09:56:37 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000oD-Qd; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/8] docs: unaligned-memory-access.txt: use a lowercase title
Date:   Wed, 10 Apr 2019 06:56:24 -0300
Message-Id: <879edf648733097be5233a94899eea8d1d80f7ad.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all other titles at the documentation, use lower case
for its title.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/unaligned-memory-access.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/unaligned-memory-access.txt
index 51b4ff031586..1ee82419d8aa 100644
--- a/Documentation/unaligned-memory-access.txt
+++ b/Documentation/unaligned-memory-access.txt
@@ -1,5 +1,5 @@
 =========================
-UNALIGNED MEMORY ACCESSES
+Unaligned Memory Accesses
 =========================
 
 :Author: Daniel Drake <dsd@gentoo.org>,
-- 
2.20.1

