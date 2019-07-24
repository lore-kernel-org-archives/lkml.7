Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4EE22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfGXNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:22:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:12795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfGXNWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:22:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="189095851"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2019 06:22:21 -0700
Received: from [10.251.5.204] (kliang2-mobl.ccr.corp.intel.com [10.251.5.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E1B255803EA;
        Wed, 24 Jul 2019 06:22:20 -0700 (PDT)
Subject: Re: Reminder: 19 open syzbot bugs in perf subsystem
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <20190724014510.GG643@sol.localdomain>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <dbbad15e-6452-76b9-f7d1-82a19c7eff68@linux.intel.com>
Date:   Wed, 24 Jul 2019 09:22:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724014510.GG643@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2019 9:45 PM, Eric Biggers wrote:
> --------------------------------------------------------------------------------
> Title:              WARNING in perf_reg_value
> Last occurred:      25 days ago
> Reported:           34 days ago
> Branches:           Mainline and others
> Dashboard link:https://syzkaller.appspot.com/bug?id=629d95983fbba49821af91acf780387bca180546
> Original thread:https://lkml.kernel.org/lkml/000000000000734545058bb27ebb@google.com/T/#u
> 
> This bug has a C reproducer.
> 
> This bug was bisected to:
> 
> 	commit 878068ea270ea82767ff1d26c91583263c81fba0
> 	Author: Kan Liang<kan.liang@linux.intel.com>
> 	Date:   Tue Apr 2 19:44:59 2019 +0000
> 
> 	  perf/x86: Support outputting XMM registers
> 
> The original thread for this bug has received 3 replies; the last was 33 days
> ago.
>

I believe the bug fixes have been merged month ago.
https://lore.kernel.org/lkml/1559081314-9714-1-git-send-email-kan.liang@linux.intel.com/

Thanks,
Kan

> If you fix this bug, please add the following tag to the commit:
>      Reported-by:syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lkml.kernel.org/r/000000000000734545058bb27ebb@google.com
