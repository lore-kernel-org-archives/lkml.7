Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48C4218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KiUG5zRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCOKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:10:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:10:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E9rlF3321645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:09:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E9rlF3321645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162993;
        bh=wVFhpixgR/ZdrG9fWChFwvcOdzYv4ySInnFGLVA9Lc4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=KiUG5zRo9udUwRZum9aGtQCOjNw1Xpn6ZMxqXMLu9p9CUGV++oqfemis7kBXMWIl/
         dflvutyFYLArjDEAUInpJ8P386wYqYOhrWisiOUaNYloBQcVcs4qKT+xSyux7R7s96
         f1yDDY/uTZY/6QYL2e89jdQm46P6Q6zP/dPwcRpDtiR/TB58/ZaEGa/n3hDQAQ0Qf8
         QZ4q/YZIwWtMf5oUBX2V3giIfBLIBPsGZ8eZ+FihF2sVs0HFhq0VGoW7u/VzLKEG8D
         wwOsh7mIv5mlDdenH4ryxvxf80v8A3qfvhlK8HThkriIVIUfRkK5r0iYf0Xq/3l+Q8
         RHpmmnM759z7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E9pnb3321641;
        Wed, 3 Jul 2019 07:09:51 -0700
Date:   Wed, 3 Jul 2019 07:09:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9s1dxik37waveor7c84hqti2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ui stdio: No need to use 'spaces' to left
 align
Git-Commit-ID: b598c34ffc2b60c5c2f6450753a376a81f225652
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

Commit-ID:  b598c34ffc2b60c5c2f6450753a376a81f225652
Gitweb:     https://git.kernel.org/tip/b598c34ffc2b60c5c2f6450753a376a81f225652
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 16:24:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 16:24:20 -0300

perf ui stdio: No need to use 'spaces' to left align

We can just use the 'field width' for the %s used to print the
alignment, this way we'll get the same result without requiring having a
variable with just lots of space chars.

No way to do that for the dots tho, we still need that variable filled
with dot chars.

  # perf report --stdio --hierarchy > before
  # perf report --stdio --hierarchy > after
  # diff before after
  #

I.e. it continues as:

  # perf report --stdio --hierarchy | head -15
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 107  of event 'cycles'
  # Event count (approx.): 31378313
  #
  #       Overhead  Command / Shared Object / Symbol
  # ..............  ............................................
  #
      80.13%        swapper
         72.29%        [kernel.vmlinux]
            49.85%        [k] intel_idle
             9.05%        [k] tick_nohz_next_event
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1dxik37waveor7c84hqti2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index a60f2993d390..4c97e3cdf173 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -566,10 +566,14 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 static int print_hierarchy_indent(const char *sep, int indent,
 				  const char *line, FILE *fp)
 {
+	int width;
+
 	if (sep != NULL || indent < 2)
 		return 0;
 
-	return fprintf(fp, "%-.*s", (indent - 2) * HIERARCHY_INDENT, line);
+	width = (indent - 2) * HIERARCHY_INDENT;
+
+	return fprintf(fp, "%-*.*s", width, width, line);
 }
 
 static int hists__fprintf_hierarchy_headers(struct hists *hists,
@@ -587,7 +591,7 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 	indent = hists->nr_hpp_node;
 
 	/* preserve max indent depth for column headers */
-	print_hierarchy_indent(sep, indent, spaces, fp);
+	print_hierarchy_indent(sep, indent, " ", fp);
 
 	/* the first hpp_list_node is for overhead columns */
 	fmt_node = list_first_entry(&hists->hpp_formats,
@@ -816,7 +820,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (!h->leaf && !hist_entry__has_hierarchy_children(h, min_pcnt)) {
 			int depth = hists->nr_hpp_node + h->depth + 1;
 
-			print_hierarchy_indent(sep, depth, spaces, fp);
+			print_hierarchy_indent(sep, depth, " ", fp);
 			fprintf(fp, "%*sno entry >= %.2f%%\n", indent, "", min_pcnt);
 
 			if (max_rows && ++nr_rows >= max_rows)
