Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7BEC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97BB207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfKZFaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:30:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:60136 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKZFaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:30:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 21:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,244,1571727600"; 
   d="scan'208";a="211308351"
Received: from lipengxi-mobl.amr.corp.intel.com ([10.255.28.133])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2019 21:30:13 -0800
Message-ID: <b146b35e4434a0bf57dfd8052b2b455f06fa46ab.camel@intel.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Eduardo's email is bouncing
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, eduval@amazon.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Tue, 26 Nov 2019 13:29:04 +0800
In-Reply-To: <CAHLCerPKQSLrgybYhhFDxjXu56BD+iAyz1OYF14rTbjotEkD7g@mail.gmail.com>
References: <20191123154303.2202-1-f.fainelli@gmail.com>
         <CAHLCerPKQSLrgybYhhFDxjXu56BD+iAyz1OYF14rTbjotEkD7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-25 at 15:27 +0530, Amit Kucheria wrote:
> On Sat, Nov 23, 2019 at 9:13 PM Florian Fainelli <
> f.fainelli@gmail.com> wrote:
> > 
> > The last two emails to Eduardo were returned with:
> > 
> > 452 4.2.2 The email account that you tried to reach is over quota.
> > Please direct the recipient to
> > https://support.google.com/mail/?p=OverQuotaTemp j17sor626162wrq.49
> > -
> > gsmtp
> 
> Right, I've been seeing the same for the last week for all my
> postings.

okay, I will queue this patch.

> 
> Rui, will you please send the pull request to Linus for 5.5 (and
> going
> forward) with all the contents of thermal/next[1]? Otherwise, the
> thermal soc patches will unnecessarily miss the merge window. They've
> been baking in linux-next for a while.

yes, all the patches in thermal/next are for 5.5-rc1.

thanks,
rui

> 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/next
> 
> 
> 
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e4f170d8bc29..84e8bdae4beb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16085,7 +16085,6 @@ F:      drivers/media/radio/radio-
> > raremono.c
> > 
> >  THERMAL
> >  M:     Zhang Rui <rui.zhang@intel.com>
> > -M:     Eduardo Valentin <edubezval@gmail.com>
> >  R:     Daniel Lezcano <daniel.lezcano@linaro.org>
> >  R:     Amit Kucheria <amit.kucheria@verdurent.com>
> >  L:     linux-pm@vger.kernel.org
> > --
> > 2.17.1
> > 

