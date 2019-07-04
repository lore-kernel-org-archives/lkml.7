Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D83C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C791E2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfGDQKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:10:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:59408 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfGDQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:10:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169476831"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:10:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
In-Reply-To: <20190612132852.GB4836@kernel.org>
References: <20190610072803.10456-1-adrian.hunter@intel.com> <20190610072803.10456-2-adrian.hunter@intel.com> <20190612000945.GE28689@kernel.org> <e0a9a4e9-6c49-ecd1-4729-79002c66fafe@intel.com> <20190612124140.GA4836@kernel.org> <a3efee50-cf64-d139-237f-b51be8f76f3c@intel.com> <20190612132852.GB4836@kernel.org>
Date:   Thu, 04 Jul 2019 19:10:44 +0300
Message-ID: <87ef354w6z.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

>> Awaiting V2, here is a link to the patches:
>> 
>> 	https://lore.kernel.org/lkml/20190502105022.15534-1-alexander.shishkin@linux.intel.com/
>
> yeah, I saw those and PeterZ's comments, that is why I asked about them
> :-)
>  
>> There is also still a few more tools changes dependent upon the kernel patches.
>
> But I think I can go ahead and push the decoder bits, when the kernel
> patches get merged we'll be almost ready to make full use of what it
> provides, right?

The kernel stuff and the rest of the tooling patches are here [1].

[1] https://marc.info/?l=linux-kernel&m=156225605132606

Regards,
--
Alex
