Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCTPMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:12:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:59405 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCTPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:12:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 08:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="154096388"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2019 08:12:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] docs: Explicitly state ordering requirements for Co-developed-by
Date:   Wed, 20 Mar 2019 08:11:40 -0700
Message-Id: <20190320151140.32432-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Thomas' yet-to-be-merged "tip tree handbook"[1], Co-developed-by and
Signed-off-by must be paired together, i.e. the co-authors' SOB mustn't
be scattered willy-nilly, and the author's SOB must be the first SOB
*after* the last Co-developed-by/Signed-off-by pair.  Provide an example
to eliminate any ambiguity.

[1] http://lkml.kernel.org/r/20181107171149.165693799@linutronix.de

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 Documentation/process/submitting-patches.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be7d1829c3af..f4b5c4850601 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -547,8 +547,13 @@ have been included in the discussion.
 
 A Co-developed-by: states that the patch was also created by another developer
 along with the original author.  This is useful at times when multiple people
-work on a single patch.  Note, this person also needs to have a Signed-off-by:
-line in the patch as well.
+work on a single patch.  Note, Co-developed-by: must be accompanied by a
+Signed-off-by: of the co-author(s).  All Co-developed-by:/Signed-off-by: pairs
+must precede the Signed-off-by: of the original author.
+
+	Co-developed-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: Original Author <original@author.example.org>
 
 
 13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
-- 
2.21.0

