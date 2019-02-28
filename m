Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9395C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775AA218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfB1UXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:23:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:20233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfB1UXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:23:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:23:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="150915637"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 12:23:20 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id C971558011C;
        Thu, 28 Feb 2019 12:23:17 -0800 (PST)
Subject: Re: [PATCH v4 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <914ab056-1488-2b05-8d2a-aa530c01d334@linux.intel.com>
 <20190228184724.GG9508@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4b6b1e87-b16f-5044-8ea1-615f86264101@linux.intel.com>
Date:   Thu, 28 Feb 2019 23:23:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228184724.GG9508@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.02.2019 21:47, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 28, 2019 at 12:02:09PM +0300, Alexey Budankov escreveu:
>>
>> Define bytes_transferred and bytes_compressed metrics to calculate
>> comp_ratio=transferred/compressed in the end of the data collection.
>>
>> bytes_transferred accumulates the amount of bytes that was captured from
>> the mmaped kernel buffers for compression. bytes_compressed accumulates
>> the amount of bytes that was received after applying compression to
>> move to a storage.
> 
> Where is the code that updates these metrics? Follow up patch?

Yes, it is in [PATCH v4 07/10], specifically, record__zstd_compress() function.

Thanks,
Alexey

<SNIP>
