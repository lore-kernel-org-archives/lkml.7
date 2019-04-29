Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98321C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AB6214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfD2Jyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:54:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:42225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfD2Jyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:54:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 02:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="146730353"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 29 Apr 2019 02:54:51 -0700
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
 <20190427085816.GB12360@zn.tnic>
 <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
 <20190428100309.GA2334@zn.tnic>
 <4c5ca6d7-ffb1-a5a5-9e46-9057802318e0@intel.com>
 <20190429073625.GA2324@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <923a3152-8029-14e9-9713-871b041c9c99@intel.com>
Date:   Mon, 29 Apr 2019 17:52:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190429073625.GA2324@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月29日 15:36, Borislav Petkov wrote:
> On Mon, Apr 29, 2019 at 09:24:12AM +0800, Zhao, Yakui wrote:
>> Yes. "movq" only indicates explicitly that it is 64-bit mov as ACRN guest
>> only works under 64-bit mode.
>> I also check the usage of "mov" and "movq" in this scenario. There is no
>> difference except that the movq is an explicit 64-op.
> 
> Damn, I'm tired of explaining this: it is explicit only to the code
> reader. gcc generates the *same* instruction no matter whether it has a
> "q" suffix or not as long as the destination register is a 64-bit one.
> 
> If you prefer to have it explicit, sure, use "movq".

Hi, Borislav

     Thanks for the detailed explanation.
     "movq" will be used so that it is explicit to the code reader 
although the same binary is generated for "movq" and "mov" in this scenario.

     And thank you again for giving a lot of helps about removing the 
usage of explicit register variable.

Best regards
    Yakui
> 
