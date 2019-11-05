Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2197C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE021882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390937AbfKETVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:21:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:36435 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389691AbfKETVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:21:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 11:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212602897"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2019 11:21:02 -0800
Message-ID: <3c81a1af52a4bff13ed166cf73ae34bcdd17f08d.camel@linux.intel.com>
Subject: Re: [RESEND][PATCH 00/10] intel-speed-select tool updates targetted
 for 5.5
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Nov 2019 11:21:02 -0800
In-Reply-To: <905ec7d0-bc1b-987c-a9db-e898d7ba7e96@redhat.com>
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
         <905ec7d0-bc1b-987c-a9db-e898d7ba7e96@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 13:21 -0500, Prarit Bhargava wrote:
> 
> On 10/10/19 4:29 PM, Srinivas Pandruvada wrote:
> > There are no new patches in this series. This is just for clean
> > apply on
> > 5.4-rc1 for Andriy.
> > 
> 
> Andriy, what is the location of your "next" tree?
> 

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/tools/power/x86/intel-speed-select?h=next-20191105

They include all patches, except which I sent yesterday.

Thanks,
Srinivas


> Thanks,
> 
> P.
> 

