Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14806C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2F020872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jaFq6San"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfERIwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:52:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:52:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8pp5Q1732403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:51:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8pp5Q1732403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169512;
        bh=xwA+5eOFpsEd9JJyqQA7UkKcbj+nBkadPUdDXDLiHPY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=jaFq6SanGo+wxdjwAeGP+5YUKMwZqaUN/wnmnLNFX0IL8YaCMo7v070F5DbRZqPZQ
         tCAH48zmeWC0vrExr+PWWU5zB0mI1R2Ej3yacS6bbhRZuKHr6FyPmt2wtcvTlkyXRu
         TRpAgDMnK9Iis1gQmzXDUc8xcjcU9W+rmqv5nLA5RaPFZzPeL33HgqRrfm2/2Fh6W/
         42r4FUwY0jatJ0IUtTO0DBQ6GSKioq3zjEIZM76x/gfhuqGcRZEWycUq+FWxso1pn5
         q+0/JUE8yH1uJbfUSxfDF/3QvvNOk0ssjGF+6gL3+aq9nWcgBqDHJ82Em4rhWCHJ6U
         3WH84Shu2Sm1g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8pokX1732400;
        Sat, 18 May 2019 01:51:50 -0700
Date:   Sat, 18 May 2019 01:51:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9re6bd7eh9epi3koslkv3ocn@git.kernel.org>
Cc:     gustavo.pimentel@synopsys.com, acme@redhat.com, tglx@linutronix.de,
        lorenzo.pieralisi@arm.com, namhyung@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
          hpa@zytor.com, kishon@ti.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, gustavo.pimentel@synopsys.com,
          tglx@linutronix.de, lorenzo.pieralisi@arm.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools pci: Do not delete pcitest.sh in 'make clean'
Git-Commit-ID: c9a7078750531c189c04ddd184c4367a5cb77780
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c9a7078750531c189c04ddd184c4367a5cb77780
Gitweb:     https://git.kernel.org/tip/c9a7078750531c189c04ddd184c4367a5cb77780
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 13:53:20 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

tools pci: Do not delete pcitest.sh in 'make clean'

When running 'make -C tools clean' I noticed that a revision controlled
file was being deleted:

  $ git diff
  diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
  deleted file mode 100644
  index 75ed48ff2990..000000000000
  --- a/tools/pci/pcitest.sh
  +++ /dev/null
  @@ -1,72 +0,0 @@
  -#!/bin/sh
  -# SPDX-License-Identifier: GPL-2.0
  -
  -echo "BAR tests"
  -echo
  <SNIP>

So I changed the make variables to fix that, testing it should produce
the same intended result while not deleting revision controlled files.

  $ make O=/tmp/build/pci -C tools/pci install
  make: Entering directory '/home/acme/git/perf/tools/pci'
  make -f /home/acme/git/perf/tools/build/Makefile.build dir=. obj=pcitest
  install -d -m 755 /usr/bin;		\
  for program in /tmp/build/pci/pcitest pcitest.sh; do	\
  	install $program /usr/bin;	\
  done
  install: cannot change permissions of ‘/usr/bin’: Operation not permitted
  install: cannot create regular file '/usr/bin/pcitest': Permission denied
  install: cannot create regular file '/usr/bin/pcitest.sh': Permission denied
  make: *** [Makefile:46: install] Error 1
  make: Leaving directory '/home/acme/git/perf/tools/pci'
  $ ls -la /tmp/build/pci/pcitest
  -rwxrwxr-x. 1 acme acme 27152 May 13 13:52 /tmp/build/pci/pcitest
  $ /tmp/build/pci/pcitest
  can't open PCI Endpoint Test device: No such file or directory
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1ce78ce09430 ("tools: PCI: Change pcitest compiling process")
Link: https://lkml.kernel.org/n/tip-9re6bd7eh9epi3koslkv3ocn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/pci/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/pci/Makefile b/tools/pci/Makefile
index 46e4c2f318c9..f64da817bc03 100644
--- a/tools/pci/Makefile
+++ b/tools/pci/Makefile
@@ -14,7 +14,7 @@ MAKEFLAGS += -r
 
 CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
-ALL_TARGETS := pcitest pcitest.sh
+ALL_TARGETS := pcitest
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -44,7 +44,7 @@ clean:
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS); do		\
+	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
 		install $$program $(DESTDIR)$(bindir);	\
 	done
 
