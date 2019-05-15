Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DEF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfEOOPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:15:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:51762 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEOOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:15:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 07:15:44 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2019 07:15:44 -0700
Received: from [10.254.95.25] (kliang2-mobl.ccr.corp.intel.com [10.254.95.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 89143580414;
        Wed, 15 May 2019 07:15:43 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] perf parse-regs: Split parse_regs
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, acme@kernel.org
Cc:     jolsa@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
 <02cd8171-3dbf-b835-3fe0-245f6fbea1cb@linux.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c628c2a2-4d85-ccae-6de1-79d259209212@linux.intel.com>
Date:   Wed, 15 May 2019 10:15:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02cd8171-3dbf-b835-3fe0-245f6fbea1cb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2019 2:49 AM, Ravi Bangoria wrote:
> 
> On 5/15/19 1:49 AM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The available registers for --int-regs and --user-regs may be different,
>> e.g. XMM registers.
>>
>> Split parse_regs into two dedicated functions for --int-regs and
>> --user-regs respectively.
>>
>> Modify the warning message. "--user-regs=?" should be applied to show
>> the available registers for --user-regs.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
> For patch 1 and 2,
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Minor neat. Should we update document as well? May be something like:
> 
>    tools/perf/Documentation/perf-record.txt
> 
>    --user-regs::
>    Similar to -I, but capture user registers at sample time. To list the available
>    user registers use --user-regs=\?.
>
Hi Ravi,

Thanks for test.

The change of document looks good.

Thanks,
Kan

