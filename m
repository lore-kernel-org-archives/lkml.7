Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF48206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCInd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:43:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:15556 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCInd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:43:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 00:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="412103813"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 00:43:27 -0800
Subject: Re: [LKP] Re: [refcount] d2d337b185:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>, lkp@lists.01.org
References: <20191121115902.2551-9-will@kernel.org>
 <20191201154913.GQ18573@shao2-debian>
 <CAKv+Gu8VinMc8nv=W2-8c-HP7d6i_TV2weOZu9R8PiiHDtHRFA@mail.gmail.com>
 <92d23f27-5ed0-5765-a9e3-9bc9fbd3768d@intel.com>
 <20191203080932.GA6481@willie-the-truck>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <11318ffd-f290-55f3-9471-f51de9973510@intel.com>
Date:   Tue, 3 Dec 2019 16:42:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191203080932.GA6481@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/19 4:09 PM, Will Deacon wrote:
> On Tue, Dec 03, 2019 at 04:01:46PM +0800, Rong Chen wrote:
>> On 12/2/19 5:43 PM, Ard Biesheuvel wrote:
>>> On Sun, 1 Dec 2019 at 16:49, kernel test robot <rong.a.chen@intel.com> wrote:
>>>> FYI, we noticed the following commit (built with gcc-7):
>>>>
>>>> commit: d2d337b185bd2abff262f3cf7de0080b3888e41c ("[RESEND PATCH v4
>>>> 08/10] refcount: Consolidate implementations of refcount_t")
>>>> url:
>>>> https://github.com/0day-ci/linux/commits/Will-Deacon/Rework-REFCOUNT_FULL-using-atomic_fetch_-operations/20191124-052413
>>>>
>>>>
>>>> in testcase: ocfs2test
>>>> with following parameters:
>>>>
>>>>           disk: 1SSD
>>>>           test: test-mkfs
>>>>
>>> So we went from a success rate of 0 out of 24 to 0 out of 24 by
>>> applying that patch. How on earth is that a result that justifies
>>> spamming everybody?
>> These failures were triggered by ocfs2test test, and all tests were failed
>> include parent commit "2ab80bd4ae".
> https://lore.kernel.org/lkml/20191119182745.GA11397@willie-the-truck
> https://lore.kernel.org/lkml/20190912105640.2l6mtdjmcyyhmyun@willie-the-truck/
>
> The refcount code is doing its job afaict and its the ocfs2 code at fault.
>
> Will

Hi Will,

Thanks for your explanation, we'll disable the test.

Best Regards,
Rong Chen
