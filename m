Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B9B20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfDSTCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:02:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:51014 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfDSTC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:02:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 04:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,369,1549958400"; 
   d="scan'208";a="141962866"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2019 04:42:01 -0700
Subject: Re: [PATCH v15 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, aubrey.li@intel.com,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190416063250.7514-1-aubrey.li@linux.intel.com>
 <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
 <CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com>
 <alpine.DEB.2.21.1904181500100.3174@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <547c8966-8252-01b9-a807-5e28f91acf6b@linux.intel.com>
Date:   Fri, 19 Apr 2019 19:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904181500100.3174@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/18 21:00, Thomas Gleixner wrote:
> On Wed, 17 Apr 2019, Andy Lutomirski wrote:
> 
>> On Tue, Apr 16, 2019 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Tue, 16 Apr 2019 14:32:48 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>>
>>>> The architecture specific information of the running processes could
>>>> be useful to the userland. Add support to examine process architecture
>>>> specific information externally.
>>>
>>> The implementation looks just fine to me.  Have you had any feedback on
>>> the overall desirability of adding this feature?
>>
>> I think I've been the most outspoken, and my not-all-that-strong
>> opinion is that I don't really like it.  /proc/PID/status is already a
>> bit of a mess, and I don't think we really want it to be a mess that
>> is different on different architectures.  Hence my suggestion of
>> /proc/PID/x86_status instead.  Or we could do /proc/PID/arch_status, I
> 
> arch_status looks like the right thing to do.

Thanks Andy and Thomas, let me change the patch to use arch_status instead.
