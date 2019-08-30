Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4BC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FBB23405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfH3WSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:18:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:3805 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfH3WSU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:18:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 15:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="182772067"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.213.244]) ([10.254.213.244])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2019 15:18:18 -0700
Subject: Re: [PATCH v1 2/4] perf vendor events intel: Update cascadelakex
 uncore events to v1.04
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Haiyan Song <haiyanx.song@intel.com>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
 <20190828055932.8269-3-yao.jin@linux.intel.com>
 <20190830182242.GF28011@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <273f82b2-530a-baaf-1f2d-2f8f89641914@linux.intel.com>
Date:   Sat, 31 Aug 2019 06:18:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830182242.GF28011@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2019 2:22 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 28, 2019 at 01:59:30PM +0800, Jin Yao escreveu:
>> From: Haiyan Song <haiyanx.song@intel.com>
> 
> Not applying, please check, will apply the other 3 patches in the
> series, next time please try to collect some Acked-by in advance.
> 
> - Arnaldo
>   

Hi Arnaldo,

Sorry, any issue you found when applying this patch? Is it truncated by 
the email system?

Or the applying is no problem at your side but this patch needs some 
Acked-by before applying, right?

Thanks
Jin Yao



