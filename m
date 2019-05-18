Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17111C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05FD20882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YgIYHyRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfERJew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:34:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:34:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9Yfw11742591
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:34:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9Yfw11742591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172082;
        bh=/Rn7r2gwntaBRy0qxmT5/kMQhfK3gdVVyzAAgb5ZAyk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YgIYHyREBztUjlgHMKtduEkta4ua0kjkZXuszYZvDH55JLvc57IaLRdsPWOuieCau
         lqBizSw0pRFrPO9lTydXQd961lMQOLLgBmWXz3bbaV0Hc8W0wLx1j5dYhbayMbpXdf
         TxQScpwQFoKfNwL6C32ZctzWhJdTssYP1dD/VDGSqteOEDuyJ1qfNEcwz39gyA/wkf
         zx3S7HDSPevRU5+DBUU6XyvZ6BDBzWY2kyFSzzD1OGb82GxbUJT9yLZU43w4c1zHy3
         Mfs0RCsspWrS/2PVooqlsTtwI9tka9m6Cbw0S/SYs5CoGQKOtGx/zQonmdDXdApoND
         hn2+gbyaqX45w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Ye8w1742584;
        Sat, 18 May 2019 02:34:40 -0700
Date:   Sat, 18 May 2019 02:34:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-6cf626563998d3f8770cc25146986810ee4a5969@git.kernel.org>
Cc:     acme@redhat.com, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        mingo@kernel.org, brueckner@linux.vnet.ibm.com, hpa@zytor.com,
        tmricht@linux.ibm.com, tglx@linutronix.de
Reply-To: acme@redhat.com, schwidefsky@de.ibm.com,
          linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
          mingo@kernel.org, brueckner@linux.vnet.ibm.com, hpa@zytor.com,
          tmricht@linux.ibm.com, tglx@linutronix.de
In-Reply-To: <20190513080220.91966-1-tmricht@linux.ibm.com>
References: <20190513080220.91966-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf docs: Add description for stderr
Git-Commit-ID: 6cf626563998d3f8770cc25146986810ee4a5969
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

Commit-ID:  6cf626563998d3f8770cc25146986810ee4a5969
Gitweb:     https://git.kernel.org/tip/6cf626563998d3f8770cc25146986810ee4a5969
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 13 May 2019 10:02:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:24 -0300

perf docs: Add description for stderr

'perf report' displays recorded data on the screen and emits warnings
and debug messages in the status line (last one on screen).

perf also supports the possibility to write all debug messages to stderr
(instead of writing them to the status line).

This is achieved with the following command:

  # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
  # ll /tmp/2
  -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
  #

The usage of variable stderr=1 is not documented, so add it to the perf
man page.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190513080220.91966-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 864e37597252..401f0ed67439 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -22,6 +22,8 @@ OPTIONS
 	  verbose          - general debug messages
 	  ordered-events   - ordered events object debug messages
 	  data-convert     - data convert command debug messages
+	  stderr           - write debug output (option -v) to stderr
+	                     in browser mode
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
