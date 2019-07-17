Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49412173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGQPkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:40:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:37682 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQPkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:40:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 08:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="169590256"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2019 08:40:19 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DEBDB30125F; Wed, 17 Jul 2019 08:40:18 -0700 (PDT)
Date:   Wed, 17 Jul 2019 08:40:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
Message-ID: <20190717154018.GL32439@tassilo.jf.intel.com>
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
 <20190520065906.GC8068@krava>
 <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
 <20190528191102.GD13830@kernel.org>
 <CAM_iQpWxAYqUsC8TEOfhp12d8gbLmJ+xpLmcE_DwTV7gKm6_ww@mail.gmail.com>
 <20190716204324.GH3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716204324.GH3624@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 05:43:24PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 16, 2019 at 12:24:41PM -0700, Cong Wang escreveu:
> > Hi, Arnaldo
> > 
> > On Tue, May 28, 2019 at 12:11 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, May 28, 2019 at 11:21:38AM -0700, Cong Wang escreveu:
> > > > Thanks for reviewing it. Is there anyone takes this patch?
> > >
> > > Enough time, acked already, picking it.
> > 
> > Where is this patch landed? I don't see it in Linus tree. I guess you
> > are still holding it somewhere?
> 
> Got it now, will push upstream in the next batch, sorry for the delay.

FWIW i would prefer to deprecate the stalled cycles metrics. They 
are confusing and misleading. --topdown FrontendBound is a much
better metric.

-Andi
