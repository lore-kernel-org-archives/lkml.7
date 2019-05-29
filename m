Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9379CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D4E2432B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172291;
	bh=eUx03v/aYzkOK9/D09Fm/UVUL4CxTu7X4hhXaRzcpWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZPu8I4Tj04J3glXalUS85+BBiBUmQHTYC/Ss1vhi/ZrPaekQwMJifm/mEpTVuEpsC
	 4oZQf4dhJZMfEd5heJVRxfUSz1Eku51vDml7AMAGkAP6khz6jfeh1ATuPTzjW/7Oy/
	 sCPoKKAk+4L/uVMRomr8MlZ2eL2+dfQYKUp6Uev0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE2XYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iWmtdum/3OlU3YMeBrGKUhK75svN3rPXtelxifQf/4g=; b=jWWuboYmibtQ3LapHJdJSEVZhS
        jsSJ4jZtQn1aheMcDeKsImuLc7xVk8HAJLbN4R6U2deJdB2jajIV0Bqu4F/oBVoy8FgO+ny/6YUVL
        jUe+JlcGolCt0lpWF91TlqKGPyvqNTFk/S0Dp08WwZ8onKl2p/kty8qVtcAMSKUro5s+elTHUloaD
        L/S2TG7G8XXrw8n15RFPXET+kwnHG9c87PBkIOIzwXFNjgA247btKsr5Uwbtoo9JBW6dVUmihpLTC
        MAbPvI+N64nWQKQJj9RN8NWqZFUbJXXfj6pH4Jg8LhnMOYP9FyQfau17fFGA+UP3hyhfiAUQ3ILHH
        3/UrWfuQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Ri-4T; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xg-SM; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 15/22] docs: it: license-rules.rst: get rid of warnings
Date:   Wed, 29 May 2019 20:23:46 -0300
Message-Id: <d4cbc22108a75339d1c1e18cbc6b6463e93ea782.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
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
index f058e06996dc..06abeb7dd307 100644
--- a/Documentation/translations/it_IT/process/license-rules.rst
+++ b/Documentation/translations/it_IT/process/license-rules.rst
@@ -303,7 +303,7 @@ essere categorizzate in:
      LICENSES/dual
 
    I file in questa cartella contengono il testo completo della rispettiva
-   licenza e i suoi `Metatags`_.  I nomi dei file sono identici agli
+   licenza e i suoi `Metatags`.  I nomi dei file sono identici agli
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

