Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E149C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300212067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfLLPNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:13:18 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:28432 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfLLPNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:13:17 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id BF56F744B5;
        Thu, 12 Dec 2019 15:13:16 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47YckN3fvrz3H3l;
        Thu, 12 Dec 2019 15:13:16 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 765A3FD19; Thu, 12 Dec 2019 15:13:16 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ed Maste <emaste@freebsd.org>
Subject: [PATCH] perf tools: correct license on jsmn json parser
Date:   Thu, 12 Dec 2019 15:12:44 +0000
Message-Id: <20191212151244.26324-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

These files are part of the jsmn json parser, introduced in 867a979a83.
Correct the SPDX tag to indicate that they are under the MIT license.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 tools/perf/pmu-events/jsmn.h | 2 +-
 tools/perf/pmu-events/json.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jsmn.h b/tools/perf/pmu-events/jsmn.h
index c7b0f6ea2a31..1bdfd55fff30 100644
--- a/tools/perf/pmu-events/jsmn.h
+++ b/tools/perf/pmu-events/jsmn.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 #ifndef __JSMN_H_
 #define __JSMN_H_
 
diff --git a/tools/perf/pmu-events/json.h b/tools/perf/pmu-events/json.h
index fbcd5a0590ad..7cb29fac8c31 100644
--- a/tools/perf/pmu-events/json.h
+++ b/tools/perf/pmu-events/json.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 #ifndef JSON_H
 #define JSON_H 1
 
-- 
2.24.0

