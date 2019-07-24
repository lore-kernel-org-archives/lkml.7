Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4582C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80121849
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbfGXUUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbfGXTrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:47:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D38521873;
        Wed, 24 Jul 2019 19:47:13 +0000 (UTC)
Date:   Wed, 24 Jul 2019 15:47:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] ktest: Fix some typos in config-bisect.pl
Message-ID: <20190724154711.2698f244@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This contains only simple spelling fixes.

Ktest has been working well for me, so I'm doing this push now as I do
not expect to have ktest updates in the near future and do not want
this change to be forgotten.


Please pull the latest ktest-v5.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.3

Tag SHA1: 2e337a5fb7f2de16bfee9be63b3cf259dcb847e4
Head SHA1: aecea57f84b0586b62c010bea946468d77f6bf0f


Masanari Iida (1):
      ktest: Fix some typos in config-bisect.pl

----
 tools/testing/ktest/config-bisect.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit aecea57f84b0586b62c010bea946468d77f6bf0f
Author: Masanari Iida <standby24x7@gmail.com>
Date:   Tue Jul 23 12:24:45 2019 +0900

    ktest: Fix some typos in config-bisect.pl
    
    This patch fixes some spelling typos in config-bisect.pl
    
    Link: http://lkml.kernel.org/r/20190723032445.14220-1-standby24x7@gmail.com
    
    Acked-by: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Masanari Iida <standby24x7@gmail.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
index 72525426654b..6fd864935319 100755
--- a/tools/testing/ktest/config-bisect.pl
+++ b/tools/testing/ktest/config-bisect.pl
@@ -663,7 +663,7 @@ while ($#ARGV >= 0) {
     }
 
     else {
-	die "Unknow option $opt\n";
+	die "Unknown option $opt\n";
     }
 }
 
@@ -732,7 +732,7 @@ if ($start) {
 	}
     }
     run_command "cp $good_start $good" or die "failed to copy to $good\n";
-    run_command "cp $bad_start $bad" or die "faield to copy to $bad\n";
+    run_command "cp $bad_start $bad" or die "failed to copy to $bad\n";
 } else {
     if ( ! -f $good ) {
 	die "Can not find file $good\n";
