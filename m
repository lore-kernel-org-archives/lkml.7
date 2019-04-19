Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B0C282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A0217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555714468;
	bh=IzduzcZ48b0pyV7kevrmzwUYJt3IAcMhd+CyazgAt8U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PAMILXwmS46iLsCQmjWuolcOPRFuF8KFENtOj9X8Do0Woa8+GVhR/jXsXiUlsJDNa
	 ag6utZqHpRBiZT6MPsOsHA3lOh//lmelyFHM9BisB4bGniSz3z1fNvaAsR6GeShFQ1
	 Gbfbpn8wD3nKJnKyGSdj19GLK99q7fXG2bxQHTZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfDSWy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:54:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfDSWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fieiSTuDt11pJGq7xpXK91Dsnm8q+eSBj5kKlOZTvis=; b=tC2Ifw5NWdPrULHsbVJdxa9N+
        cxDx77PXr9rB/wQUzGudN4N9p6X/oCEE8SX+CbeN0ZB9kR1rhu7OU8qApp4SqtrMv0GyyED68wU+z
        qXU9+WScsxygyIUTTmuQopBpoOlPne0l12iy1LbezfD6iLWcqJwwSMBe8gKvw1s7XLIHs6LoecWoT
        HqAXc3IVQjZrnoolLAhJJiFlSpR3s+KfVSqQ6vID6C5xLoz4WKfJguJ83Qd+gb30v9MNCT4f6rez+
        y4Sdm07rM4dc15QtDZ3KqKTRD/KT1MSISVz3Ls2AVMUt6Fp4b6x6QVlysToOZQ6sqm+HdNSaUwpGz
        lvw6g6YfA==;
Received: from 177.18.24.91.dynamic.adsl.gvt.net.br ([177.18.24.91] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHQnJ-0002uG-RZ; Fri, 19 Apr 2019 10:30:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hHQnG-0000D6-0o; Fri, 19 Apr 2019 07:30:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 1/2] docs: doc-guide: remove the extension from .rst files
Date:   Fri, 19 Apr 2019 07:30:51 -0300
Message-Id: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On almost all places, we're including ReST files without the
extension.

Let's remove the extension here as well, in order to use just
one standard.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/doc-guide/index.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
index a7f95d7d3a63..603f3ff55d5a 100644
--- a/Documentation/doc-guide/index.rst
+++ b/Documentation/doc-guide/index.rst
@@ -7,9 +7,9 @@ How to write kernel documentation
 .. toctree::
    :maxdepth: 1
 
-   sphinx.rst
-   kernel-doc.rst
-   parse-headers.rst
+   sphinx
+   kernel-doc
+   parse-headers
 
 .. only::  subproject and html
 
-- 
2.20.1

