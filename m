Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C0C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD89214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfDYIZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:25:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:49729 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfDYIZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:25:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 01:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="138682866"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 01:24:57 -0700
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
 <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
 <alpine.DEB.2.21.1904250917400.1762@nanos.tec.linutronix.de>
 <1d7954b3-32e9-b3ac-1157-6b9c29ddbfe7@linux.intel.com>
 <alpine.DEB.2.21.1904251019520.1960@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <7ccf247b-7c70-8542-58d4-e87d7fbba569@linux.intel.com>
Date:   Thu, 25 Apr 2019 16:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904251019520.1960@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/25 16:20, Thomas Gleixner wrote:
> On Thu, 25 Apr 2019, Li, Aubrey wrote:
>> On 2019/4/25 15:20, Thomas Gleixner wrote:
>>> Let the arch select CONFIG_PROC_PID_ARCH_STATUS 
>>
>> Sorry, I didn't get the point here, above you mentioned not mixing arch and proc code
>> and not enabling this on x86 right away, then how to let x86 select it?
>>
> 
> By using 'select PROC_PID_ARCH_STATUS' in the arch/xxxx/Kconfig file in the
> patch which implements the required arch function perhaps?

Oh,oh, I misunderstood, thanks for the clarification!

Thanks,
-Aubrey
