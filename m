Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9718C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957C214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfKGMSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:18:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:15301 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKGMSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:18:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 04:18:12 -0800
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="192802796"
Received: from pmaziarx-mobl.ger.corp.intel.com (HELO [10.237.142.179]) ([10.237.142.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Nov 2019 04:18:10 -0800
Subject: Re: [PATCH 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
 <20191106035512.3ff7bc20@grimm.local.home>
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Message-ID: <743a0466-38ea-d8c2-8954-e5ca72c8b943@linux.intel.com>
Date:   Thu, 7 Nov 2019 13:18:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191106035512.3ff7bc20@grimm.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-06 9:55, Steven Rostedt wrote:
> On Wed,  6 Nov 2019 07:27:40 +0100
> Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:
> 
>> Without this, buffers can be printed with __print_array macro that has
>> no formatting options and can be hard to read. The other way is to
>> mimic formatting capability with multiple calls of trace event with one
>> call per row which gives performance impact and different timestamp in
>> each row.
>>
>> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   include/linux/trace_events.h |  5 +++++
>>   include/linux/trace_seq.h    |  4 ++++
>>   include/trace/trace_events.h |  6 ++++++
>>   kernel/trace/trace_output.c  | 15 +++++++++++++++
>>   kernel/trace/trace_seq.c     | 30 ++++++++++++++++++++++++++++++
>>   5 files changed, 60 insertions(+)
>>
> 
> I'd like to see in the patch series (patch 3?) a use case of these
> added functionality. Or at least a link to what would be using it.
> 
> Thanks!
> 
> -- Steve
> 

ASoC: Intel is an initial recipient for this feature. I have a patch for 
this, but it should be also sent to alsa-devel mailing list, and since 
hex_dump tracing isn't there yet I'm not sure how this patch series 
should be sent.

Best regards,
Piotr Maziarz
