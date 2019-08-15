Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98224C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1221855
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="2FG8hUe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfHOJcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:32:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59089 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:32:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9WI4r2274467
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:32:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9WI4r2274467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861539;
        bh=0ui+/GgtvsaoRaDR6J8z8f8Sp+PWSa3GGOrhA2FO2SE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=2FG8hUe8rgjYkpEdSo6WHuu2rwtkMxLuCNTfSZrg+KsSY1UN9Ze56cmi449rsVieY
         EhrzIqbNKRT9NIqLUxt7EqZQbC2/f32nTlvYPBq6Gt96+D3cxMTngJPRG5hdBJ/e7U
         z8jMPfoudRscrUJS+IO6zVRzCeNLETm4Ishac7AycUBjksrjT6x5ZFz4sOTaqvIX3q
         kbHxFXKmpEqubN2SpLUO4sJNhrX6VM2o5tnA21rCYCYWczK9MGQtwZUKkFTwdTYr4C
         p9lE4A08bRib0ysFlJhMfUlEZeBHWefhCyF19kzVXn5pb5wEBDd2h1hewivGlFw5eh
         iF3FT9BJ7Ttxw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9WIrY2274464;
        Thu, 15 Aug 2019 02:32:18 -0700
Date:   Thu, 15 Aug 2019 02:32:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1b9921546a9641aefc4a52c1c635b96b67142993@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com, kan.liang@linux.intel.com, peterz@infradead.org,
        adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, kan.liang@linux.intel.com, hpa@zytor.com,
          adrian.hunter@intel.com, peterz@infradead.org,
          namhyung@kernel.org, jolsa@kernel.org
In-Reply-To: <20190806084606.4021-7-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-7-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add aux-output config term
Git-Commit-ID: 1b9921546a9641aefc4a52c1c635b96b67142993
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

Commit-ID:  1b9921546a9641aefc4a52c1c635b96b67142993
Gitweb:     https://git.kernel.org/tip/1b9921546a9641aefc4a52c1c635b96b67142993
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Aug 2019 11:46:05 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf tools: Add aux-output config term

Expose the aux_output attribute flag to the user to configure, by adding a
config term 'aux-output'. For events that support it, selection of
'aux-output' causes the generation of AUX records instead of event records.
This requires that an AUX area event is also provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-7-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 2 ++
 tools/perf/util/evsel.c                  | 3 +++
 tools/perf/util/evsel.h                  | 2 ++
 tools/perf/util/parse-events.c           | 8 ++++++++
 tools/perf/util/parse-events.h           | 1 +
 tools/perf/util/parse-events.l           | 1 +
 6 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d5e58e0a2bca..c6f9f31b6039 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -60,6 +60,8 @@ OPTIONS
 	  - 'name' : User defined event name. Single quotes (') may be used to
 		    escape symbols in the name from parsing by shell and tool
 		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
+	  - 'aux-output': Generate AUX records instead of events. This requires
+			  that an AUX area event is also provided.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 897a97af2d81..5da40511546b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -833,6 +833,9 @@ static void apply_config_terms(struct evsel *evsel,
 			break;
 		case PERF_EVSEL__CONFIG_TERM_PERCORE:
 			break;
+		case PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT:
+			attr->aux_output = term->val.aux_output ? 1 : 0;
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3cf35aa782b9..8a316dd54cd0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -52,6 +52,7 @@ enum term_type {
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
 	PERF_EVSEL__CONFIG_TERM_PERCORE,
+	PERF_EVSEL__CONFIG_TERM_AUX_OUTPUT,
 };
 
 struct perf_evsel_config_term {
@@ -70,6 +71,7 @@ struct perf_evsel_config_term {
 		char	*branch;
 		unsigned long max_events;
 		bool	percore;
+		bool	aux_output;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2cfec3b7a982..9101568946d2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -963,6 +963,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
 	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
+	[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
 };
 
 static bool config_term_shrinked;
@@ -1083,6 +1084,9 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	default:
 		err->str = strdup("unknown term");
 		err->idx = term->err_term;
@@ -1133,6 +1137,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
@@ -1225,6 +1230,9 @@ do {								\
 			ADD_CONFIG_TERM(PERCORE, percore,
 					term->val.num ? true : false);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
+			break;
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 48111b8fc232..616ca1eda0eb 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -76,6 +76,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
+	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index ca6098874fe2..7469497cd28e 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -284,6 +284,7 @@ no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
 overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
+aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
