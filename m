Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA7FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924D32075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="clnKNVWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfECFzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:55:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:55:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435tgkZ2618490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:55:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435tgkZ2618490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862942;
        bh=JsGUuPTHWqok5D84epQXxVpgdJ6s1Q3C0+7cOlzv3/Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=clnKNVWfpsAbfsWK7ug7+LpeQQ3B9J3vtGABRtK7hzjXHxMveQM3YelV4Qx1Qtzcd
         WQvl6yUrpuLQtSpE/WM4ouQ2D8Jeyb/DtuU0V0tgpjpO8Aq1+IS176yHrUOJX/4+Ad
         06TQh58v8XYXL3aZ213GMK1TmKi3CWz19kZve3HfwG19Cm1CwOC4SjbHgJ53XIkM0F
         +KmoKcgSqTQgBacCgVXV0KWY174L059dFT06WvjV+flTJz/BOZCU7guf7RnENRjkng
         KfBSuvuHGbQA0vTPFjpIVx1nhuxX383VlZZy3ABIM/kbr7U59PGFcLXC4Al9FalIGl
         UJyqIE98pgZ7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435tfm72618487;
        Thu, 2 May 2019 22:55:41 -0700
Date:   Thu, 2 May 2019 22:55:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-167e418fa0871c083e2c74508d73012abb01e6f7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, schwidefsky@de.ibm.com, mingo@kernel.org,
        acme@redhat.com, heiko.carstens@de.ibm.com,
        brueckner@linux.ibm.com, tmricht@linux.ibm.com
Reply-To: tmricht@linux.ibm.com, brueckner@linux.ibm.com,
          heiko.carstens@de.ibm.com, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, schwidefsky@de.ibm.com, tglx@linutronix.de,
          jolsa@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190423105303.61683-1-tmricht@linux.ibm.com>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Report OOM in status line in the GTK
 UI
Git-Commit-ID: 167e418fa0871c083e2c74508d73012abb01e6f7
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

Commit-ID:  167e418fa0871c083e2c74508d73012abb01e6f7
Gitweb:     https://git.kernel.org/tip/167e418fa0871c083e2c74508d73012abb01e6f7
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue, 23 Apr 2019 12:53:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf report: Report OOM in status line in the GTK UI

An -ENOMEM error is not reported in the GTK GUI.  Instead this error
message pops up on the screen:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1

	Processing events... [974K/3M]
	Error:failed to process sample

	0xf4198 [0x8]: failed to process type: 68

However when I use the same perf.data file with --stdio it works:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1 --stdio \
		| head -12

  # Total Lost Samples: 0
  #
  # Samples: 76K of event 'cycles'
  # Event count (approx.): 99056160000
  #
  # Overhead  Command          Shared Object      Symbol
  # ........  ...............  .................  .........
  #
     8.81%  find             [kernel.kallsyms]  [k] ftrace_likely_update
     8.74%  swapper          [kernel.kallsyms]  [k] ftrace_likely_update
     8.34%  sshd             [kernel.kallsyms]  [k] ftrace_likely_update
     2.19%  kworker/u512:1-  [kernel.kallsyms]  [k] ftrace_likely_update

The sample precentage is a bit low.....

The GUI always fails in the FINISHED_ROUND event (68) and does not
indicate the reason why.

When happened is the following. Perf report calls a lot of functions and
down deep when a FINISHED_ROUND event is processed, these functions are
called:

  perf_session__process_event()
  + perf_session__process_user_event()
    + process_finished_round()
      + ordered_events__flush()
        + __ordered_events__flush()
	  + do_flush()
	    + ordered_events__deliver_event()
	      + perf_session__deliver_event()
	        + machine__deliver_event()
	          + perf_evlist__deliver_event()
	            + process_sample_event()
	              + hist_entry_iter_add() --> only called in GUI case!!!
	                + hist_iter__report__callback()
	                  + symbol__inc_addr_sample()

	                    Now this functions runs out of memory and
			    returns -ENOMEM. This is reported all the way up
			    until function

perf_session__process_event() returns to its caller, where -ENOMEM is
changed to -EINVAL and processing stops:

 if ((skip = perf_session__process_event(session, event, head)) < 0) {
      pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
	     head, event->header.size, event->header.type);
      err = -EINVAL;
      goto out_err;
 }

This occurred in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

This patch indicates the root cause and displays it in the status line
of ther perf report GUI.

Output before (on GUI status line):

  0xf4198 [0x8]: failed to process type: 68

Output after:

  0xf4198 [0x8]: failed to process type: 68 [not enough memory]

Committer notes:

the 'skip' variable needs to be initialized to -EINVAL, so that when the
size is less than sizeof(struct perf_event_attr) we avoid this valid
compiler warning:

  util/session.c: In function ‘perf_session__process_events’:
  util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     err = skip;
     ~~~~^~~~~~
  util/session.c:1874:6: note: ‘skip’ was declared here
    s64 skip;
        ^~~~
  cc1: all warnings being treated as errors

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190423105303.61683-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..bad5f87ae001 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1928,12 +1928,14 @@ more:
 
 	size = event->header.size;
 
+	skip = -EINVAL;
+
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
 		       file_offset + head, event->header.size,
-		       event->header.type);
-		err = -EINVAL;
+		       event->header.type, strerror(-skip));
+		err = skip;
 		goto out;
 	}
 
