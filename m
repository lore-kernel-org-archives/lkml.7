Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A65C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8123426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfH3QbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:31:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:63554 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfH3QbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:31:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 09:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="193381696"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2019 09:31:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Remove obsolete period from "ambiguous SHA1" query
Date:   Fri, 30 Aug 2019 09:31:03 -0700
Message-Id: <20190830163103.15914-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Git dropped the period from its "ambiguous SHA1" error message in commit
0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
circa 2016.  Drop the period from checkpatch's associated query so as to
match both the old and new error messages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..ef3642c53100 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -962,7 +962,7 @@ sub git_commit_info {
 
 	return ($id, $desc) if ($#lines < 0);
 
-	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
+	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
 # Maybe one day convert this block of bash into something that returns
 # all matching commit ids, but it's very slow...
 #
-- 
2.22.0

