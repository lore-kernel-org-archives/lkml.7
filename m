Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7154CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105F206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfKMSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfKMSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:50:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C56206F3;
        Wed, 13 Nov 2019 18:50:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iUxio-0004UA-Q5; Wed, 13 Nov 2019 13:50:30 -0500
Message-Id: <20191113185030.687588433@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 13:49:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John 'Warthog9' Hawley" <warthog9@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>
Subject: [for-next][PATCH 1/2] ktest: Fix some typos in sample.conf
References: <20191113184958.730304611@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

This patch fixes some spelling typo in sample.conf

Link: http://lkml.kernel.org/r/20190930124925.20250-1-standby24x7@gmail.com

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/sample.conf | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index c3bc933d437b..10af34819642 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -10,7 +10,7 @@
 #
 
 # Options set in the beginning of the file are considered to be
-# default options. These options can be overriden by test specific
+# default options. These options can be overridden by test specific
 # options, with the following exceptions:
 #
 #  LOG_FILE
@@ -204,7 +204,7 @@
 #
 # This config file can also contain "config variables".
 # These are assigned with ":=" instead of the ktest option
-# assigment "=".
+# assignment "=".
 #
 # The difference between ktest options and config variables
 # is that config variables can be used multiple times,
@@ -263,7 +263,7 @@
 #### Using options in other options ####
 #
 # Options that are defined in the config file may also be used
-# by other options. All options are evaulated at time of
+# by other options. All options are evaluated at time of
 # use (except that config variables are evaluated at config
 # processing time).
 #
@@ -707,7 +707,7 @@
 
 # Line to define a successful boot up in console output.
 # This is what the line contains, not the entire line. If you need
-# the entire line to match, then use regural expression syntax like:
+# the entire line to match, then use regular expression syntax like:
 #  (do not add any quotes around it)
 #
 #  SUCCESS_LINE = ^MyBox Login:$
@@ -839,7 +839,7 @@
 # (ignored if POWEROFF_ON_SUCCESS is set)
 #REBOOT_ON_SUCCESS = 1
 
-# In case there are isses with rebooting, you can specify this
+# In case there are issues with rebooting, you can specify this
 # to always powercycle after this amount of time after calling
 # reboot.
 # Note, POWERCYCLE_AFTER_REBOOT = 0 does NOT disable it. It just
@@ -848,7 +848,7 @@
 # (default undefined)
 #POWERCYCLE_AFTER_REBOOT = 5
 
-# In case there's isses with halting, you can specify this
+# In case there's issues with halting, you can specify this
 # to always poweroff after this amount of time after calling
 # halt.
 # Note, POWEROFF_AFTER_HALT = 0 does NOT disable it. It just
@@ -972,7 +972,7 @@
 #
 #  PATCHCHECK_START is required and is the first patch to
 #   test (the SHA1 of the commit). You may also specify anything
-#   that git checkout allows (branch name, tage, HEAD~3).
+#   that git checkout allows (branch name, tag, HEAD~3).
 #
 #  PATCHCHECK_END is the last patch to check (default HEAD)
 #
@@ -994,7 +994,7 @@
 #     IGNORE_WARNINGS is set for the given commit's sha1
 #
 #   IGNORE_WARNINGS can be used to disable the failure of patchcheck
-#     on a particuler commit (SHA1). You can add more than one commit
+#     on a particular commit (SHA1). You can add more than one commit
 #     by adding a list of SHA1s that are space delimited.
 #
 #   If BUILD_NOCLEAN is set, then make mrproper will not be run on
@@ -1093,7 +1093,7 @@
 #   whatever reason. (Can't reboot, want to inspect each iteration)
 #   Doing a BISECT_MANUAL will have the test wait for you to
 #   tell it if the test passed or failed after each iteration.
-#   This is basicall the same as running git bisect yourself
+#   This is basically the same as running git bisect yourself
 #   but ktest will rebuild and install the kernel for you.
 #
 # BISECT_CHECK = 1 (optional, default 0)
@@ -1239,7 +1239,7 @@
 #
 # CONFIG_BISECT_EXEC (optional)
 #  The config bisect is a separate program that comes with ktest.pl.
-#  By befault, it will look for:
+#  By default, it will look for:
 #    `pwd`/config-bisect.pl # the location ktest.pl was executed from.
 #  If it does not find it there, it will look for:
 #    `dirname <ktest.pl>`/config-bisect.pl # The directory that holds ktest.pl
-- 
2.23.0


