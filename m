Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C679C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE79521479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392128AbfIJOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:32:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:5499 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbfIJOcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:32:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 07:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="196566788"
Received: from agreppma-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.7])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2019 07:32:47 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
Date:   Tue, 10 Sep 2019 15:32:16 +0100
Message-Id: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jarkko Sakkinen as co-maintainer of KEYS/KEYRINGS and add
git://git.infradead.org/users/jjs/linux-tpmdd.git as the GIT repository
for KEYS-TRUSTED.

Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 108ea925a5d9..aa7cedd671d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8937,6 +8937,7 @@ M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
+T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
 S:	Supported
 F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/trusted-type.h
@@ -8945,6 +8946,7 @@ F:	security/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
-- 
2.20.1

