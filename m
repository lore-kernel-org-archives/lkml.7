Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5763C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2372206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfGaL6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfGaL6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:58:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03129206A3;
        Wed, 31 Jul 2019 11:58:38 +0000 (UTC)
Date:   Wed, 31 Jul 2019 07:58:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fgraph: Remove redundant ftrace_graph_notrace_addr()
 test
Message-ID: <20190731075837.6d2a3995@gandalf.local.home>
In-Reply-To: <20190731103143.ear4erai6yvt4ct6@mail.google.com>
References: <20190730140850.7927-1-changbin.du@gmail.com>
        <20190730121527.13f600f5@gandalf.local.home>
        <20190731103143.ear4erai6yvt4ct6@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 18:31:45 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Tue, Jul 30, 2019 at 12:15:27PM -0400, Steven Rostedt wrote:
> > On Tue, 30 Jul 2019 22:08:50 +0800
> > Changbin Du <changbin.du@gmail.com> wrote:
> >   
> > > We already have tested it before. The second one should be removed.
> > > With this change, the performance should have little improvement.
> > > 
> > > Fixes: 9cd2992f2d6c ("fgraph: Have set_graph_notrace only affect function_graph tracer")  
> > 
> > Thanks! I think this should even be marked for stable. Not really a bad
> > bug, but a bug none the less.
> >  
> Steven, need I resend this patch and cc stable mailist?
> 

No.

I actually already pulled it in and ran it through my tests. I'm
waiting on some more tests before pushing it off to Linus.

-- Steve
