Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD3CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8879820717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfKEBqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:46:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:16828 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfKEBqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:46:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 17:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,269,1569308400"; 
   d="scan'208";a="220503325"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2019 17:46:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BF0E4300884; Mon,  4 Nov 2019 17:46:06 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:46:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, kbuild-all@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Add trace points to (nearly) all vectors
Message-ID: <20191105014606.GC25308@tassilo.jf.intel.com>
References: <20191030195619.22244-1-andi@firstfloor.org>
 <201911020848.LOEtnDnd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911020848.LOEtnDnd%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 08:47:59AM +0800, kbuild test robot wrote:
> Hi Andi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on v5.4-rc5 next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Andi-Kleen/x86-Add-trace-points-to-nearly-all-vectors/20191102-063457
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a5b576bfb3ba85d3e356f9900dce1428d4760582
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/kernel/traps.c: In function 'do_error_trap':
> >> arch/x86/kernel/traps.c:264:2: error: implicit declaration of function 'trace_other_vector_entry'; did you mean 'frame_vector_destroy'? [-Werror=implicit-function-declaration]
>      trace_other_vector_entry(trapnr);
>      ^~~~~~~~~~~~~~~~~~~~~~~~


Also cannot reproduce and the config file seems to be not matching the kernel.

The file has the correct include:

vi +60 arch/x86/kernel/traps.c

...
 60 #include <asm/trace/irq_vectors.h>


-Andi
