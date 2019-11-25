Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC32C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9198720674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfKYMvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:51:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:22409 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYMvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:51:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 04:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="202341576"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.70])
  by orsmga008.jf.intel.com with ESMTP; 25 Nov 2019 04:51:39 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     x86@kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 0/2] x86/insn: Add some more Intel instructions to the opcode map
Date:   Mon, 25 Nov 2019 14:50:42 +0200
Message-Id: <20191125125044.31879-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch to update the x86 opcode map, and a patch to update the
perf tools' "new instructions" test accordingly.

There are still CET instructions to add, which Yu-cheng is doing.


Adrian Hunter (2):
      x86/insn: perf tools: Add some more instructions to the new instructions test
      x86/insn: Add some more Intel instructions to the opcode map

 arch/x86/lib/x86-opcode-map.txt              |  44 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  44 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 366 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 484 ++++++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 655 +++++++++++++++++++++++++++
 5 files changed, 1569 insertions(+), 24 deletions(-)


Regards
Adrian
