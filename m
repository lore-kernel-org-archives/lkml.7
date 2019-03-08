Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC2620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCHTsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:48:31 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:54549 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbfCHTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:48:30 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 20A261C2A49
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 19:48:29 +0000 (GMT)
Received: (qmail 25667 invoked from network); 8 Mar 2019 19:48:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Mar 2019 19:48:28 -0000
Date:   Fri, 8 Mar 2019 19:48:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tools/perf-bench: Add basic syscall benchmark
Message-ID: <20190308194827.GK9565@techsingularity.net>
References: <20190307185253.28432-1-dave@stgolabs.net>
 <20190307191157.GB32240@kernel.org>
 <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:17:47AM -0800, Davidlohr Bueso wrote:
> On Thu, 07 Mar 2019, Arnaldo Carvalho de Melo wrote:
> > You forgot to update tools/perf/Documentation/perf-bench.txt, and please
> > take a look at tools/perf/util/pmu.c convert_scale() to see how to save
> > the current locale, set the one you want, then restore the previous one,
> > so that at the end of this benchmark the environment is back to where it
> > was.
> 
> Here's an updated version with the corresponding docs, but I removed the
> setlocale() - doesn't seem worth it; I hope Mel has no strong objection.
> 

No objection, thanks!

-- 
Mel Gorman
SUSE Labs
