Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4432189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000642;
	bh=8YNBko2aW3yIjB+0PIWR5iSo2rIKrq2z2GDTZGARrIA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HWfHL3B+eqX07HoZoFLFZv1Qtk2xjEdSzKG9t0JfPXRqIsSXyQuAEA3TdWsE18Qx7
	 0tRTX5pYg6gnVwjKYiziInFPeO6Ngbg9/609m+qEqNp9iXDNK8CzOUe+shO8WKc4Zj
	 tolYTqiBJjyB8Bf/RadcgeRQNpkjjYe1fbdeVpGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfH1N5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfH1N5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B15AA53264;
        Wed, 28 Aug 2019 13:57:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4CE1001B00;
        Wed, 28 Aug 2019 13:57:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 00/23] libperf: Add rest of events to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:54 +0200
Message-Id: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 13:57:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
to export 'union perf_event' we need to export the rest of events.

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (23):
      libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
      libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
      libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
      libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
      libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
      libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
      libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
      libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
      libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
      libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
      libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
      libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
      libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
      libperf: Add 'union perf_event' to perf/event.h
      libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
      libperf: Move 'enum perf_user_event_type' to perf/event.h

 tools/perf/arch/arm/util/cs-etm.c    |   4 +--
 tools/perf/arch/arm64/util/arm-spe.c |   2 +-
 tools/perf/arch/s390/util/auxtrace.c |   2 +-
 tools/perf/arch/x86/util/intel-bts.c |   2 +-
 tools/perf/arch/x86/util/intel-pt.c  |   4 +--
 tools/perf/arch/x86/util/tsc.c       |   2 +-
 tools/perf/builtin-record.c          |   4 +--
 tools/perf/builtin-report.c          |   2 +-
 tools/perf/builtin-script.c          |   2 +-
 tools/perf/builtin-stat.c            |   2 +-
 tools/perf/lib/include/perf/event.h  | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/cpumap.c            |  12 ++++----
 tools/perf/tests/event_update.c      |  16 +++++-----
 tools/perf/tests/stat.c              |   8 ++---
 tools/perf/tests/thread-map.c        |   2 +-
 tools/perf/util/arm-spe.c            |   6 ++--
 tools/perf/util/auxtrace.c           |  20 ++++++------
 tools/perf/util/auxtrace.h           |   8 ++---
 tools/perf/util/build-id.c           |   2 +-
 tools/perf/util/cpumap.c             |   6 ++--
 tools/perf/util/cpumap.h             |   4 +--
 tools/perf/util/cs-etm.c             |   2 +-
 tools/perf/util/event.c              |  38 +++++++++++------------
 tools/perf/util/event.h              | 278 +++--------------------------------------------------------------------------------------------------------------------------------------------------------------------
 tools/perf/util/header.c             |  56 +++++++++++++++++-----------------
 tools/perf/util/intel-bts.c          |   6 ++--
 tools/perf/util/intel-pt.c           |  12 ++++----
 tools/perf/util/python.c             |   4 +--
 tools/perf/util/s390-cpumsf.c        |   4 +--
 tools/perf/util/session.c            |  28 ++++++++---------
 tools/perf/util/session.h            |   2 +-
 tools/perf/util/stat.c               |  12 ++++----
 tools/perf/util/thread_map.c         |   4 +--
 tools/perf/util/thread_map.h         |   4 +--
 34 files changed, 418 insertions(+), 415 deletions(-)
