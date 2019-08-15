Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF701C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36AA208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xrqX2DB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfHOJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:33:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbfHOJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:33:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9X3pf2274587
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:33:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9X3pf2274587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861583;
        bh=P6+lsYDxk0+QMDya/lzHplzGDXcVTXkSghOKD64baCY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xrqX2DB9I+zyAaB2dWSFO93YfbEObEao5Q/0uMTot7R9JG6pYBfw11IHQymJkfm3+
         0eTMZPsUEB1y8SdfPs3xctmXnn3jFhP3xyjEoHb07I2RjNtJGrTp3GvlM8gqNA8qpv
         5f9QW0kPHNgx8I3KjCtS0nh0QB5++GNpewrrREQMXtQiSOiR0tum3QvD2rJRDs5A0U
         F+vWwJPZLJrEFpMvKCaU+tkKnrilLxiPAZHIIUI2qfSaUdSSCCGTKuqHd4zo6VCVsm
         ObtjcPmDp9hGTzFJznMib3Fh1OGOVi7fUT080BEMnz8L800zsuiGLyI8efg4p/e2wx
         g7uT/PRmGtaOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9X2H12274555;
        Thu, 15 Aug 2019 02:33:02 -0700
Date:   Thu, 15 Aug 2019 02:33:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-243384dd25c8ea721c5c82a229eaf33cbd1bfd52@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, kan.liang@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: kan.liang@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, jolsa@kernel.org,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190806084606.4021-8-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-8-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add brief documentation for PEBS via
 Intel PT
Git-Commit-ID: 243384dd25c8ea721c5c82a229eaf33cbd1bfd52
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

Commit-ID:  243384dd25c8ea721c5c82a229eaf33cbd1bfd52
Gitweb:     https://git.kernel.org/tip/243384dd25c8ea721c5c82a229eaf33cbd1bfd52
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Aug 2019 11:46:06 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf intel-pt: Add brief documentation for PEBS via Intel PT

Document how to select PEBS via Intel PT and how to display synthesized
PEBS samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-8-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
[ Update the example to use a group with intel_pt// as the group leader, as per Alex comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 50c5b60101bd..e0d9e7dd4f17 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
 
 Note there is currently no advantage to using Intel PT instead of LBR, but
 that may change in the future if greater use is made of the data.
+
+
+PEBS via Intel PT
+=================
+
+Some hardware has the feature to redirect PEBS records to the Intel PT trace.
+Recording is selected by using the aux-output config term e.g.
+
+	perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}' uname
+
+Note that currently, software only supports redirecting at most one PEBS event.
+
+To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
+
+	perf script --itrace=oe
