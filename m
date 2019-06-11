Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20198C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CCA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405424AbfFKPr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbfFKPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DBD530044CA;
        Tue, 11 Jun 2019 15:47:28 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-33.phx2.redhat.com [10.3.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2758600CC;
        Tue, 11 Jun 2019 15:47:26 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id CA27C11B; Tue, 11 Jun 2019 12:47:22 -0300 (BRT)
Date:   Tue, 11 Jun 2019 12:47:22 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf script/intel-pt: set synth_opts.callchain for
 use_browser > 0
Message-ID: <20190611154722.GC13332@redhat.com>
References: <20190610234216.2849236-1-songliubraving@fb.com>
 <def87b9f-a4fa-37ff-722a-9f14b14b2c7b@intel.com>
 <F8963F4B-46FF-41D2-B261-6DD2EE898D93@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8963F4B-46FF-41D2-B261-6DD2EE898D93@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 11 Jun 2019 15:47:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 11, 2019 at 07:18:09AM +0000, Song Liu escreveu:
> 
> 
> > On Jun 10, 2019, at 11:45 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > On 11/06/19 2:42 AM, Song Liu wrote:
> >> +++ b/tools/perf/util/intel-pt.c
> >> @@ -2588,7 +2588,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
> >> 	} else {
> >> 		itrace_synth_opts__set_default(&pt->synth_opts,
> >> 				session->itrace_synth_opts->default_no_sample);
> >> -		if (use_browser != -1) {
> >> +		if (use_browser > 0) {

> > That code has changed recently.  Refer:

> > 	https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=26f19c2eb7e54
 
> Thanks for a better fix! I was using Arnaldo's perf/urgent branch, and missed
> this one. 

Your report shows this one should move to perf/urgent, will try to do
that after processing a large perf/core batch...

- Arnaldo
