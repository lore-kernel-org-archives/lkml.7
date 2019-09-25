Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72504C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1432146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437200AbfIYObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437147AbfIYObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D35B3C928;
        Wed, 25 Sep 2019 14:31:20 +0000 (UTC)
Received: from builder (ovpn-121-117.rdu2.redhat.com [10.10.121.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46D035C21F;
        Wed, 25 Sep 2019 14:31:20 +0000 (UTC)
Received: from builder.jcline.org.com (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by builder (Postfix) with ESMTPS id 50B2EEA72E7;
        Wed, 25 Sep 2019 14:31:19 +0000 (UTC)
From:   Jeremy Cline <jcline@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] docs: kmemleak: DEBUG_KMEMLEAK_EARLY_LOG_SIZE changed names
Date:   Wed, 25 Sep 2019 14:31:14 +0000
Message-Id: <20190925143114.19698-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 25 Sep 2019 14:31:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5665868183f ("mm: kmemleak: use the memory pool for early
allocations") renamed CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE to
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE. Update the documentation reference
to reflect that.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 Documentation/dev-tools/kmemleak.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 3621cd5e1eef..3a289e8a1d12 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -69,7 +69,7 @@ the kernel command line.
 
 Memory may be allocated or freed before kmemleak is initialised and
 these actions are stored in an early log buffer. The size of this buffer
-is configured via the CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE option.
+is configured via the CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE option.
 
 If CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF are enabled, the kmemleak is
 disabled by default. Passing ``kmemleak=on`` on the kernel command
-- 
2.21.0

