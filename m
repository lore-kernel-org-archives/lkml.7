Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D369BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2052084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLDHyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfLDHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTs-0004Qh-5h; Wed, 04 Dec 2019 08:53:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA25B1C2644;
        Wed,  4 Dec 2019 08:53:51 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf kvm: Clarify the 'perf kvm' -i and -o command
 line options
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steve Dickson <steved@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-tclbttvmgtm525fvmh85f7d9@git.kernel.org>
References: <tip-tclbttvmgtm525fvmh85f7d9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157544603168.21853.2876185097279528728.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9974406884459c9301597c2c9f7def6c38099ab4
Gitweb:        https://git.kernel.org/tip/9974406884459c9301597c2c9f7def6c38099ab4
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Dec 2019 15:38:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Dec 2019 15:38:59 -03:00

perf kvm: Clarify the 'perf kvm' -i and -o command line options

The 'perf kvm' subcommand has options that it in turn passes to other
perf subcommands such as 'report' and 'record', particularly -i and -o
end up setting the same variable that will then be used for 'record's -o
and report '-i', which ends up being confusing, leading some to think
that both -i and -o can be used with 'report'.

Improve the man page to state that -i is used with the post-processing
subcommands while -o is used just with 'record' and that to save the
output of 'report' one should simply redirect its output to a file.

Noticed while reading the https://www.linux-kvm.org/page/Perf_events
page.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steve Dickson <steved@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-tclbttvmgtm525fvmh85f7d9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kvm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 6a5bb2b..cf95bae 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -68,10 +68,11 @@ OPTIONS
 -------
 -i::
 --input=<path>::
-        Input file name.
+        Input file name, for the 'report', 'diff' and 'buildid-list' subcommands.
 -o::
 --output=<path>::
-        Output file name.
+        Output file name, for the 'record' subcommand. Doesn't work with 'report',
+        just redirect the output to a file when using 'report'.
 --host::
         Collect host side performance profile.
 --guest::
