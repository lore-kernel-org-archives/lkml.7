Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768182086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392657AbfITPJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:09:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:11659 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfITPJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:09:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 08:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="194715589"
Received: from eergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.12])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2019 08:08:59 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] keys: Add Jarkko Sakkinen as co-maintainer
Date:   Fri, 20 Sep 2019 18:08:12 +0300
Message-Id: <20190920150826.18847-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address a major procedural concern on Linus's part the keyrings needs
a co-maintainer.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c76be7aaaf74..4e8ff0af9580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8945,6 +8945,7 @@ F:	include/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
-- 
2.20.1

