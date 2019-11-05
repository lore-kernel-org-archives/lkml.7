Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012EACA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C400F20717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfKEBol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:44:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:8339 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbfKEBok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:44:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 17:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,269,1569308400"; 
   d="scan'208";a="200218110"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 04 Nov 2019 17:44:39 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BF570300884; Mon,  4 Nov 2019 17:44:39 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:44:39 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, kbuild-all@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Add trace points to (nearly) all vectors
Message-ID: <20191105014439.GB25308@tassilo.jf.intel.com>
References: <20191030195619.22244-1-andi@firstfloor.org>
 <201911020947.N041g9eA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911020947.N041g9eA%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 09:24:50AM +0800, kbuild test robot wrote:
> Hi Andi,
> 
> Thank you for the patch! Yet something to improve:

I cannot reproduce this.

And the file clearly has an include for the trace file, so I can't see what
could be wrong.

> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on v5.4-rc5 next-20191031]

Also the config the bot sent doesn't even match next-20191031 nor tip/auto-latest


$ git log --oneline
5be9e3ebd480 (HEAD) x86: Add trace points to (nearly) all vectors
49afce6d47fe (tag: next-20191031, next/master) Add linux-next specific files for 20191031
$ zcat ~/submit/0day2.config.gz > .config
$ make oldconfig
  GEN     Makefile
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* CPU/Task time and stats accounting
*
Cputime accounting
> 1. Simple tick based cputime accounting (TICK_CPU_ACCOUNTING)
  2. Full dynticks CPU time accounting (VIRT_CPU_ACCOUNTING_GEN) (NEW)
choice[1-2?]: 
...

and lots more of those.

If i press return it compiles fine.

> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

My patch was against Linus master, but it should work against all of those

-Andi

