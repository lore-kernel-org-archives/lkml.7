Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE30C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D58B21738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGXNI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:08:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:21518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfGXNI7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="172297052"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2019 06:08:58 -0700
Received: from [10.251.5.204] (kliang2-mobl.ccr.corp.intel.com [10.251.5.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7A18D5803EA;
        Wed, 24 Jul 2019 06:08:57 -0700 (PDT)
Subject: Re: [PATCH v2] perf vendor events: Add Icelake V1.00 event file
To:     Haiyan Song <haiyanx.song@intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190724022744.5374-1-haiyanx.song@intel.com>
 <8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ffd8275f-6eaa-58b7-dc17-7058b42249d3@linux.intel.com>
Date:   Wed, 24 Jul 2019 09:08:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2019 2:32 AM, Haiyan Song wrote:
> Hi,
> 
> This patch contains lines that longer than 998 characters,
> I've sent it by 'git send-email', but when apply it,
> prompt information "error: corrupt patch at line 2558".
> 
>     https://lkml.org/lkml/2019/6/24/1278
> 
> I checked the line at 2558, it is very short line.
> So the patch may be truncated before applying it.
> 
> Could you let me to send this patch as attachment? Please check the 
> attachment in this mail.
>

The attached event list looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan


> We will apply for account on kernel.org to provide git pull request.
> But now it is still ongoing.
> 
> Thanks very much!
> 
