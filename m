Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4AC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA502473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559657924;
	bh=suZUmEBy/6cXEqBETPTHNDb7dJhuC2ouQI3VmX/mzh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYFdt13kTKBereJfdmWSL8ZybGwNIqULSCogojdyNX1yuenZWPTMBAOSvWLcZoCEU
	 SnRM6LgrWNbuJBTTDHxx8VfEqZ0w/kkDYfzXeQ2Q8vSY0QEJ6sR16GSX2Fzy6qzqyM
	 EtXR38rmEz+XQUnTdFuZsSTbCtpgBvTgWaMpmFFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfFDOSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:18:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfFDOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VCZG76F1HMdmo0ADdNu78x95s6CEjH1DNcxwfGs+eM8=; b=j+C0tMNDBGV57XYtGvw6OWyFUt
        /KaXEE9W6hLLDQCTQGh5NENbnqv1ytsTJh77tZhl2xPDruGUwtXCdEzD0WbWU/k6fq/V2+1Z1oogB
        BwRs4BimYm2JGWgj54GBbykBdkrzTtLycvzPTvKK4mrDfq0hfAcAmFHaxG92j2IvBIIDUdfDGJUhi
        8pkpQaHYQza5O4k/0LJl1Jh0apY26fDW28l7LlyqSsn2o0OzevOCdA79ldnGlP+LYwo6GdIJOj8SP
        xg9nt7ovDXMqAuq9iE/psPu2UhcG1hlBtUhXzDcLa9kngArVwjnx40rUciEZsKZ0J0BrCy6vdYaMz
        HXoP9SsA==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rl-UQ; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002lJ-PF; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v2 11/22] docs: it: license-rules.rst: get rid of warnings
Date:   Tue,  4 Jun 2019 11:17:45 -0300
Message-Id: <6a7cfac6d9a2f14475c8b9baef0f55e4996b9210.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a wrong identation on a code block, and it tries to use
a reference that was not defined at the Italian translation.

    Documentation/translations/it_IT/process/license-rules.rst:329: WARNING: Literal block expected; none found.
    Documentation/translations/it_IT/process/license-rules.rst:332: WARNING: Unexpected indentation.
    Documentation/translations/it_IT/process/license-rules.rst:339: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/translations/it_IT/process/license-rules.rst:341: WARNING: Unexpected indentation.
    Documentation/translations/it_IT/process/license-rules.rst:305: WARNING: Unknown target name: "metatags".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../it_IT/process/license-rules.rst           | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/translations/it_IT/process/license-rules.rst b/Documentation/translations/it_IT/process/license-rules.rst
index f058e06996dc..4cd87a3a7bf9 100644
--- a/Documentation/translations/it_IT/process/license-rules.rst
+++ b/Documentation/translations/it_IT/process/license-rules.rst
@@ -303,7 +303,7 @@ essere categorizzate in:
      LICENSES/dual
 
    I file in questa cartella contengono il testo completo della rispettiva
-   licenza e i suoi `Metatags`_.  I nomi dei file sono identici agli
+   licenza e i suoi `Metatag`_.  I nomi dei file sono identici agli
    identificatori di licenza SPDX che dovrebbero essere usati nei file
    sorgenti.
 
@@ -326,19 +326,19 @@ essere categorizzate in:
 
    Esempio del formato del file::
 
-   Valid-License-Identifier: MPL-1.1
-   SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
-   Usage-Guide:
-     Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used for
-     dual-licensed files where the other license is GPL2 compatible.
-     If you end up using this it MUST be used together with a GPL2 compatible
-     license using "OR".
-     To use the Mozilla Public License version 1.1 put the following SPDX
-     tag/value pair into a comment according to the placement guidelines in
-     the licensing rules documentation:
-   SPDX-License-Identifier: MPL-1.1
-   License-Text:
-     Full license text
+    Valid-License-Identifier: MPL-1.1
+    SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
+    Usage-Guide:
+      Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used for
+      dual-licensed files where the other license is GPL2 compatible.
+      If you end up using this it MUST be used together with a GPL2 compatible
+      license using "OR".
+      To use the Mozilla Public License version 1.1 put the following SPDX
+      tag/value pair into a comment according to the placement guidelines in
+      the licensing rules documentation:
+    SPDX-License-Identifier: MPL-1.1
+    License-Text:
+      Full license text
 
 |
 
-- 
2.21.0

