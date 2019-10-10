Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E42C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158AF208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfJJPcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJPcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:32:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 584CD10DCCA7;
        Thu, 10 Oct 2019 15:32:35 +0000 (UTC)
Received: from krava (unknown [10.40.205.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C25760628;
        Thu, 10 Oct 2019 15:32:32 +0000 (UTC)
Date:   Thu, 10 Oct 2019 17:32:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 12/36] libperf: Add perf_mmap__read_event() function
Message-ID: <20191010153232.GA24818@krava>
References: <20191007125344.14268-1-jolsa@kernel.org>
 <20191007125344.14268-13-jolsa@kernel.org>
 <20191010144700.GB11638@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010144700.GB11638@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 10 Oct 2019 15:32:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:47:00AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
> > index ee536c4441bb..b328332b6ccf 100644
> > --- a/tools/perf/lib/include/internal/mmap.h
> > +++ b/tools/perf/lib/include/internal/mmap.h
> > @@ -11,6 +11,7 @@
> >  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
> >  
> >  struct perf_mmap;
> > +union perf_event;
> 
> Why are you adding this here?

oops, it should be in lib/include/perf/mmap.h ;-)
plz let me know if you want me to repost

thanks,
jirka
