Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFFFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E34218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfJJGqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:46:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfJJGqo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:46:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 23:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="198248157"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.143]) ([10.239.196.143])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2019 23:46:37 -0700
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava> <20190930182136.GD8560@tassilo.jf.intel.com>
 <20190930192800.GA13904@kernel.org>
 <20191001021755.GF8560@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8a1cbcf6-2de7-3036-1c86-f3af6af077e2@linux.intel.com>
Date:   Thu, 10 Oct 2019 14:46:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001021755.GF8560@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2019 10:17 AM, Andi Kleen wrote:
>>> I think it's useful. Makes it easy to do kernel/user break downs.
>>> perf record should support the same.
>>
>> Don't we have this already with:
>>
>> [root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1
> 
> This only works for simple cases. Try it for --topdown or multiple -M metrics.
> 
> -Andi
> 

Hi Arnaldo, Jiri,

We think it should be very useful if --all-user / --all-kernel can be 
specified together, so that we can get a break down between user and 
kernel easily.

But yes, the patches for supporting this new semantics is much 
complicated than the patch which just follows original perf-record 
behavior. I fully understand this concern.

So if this new semantics can be accepted, that would be very good. But 
if you think the new semantics is too complicated, I'm also fine for 
posting a new patch which just follows the perf-record behavior.

Thanks
Jin Yao
