Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA12C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF5220868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCHRju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:22095 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfCHRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120875048"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 09:39:48 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0F4193015F7; Fri,  8 Mar 2019 09:39:49 -0800 (PST)
Date:   Fri, 8 Mar 2019 09:39:49 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 05/15] perf tools report: Parse time quantum
Message-ID: <20190308173949.GI7535@tassilo.jf.intel.com>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-6-andi@firstfloor.org>
 <20190308134532.GC26260@kernel.org>
 <20190308135236.GF26260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308135236.GF26260@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:52:36AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 08, 2019 at 10:45:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Mar 05, 2019 at 06:47:48AM -0800, Andi Kleen escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > +	if (*end == 0)
> > > +		return 0;
> > 
> > We have tools/include/linux/time64.h, just like the kernel, so please
> > use:
> > 
> > #include <linux/time64.h>
> 
> I'll do that this time.

Thanks.  I already did it in my copy too.

-Andi
