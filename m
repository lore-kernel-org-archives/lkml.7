Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77381C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54519217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfHZLg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:36:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:19550 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfHZLg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 04:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="174181712"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2019 04:36:57 -0700
Received: from [10.125.252.173] (abudanko-mobl.ccr.corp.intel.com [10.125.252.173])
        by linux.intel.com (Postfix) with ESMTP id D579A580375;
        Mon, 26 Aug 2019 04:36:49 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: BoF on LPC 2019 : Linux Perf advancements for compute intensive and
 server systems
To:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jonatan Corbet <corbet@lwn.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Organization: Intel Corp.
Message-ID: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
Date:   Mon, 26 Aug 2019 14:36:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

There is a BoF session scheduled on Linux Plumbers Conference 2019 event.
If you plan attend the event feel free to join and discuss about the BoF 
topic and beyond:

Linux Perf advancements for compute intensive and server systems:

"Modern server and compute intensive systems are naturally built around 
 several top performance CPUs with large amount of cores and equipped 
 by shared memory that spans a number of NUMA domains. Compute intensive 
 workloads usually implement highly parallel CPU bound cyclic codes 
 performing mathematics calculations that reference data located in 
 the shared memory. Performance observability and profiling of these 
 workloads on such systems have unique characteristics and impose specific 
 requirements on software performance tools. The requirements include 
 tools CPU scalability, coping with high rate and volume of collected 
 performance data as well as NUMA awareness. In order to fulfill that 
 requirements a number of extensions have been implemented in Linux Perf 
 tool that are currently a part of the Linux kernel source tree 
 [1], [2], [3], [4]"

Best regards,
Alexey

[1] https://marc.info/?l=linux-kernel&m=154149439404555&w=2
[2] https://marc.info/?l=linux-kernel&m=154817912621465&w=2
[3] https://marc.info/?l=linux-kernel&m=155293062518459&w=2
[4] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
