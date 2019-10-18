Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C6CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A221897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441888AbfJRAOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:14:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:52115 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441865AbfJRAOC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:14:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 17:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="226360732"
Received: from guidongj-mobl1.ccr.corp.intel.com (HELO [10.254.214.28]) ([10.254.214.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2019 17:13:59 -0700
Subject: Re: [PATCH v2] perf list: Separate the deprecated events
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20191017135214.18620-1-yao.jin@linux.intel.com>
 <20191017144644.GV9933@tassilo.jf.intel.com> <20191017152100.GC21168@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ef2fec7e-84e7-63bb-5dcb-3f85d7d78653@linux.intel.com>
Date:   Fri, 18 Oct 2019 08:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017152100.GC21168@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2019 11:21 PM, Jiri Olsa wrote:
> On Thu, Oct 17, 2019 at 07:46:44AM -0700, Andi Kleen wrote:
>>>   v2:
>>>   ---
>>>   In v1, the deprecated events are hidden by default but they can be
>>>   displayed when option "--deprecated" is enabled. In v2, we don't use
>>>   the new option "--deprecated". Instead, we just display the deprecated
>>>   events under the title "--- Following are deprecated events ---".
>>
>> It's redundant with what the event description already says.
>> If we always want to show it we don't need to do anything.
>>
>> I really would much prefer to hide it. What's the point of showing
>> something that people are not supposed to use?
>>
>> The only reason for keeping the deprecated events is to not
>> break old scripts, but those don't care about perf list output.
> 
> I thought this might be a problem for users,
> but don't have anything to back this up ;-)
> 
> if that's the case we can go with the original patch
> 
> jirka
> 

I'm fine to go with the original patch. :)

Thanks
Jin Yao

>>
>> So I think the only sane option is to hide it by default.
>>
>> -Andi
