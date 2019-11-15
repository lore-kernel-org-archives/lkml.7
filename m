Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BAFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563A20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKONzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:55:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:11218 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKONzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:55:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 05:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="199205460"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2019 05:55:44 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     x86@kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/2] x86/insn: Add some Intel instructions to the opcode map
Date:   Fri, 15 Nov 2019 15:54:45 +0200
Message-Id: <20191115135447.6519-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch to update the x86 opcode map, and a patch to update the
perf tools' "new instructions" test accordingly.

There are still a lot of AVX instructions to add and also
CET instructions, which Yu-cheng is adding.


Adrian Hunter (2):
      x86/insn: perf tools: Add some instructions to the new instructions test
      x86/insn: Add some Intel instructions to the opcode map

 arch/x86/lib/x86-opcode-map.txt              |  18 +++--
 tools/arch/x86/lib/x86-opcode-map.txt        |  18 +++--
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  52 +++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  |  62 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 109 +++++++++++++++++++++++++++
 5 files changed, 247 insertions(+), 12 deletions(-)


Regards
Adrian
