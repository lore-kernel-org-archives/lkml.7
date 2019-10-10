Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D1ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75C12190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfJJQUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfJJQUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:20:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39DF618CB8EB;
        Thu, 10 Oct 2019 16:20:12 +0000 (UTC)
Received: from krava (unknown [10.40.205.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B0F26061E;
        Thu, 10 Oct 2019 16:20:07 +0000 (UTC)
Date:   Thu, 10 Oct 2019 18:20:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 27/36] libperf: Add perf_evlist__for_each_mmap function
Message-ID: <20191010162006.GA6795@krava>
References: <20191007125344.14268-1-jolsa@kernel.org>
 <20191007125344.14268-28-jolsa@kernel.org>
 <20191010160622.GC11638@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010160622.GC11638@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 10 Oct 2019 16:20:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:06:22PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
> > index be0b25a70730..513a85cb7bfe 100644
> > --- a/tools/perf/lib/include/internal/evlist.h
> > +++ b/tools/perf/lib/include/internal/evlist.h
> > @@ -25,6 +25,8 @@ struct perf_evlist {
> >  	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
> >  	struct perf_mmap	*mmap;
> >  	struct perf_mmap	*mmap_ovw;
> > +	struct perf_mmap	*mmap0;
> > +	struct perf_mmap	*mmap_ovw0;
> 
> Why do you use this funny name? Using this "0" suffix? Please pick
> something more informative and add a comment on the struct perf_evlist
> definiton.

it's the first mmap.. I can spell it ;-)

> 
> I've processed up to the previous patch, pushed to acme/tmp.perf/core.

great, I'll rebase and continue from there

thanks,
jirka
