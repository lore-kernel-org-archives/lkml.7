Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA2FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F24217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfEXCbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbfEXCbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:31:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F91121773;
        Fri, 24 May 2019 02:31:16 +0000 (UTC)
Date:   Thu, 23 May 2019 22:31:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH selftests 0/2] Add checkbashisms meta-testcase
Message-ID: <20190523223114.4feb6239@oasis.local.home>
In-Reply-To: <20190323192746.59739e5e9ea0445791ac14ed@kernel.org>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
        <20190323192746.59739e5e9ea0445791ac14ed@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shuah,

Want to take this or would you want me to?

-- Steve


On Sat, 23 Mar 2019 19:27:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Shuah,
> 
> Could you pick this to your tree? I think this can prevent further
> simillar errors before release...
> 
> Thank you,
> 
> On Fri, 22 Feb 2019 10:26:27 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here are patches for making sure the ftracetest testcases
> > are checkbashisms clean.
> > 
> > This actually needs a patch from Juerg, "selftests/ftrace:
> > Make the coloring POSIX compliant" to complete the work.
> > 
> > http://lkml.kernel.org/r/20190220161333.28109-1-juergh@canonical.com
> > (Note that this is still under development)
> > 
> > So as Juerg pointed, recently ftracetest becomes not POSIX
> > compliant, and such kind of issues happened repeatedly.
> > To avoid those anymore, I decided to introduce a testcase
> > which runs checkbasisms on ftracetest and its testcases.
> > I think this can help us to find out whether it was
> > written in a way out of POSIX.
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (2):
> >       selftests/ftrace: Make a script checkbashisms clean
> >       selftests/ftrace: Add checkbashisms meta-testcase
> > 
> > 
> >  tools/testing/selftests/ftrace/ftracetest          |    1 +
> >  .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    2 +-
> >  .../selftests/ftrace/test.d/selftest/bashisms.tc   |   21 ++++++++++++++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>  
> 
> 

