Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EE920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742761;
	bh=cgN+dODAOaN6LyHGlZJN5JU2zOdcLCbzLozHtcJzXs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/Q1qe/lNT8JuhZz0fBaLYDfyP0laNCYG0R5LwHVxxenorJoNMqKhDEPTpX6PixiA
	 HYX6zItpFasbXgTFKgd/FGH19Bzw8cBhuRtCXC14SoJXMf/v4RkUn9gZDIZxIHc6Uq
	 IPgMtV2EUvY8dK2j6BeOx24wtvmWJN7PPngH1qPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfDHQ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDHQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2Sj1gak9r1pUPmZa4YjvqHe4h1HixwMeGF5Pmb63syE=; b=H3ccAQiVbK2nadoftbPQcTI7Uj
        Ko3HSQwpCAQzSStYfyCuBbBdU7BHAJYcQDw3oRMJt60X3cPTd4RyM7e23lP7GcB0/lO2DlXx3/0Zk
        lHFmHbbVjmQLqA1O4PA61XInyz3SsENk75KvqFbV7iyJSOMn+KD9gxj7jFc8Ge0KmCUo1IDDGI0rD
        OOgoZpsJAy9TLVC5HD23J6VYc9Iem2jeao3LhFpw7fmXHdFe6Rl92+NCTzuVBzHWk+P6PCkXgRnOV
        2tMrh9DvX2ZEpB1PLhvlNJCwVl0gB8Ab61h0oSMqTq+NiBlWLiNAXXD0fWddphzBI6EhipicmGBxg
        jpCTVQ1w==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005St-7h; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nH-9B; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/10] docs: unaligned-memory-access.txt: use a lowercase title
Date:   Mon,  8 Apr 2019 13:58:21 -0300
Message-Id: <879edf648733097be5233a94899eea8d1d80f7ad.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
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

