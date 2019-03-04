Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC55C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE7320835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCDDUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:20:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:7614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDDUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:20:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 19:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="119347077"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.107]) ([10.239.13.107])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2019 19:20:05 -0800
Subject: Re: [LKP] [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>, lkp@01.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Changbin Du <changbin.du@gmail.com>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
 <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
 <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d0cfee27-b2e8-e1ce-1fb9-5ada0c632777@intel.com>
Date:   Mon, 4 Mar 2019 11:20:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/4/19 3:53 AM, Linus Torvalds wrote:
> On Sun, Mar 3, 2019 at 9:40 AM kernel test robot <lkp@intel.com> wrote:
>> commit: 780464aed08ad00aa6d5f81ac8bef2e714dc8b06 ("[PATCH v5 2/6] uaccess: Use user_access_ok() in user_access_begin()")
> Hmm. Not an upstream commit ID, so this is presumably a backport.
>
> Ok, let's see what it is using the web link:
>
>> url: https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-probes-uaccess-Add-support-user-space-access/20190303-203749
> Yeah, that just gives a github 404 error.


Sorry for the broken link,  It's ok now.

Best Regards,
Rong Chen


>
> I'm _assuming_ it's the WARN_ON_IN_IRQ() in the access_ok().
>
> Which doesn't much make sense either (why wouldn't it happen in
> mainline)? But without a useful web link to see what is actually being
> tested, I guess it's not something I can even look at...
>
>                        Linus
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
