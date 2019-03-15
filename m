Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06CD218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfCOFp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:45:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:57322 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfCOFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:45:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 22:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="282872523"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.181]) ([10.239.196.181])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2019 22:45:55 -0700
Subject: Re: [PATCH] scripts/spelling.txt: add more typos to spelling.txt and
 sort
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
References: <1552613886-13845-1-git-send-email-like.xu@linux.intel.com>
 <alpine.LNX.2.21.1903151359480.8@nippy.intranet>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <f2a36dc4-fc66-97b9-cadb-ccd37e2b400a@linux.intel.com>
Date:   Fri, 15 Mar 2019 13:45:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1903151359480.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/15 11:07, Finn Thain wrote:
> 
> Does it makes sense to list every typo that is simply a transposition of
> characters or a character omitted? This file will become very large very
> quickly if we do that.

We are consistent in one thing: typo hurt eyes.

Those typos are exactly generated from and still existing in the kernel 
tree and they're constantly merged out of our carelessness.

> Such errors can be found algorithmically where the correct spelling is
> known. E.g. the file contains 'algorithm' so 'algrthm' can easily be
> obtained programatically.

Nice hint on transposition programmability which means effect to me.

It looks the mistake line could be removed form scripts/spelling.txt 
after we add transposition check to scripts/checkpatch.pl. ($0.02)

> 
> Suggest you restrict this to common misspellings. That's not a NAK and I'm
> not the relevant maintainer. Just my $0.02.
> 

Thanks for your comment.
