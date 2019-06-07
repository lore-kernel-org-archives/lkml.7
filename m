Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEACC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933693;
	bh=XBp6kiCjeJUuOZ+AjtLj/IpKE1BRwUsQERgJv1dhVSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOOX4njoknxhgz7tKhXHU6ulZQnkjT1Y3oWZMJu8nZJNt43F8tc4OA+mAHeL4k21v
	 XHFmeDaxcUNX76B+5xYCdRrJnADY6d8+EjHWW+IElGCyujc+SRr8HwGyvE7uldD4Wc
	 OD7JlT4ub3TpMrfUIDKDePU9zzUklqB1pBHx/IW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfFGSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oE+GNlmDu8q5Yz9TSmplcEGH+jqeK1fLcabYCON6QNs=; b=ahr20MSu+PF2orAGaUAkAtfEer
        M8kNNGl5djhUIHXVnl73B/q9YO6j6S2/TW6pImjtB6fbC72TV69OEITJ6Aslwk88uCytB5MDlGDgH
        nv8+isLkaThIy8nxbW2sG2YgE0yV/f+dWBQ3hTAoKmoXNkJnAyDxP0kKqUYfv6qHXjNmbAk2ncsJJ
        SB8nxz5cqpeUxt3BeVs+GZG82VXAeFcw7JOmhFd1OYbbfl5YDKJ89ol5n7acMrfkYePGsAZXo85N6
        fSK/1qk3Byf2kExTa3AnpPo8fJLC7wnvu9FgM10WH9rC5CkZj9UiPdisQ4xWsCktzA8JrOZseWzt9
        3eyI6xiw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sf-Kt; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Ey-E3; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v3 09/20] docs: it: license-rules.rst: get rid of warnings
Date:   Fri,  7 Jun 2019 15:54:25 -0300
Message-Id: <f05516b6e91d312c6ea87134ffa836d1f574e6d1.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
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
Reviewed-by: Federico Vaga <federico.vaga@vaga.pv.it>
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

