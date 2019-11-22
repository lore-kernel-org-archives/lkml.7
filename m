Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D8720674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVAzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:55:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:57577 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKVAzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:55:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 16:55:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="381922129"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2019 16:55:53 -0800
Date:   Thu, 21 Nov 2019 16:55:53 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122005553.GA11322@agluck-desk2.amr.corp.intel.com>
References: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
 <159DB397-87E2-435D-9F33-067FF9296ADC@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159DB397-87E2-435D-9F33-067FF9296ADC@amacapital.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:24:21PM -0800, Andy Lutomirski wrote:
> 
> > On Nov 21, 2019, at 1:51 PM, Luck, Tony <tony.luck@intel.com> wrote:

> > Almost all of what's in this set will be required in whatever
> > final solution we want to end up with. Out of this:
> 
> Why don’t we beat it into shape and apply it, hidden behind BROKEN.
> Then we can work on the rest of the patches and have a way to test them.

That's my goal (and thanks for the help with the constructive beating,
"die" is a much better choice that "panic" at this stage of development).

I'm not sure I see the need to hide it behind BROKEN. The reasoning
behind choosing disabled by default was so that this wouldn't affect
anyone unless they chose to turn it on.

-Tony
