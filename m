Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78936C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B912084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF0N7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:59:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:8946 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0N7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:59:50 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id 3A85E5FFA1;
        Thu, 27 Jun 2019 15:59:48 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.89)
        (envelope-from <steve@sk2.org>)
        id 1hgUwF-0000yt-9u; Thu, 27 Jun 2019 15:59:47 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: format kernel-parameters -- as code
Date:   Thu, 27 Jun 2019 15:59:38 +0200
Message-Id: <20190627135938.3722-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ReStructuredText formatting results in "--", used to
indicate the end of the kernel command-line parameters, appearing as
an en-dash instead of two hyphens; this patch formats them as code,
"``--``", as done elsewhere in the documentation.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/kernel-parameters.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 0124980dca2d..b8d479b76648 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -9,11 +9,11 @@ and sorted into English Dictionary order (defined as ignoring all
 punctuation and sorting digits before letters in a case insensitive
 manner), and with descriptions where known.
 
-The kernel parses parameters from the kernel command line up to "--";
+The kernel parses parameters from the kernel command line up to "``--``";
 if it doesn't recognize a parameter and it doesn't contain a '.', the
 parameter gets passed to init: parameters with '=' go into init's
 environment, others are passed as command line arguments to init.
-Everything after "--" is passed as an argument to init.
+Everything after "``--``" is passed as an argument to init.
 
 Module parameters can be specified in two ways: via the kernel command
 line with a module name prefix, or via modprobe, e.g.::
-- 
2.11.0

