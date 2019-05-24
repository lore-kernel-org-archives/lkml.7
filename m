Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6021773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbfEXNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:09:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:33530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391436AbfEXNJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:09:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 06:09:19 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 06:09:18 -0700
Received: from [10.254.95.140] (kliang2-mobl.ccr.corp.intel.com [10.254.95.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 995805801AB;
        Fri, 24 May 2019 06:09:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf/x86: Disable non generic regs for software/probe
 events
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1905240902420.8774@macbook-air>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <efd27dab-9cee-e22f-fd67-9fed4bac7de7@linux.intel.com>
Date:   Fri, 24 May 2019 09:09:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905240902420.8774@macbook-air>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 5/24/2019 9:03 AM, Vince Weaver wrote:
> 
> I've run the fuzzer overnight with both patches applied and have not seen
> any issues.
> 

Thanks a lot for the test.
Kan
