Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E5C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6659F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfH0HsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfH0HsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC0342A09AC;
        Tue, 27 Aug 2019 07:48:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77E495DAAF;
        Tue, 27 Aug 2019 07:48:03 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:48:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jonatan Corbet <corbet@lwn.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: BoF on LPC 2019 : Linux Perf advancements for compute intensive
 and server systems
Message-ID: <20190827074802.GA22896@krava>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
 <20190826135536.GA24801@kernel.org>
 <da687997-6280-2613-a389-f7b94c600c2b@linux.intel.com>
 <20190826175758.GH5447@tassilo.jf.intel.com>
 <20190826221021.GB21761@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826221021.GB21761@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 27 Aug 2019 07:48:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:10:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 26, 2019 at 10:57:58AM -0700, Andi Kleen escreveu:
> > > 
> > > > 
> > > > All those are already merged, after long reviewing phases and lots of
> > > > testing, right?
> > > 
> > > Right. These changes now constitute parts of the Linux kernel source tree.
> > 
> > Might be better to focus on future areas that haven't been merged yet.
> 
> Agreed, we can have a initial, short report on what has been done to
> address these issues, and I think Alexey could take care of that, but
> then we should try and list here what else in addition to what Ian et
> all listed on their talk.
> 
> And perhaps even things that ammeliorate the problems they list there,
> i.e. Ian, Stephane, the things that Alexey listed were already
> tested/considered by you guys?

there's also ongoing work on adding threads to perf record:
  https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/#t

currently being stuck on me sending the perf_sesion changes

Alexey ran some initial benchmarks and it seems to perform nicely,
not sure we discussed the results on list thought

jirka
