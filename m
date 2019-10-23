Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC20CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2CD21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405662AbfJWNLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:11:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:31767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfJWNLo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:11:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196772810"
Received: from shilongz-mobl.ccr.corp.intel.com (HELO [10.254.210.50]) ([10.254.210.50])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 06:11:42 -0700
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
 <20191023113642.GN22919@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ffdcc12e-96ee-02f3-b327-93541af35f1a@linux.intel.com>
Date:   Wed, 23 Oct 2019 21:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023113642.GN22919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 7:36 PM, Jiri Olsa wrote:
> On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index 43d1d410854a..eb286700a8a9 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -492,6 +492,10 @@ struct sort_entry sort_sym_ipc_null = {
>>   	.se_width_idx	= HISTC_SYMBOL_IPC,
>>   };
>>   
>> +struct sort_entry sort_block_cycles = {
>> +	.se_cmp		= sort__sym_cmp,
>> +};
> 
> so this is here only for you to be able to write '-s total_cycles'
> and has no other functonality right?
> 

Yes, that's right.

> I think we'd be better with report boolean option instad, like
> 'perf report --total-cycles', because your code does the column
> display by itself.. and we could get rid of this -s confusion
> 

Yes, I agree. Thanks for this suggestion!

Thanks
Jin Yao

> jirka
> 
