Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89602087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCLTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:08:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:5364 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfCLTIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:08:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 12:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="282047437"
Received: from guptapadev.jf.intel.com (HELO guptapadev.amr) ([10.7.198.56])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2019 12:08:48 -0700
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
 <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pawan.kumar.gupta@linux.intel.com; keydata=
 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
 m/wHiAuVkdCC09ylqYQ5rRGb2g==
Message-ID: <2f67558f-2720-9ef6-7d69-5436e0da6537@linux.intel.com>
Date:   Tue, 12 Mar 2019 12:07:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With core scheduling LTP reports 2 new failures related to cgroups(memcg_stat_rss and memcg_move_charge_at_immigrate). I will try to debug it.

Also "perf sched map" indicates there might be a small window when 2 processes in different cgroups run together on one core.
In below case B0 and D0(stress-ng-cpu and sysbench) belong to 2 different cgroups with cpu.tag enabled.

$ perf sched map

  *A0                                 382.266600 secs A0 => kworker/0:1-eve:51
  *B0                                 382.266612 secs B0 => stress-ng-cpu:7956
  *A0                                 382.394597 secs 
  *B0                                 382.394609 secs 
   B0             *C0                 382.494459 secs C0 => i915/signal:0:450
   B0             *D0                 382.494468 secs D0 => sysbench:8088
  *.               D0                 382.494472 secs .  => swapper:0
   .              *C0                 383.095787 secs 
  *B0              C0                 383.095792 secs 
   B0             *D0                 383.095820 secs
  *A0              D0                 383.096587 secs

In some cases I dont see an IPI getting sent to sibling cpu when 2 incompatible processes are picked. Like is below logs at timestamp 382.146250
"stress-ng-cpu" is picked when "sysbench" is running on the sibling cpu.

  kworker/0:1-51    [000] d...   382.146246: __schedule: cpu(0): selected: stress-ng-cpu/7956 ffff9945bad29200
  kworker/0:1-51    [000] d...   382.146246: __schedule: max: stress-ng-cpu/7956 ffff9945bad29200
  kworker/0:1-51    [000] d...   382.146247: __prio_less: (swapper/4/0;140,0,0) ?< (sysbench/8088;140,34783671987,0)
  kworker/0:1-51    [000] d...   382.146248: __prio_less: (stress-ng-cpu/7956;119,34817170203,0) ?< (sysbench/8088;119,34783671987,0)
  kworker/0:1-51    [000] d...   382.146249: __schedule: cpu(4): selected: sysbench/8088 ffff9945a7405200
  kworker/0:1-51    [000] d...   382.146249: __prio_less: (stress-ng-cpu/7956;119,34817170203,0) ?< (sysbench/8088;119,34783671987,0)
  kworker/0:1-51    [000] d...   382.146250: __schedule: picked: stress-ng-cpu/7956 ffff9945bad29200
  kworker/0:1-51    [000] d...   382.146251: __switch_to: Pawan: cpu(0) switching to stress-ng-cpu
  kworker/0:1-51    [000] d...   382.146251: __switch_to: Pawan: cpu(4) running sysbench
stress-ng-cpu-7956  [000] dN..   382.274234: __schedule: cpu(0): selected: kworker/0:1/51 0
stress-ng-cpu-7956  [000] dN..   382.274235: __schedule: max: kworker/0:1/51 0
stress-ng-cpu-7956  [000] dN..   382.274235: __schedule: cpu(4): selected: sysbench/8088 ffff9945a7405200
stress-ng-cpu-7956  [000] dN..   382.274237: __prio_less: (kworker/0:1/51;119,50744489595,0) ?< (sysbench/8088;119,34911643157,0)
stress-ng-cpu-7956  [000] dN..   382.274237: __schedule: picked: kworker/0:1/51 0
stress-ng-cpu-7956  [000] d...   382.274239: __switch_to: Pawan: cpu(0) switching to kworker/0:1
stress-ng-cpu-7956  [000] d...   382.274239: __switch_to: Pawan: cpu(4) running sysbench

-Pawan
