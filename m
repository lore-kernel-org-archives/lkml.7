Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AABC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AAC20717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfINRTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:19:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:40948 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfINRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:19:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 10:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="361116939"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2019 10:19:51 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1i9BiA-0005ON-SK; Sat, 14 Sep 2019 20:19:50 +0300
Date:   Sat, 14 Sep 2019 20:19:50 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com
Subject: Re: [PATCH 0/5] tools/power/x86/intel-speed-select: New command and
Message-ID: <20190914171950.GW2680@smile.fi.intel.com>
References: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914070513.19807-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:05:08AM -0700, Srinivas Pandruvada wrote:
> This series contains some minor fixes, when firmware mask is including
> invalid CPU in the perf-profile mask. Also add some commands to
> better manage core-power feature.

Hmm... 150+ LOCs doesn't count to me as minor fixes.
So, are you considering this a material for v5.4?


> Srinivas Pandruvada (4):
>   tools/power/x86/intel-speed-select: Allow online/offline based on tdp
>   tools/power/x86/intel-speed-select: Format get-assoc information
>   tools/power/x86/intel-speed-select: Fix some debug prints
>   tools/power/x86/intel-speed-select: Extend core-power command set
> 
> Youquan Song (1):
>   tools/power/x86/intel-speed-select: Fix high priority core mask over
>     count
> 
>  .../x86/intel-speed-select/isst-config.c      | 108 ++++++++++++++++--
>  .../power/x86/intel-speed-select/isst-core.c  |  25 ++++
>  .../x86/intel-speed-select/isst-display.c     |  51 +++++++++
>  tools/power/x86/intel-speed-select/isst.h     |   9 +-
>  4 files changed, 182 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.2
> 

-- 
With Best Regards,
Andy Shevchenko


