Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A794206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKMUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfKMUkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:40:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A732206D7;
        Wed, 13 Nov 2019 20:40:47 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:40:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Hewenliang <hewenliang4@huawei.com>, tstoyanov@vmware.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191113154044.5b591bf8@gandalf.local.home>
In-Reply-To: <20191113203710.GC3078@redhat.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
        <20191113144626.44ad5418@gandalf.local.home>
        <20191113203710.GC3078@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 18:37:10 -0200
Arnaldo Carvalho de Melo <acme@redhat.com> wrote:

> Em Wed, Nov 13, 2019 at 02:46:26PM -0500, Steven Rostedt escreveu:
> > On Fri, 25 Oct 2019 04:23:12 -0400
> > Hewenliang <hewenliang4@huawei.com> wrote:
> >   
> > > It is necessary to free the memory that we have allocated
> > > when error occurs.
> > > 
> > > Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
> > > Signed-off-by: Hewenliang <hewenliang4@huawei.com>  
> > 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Arnaldo,  
> 
> sure

I found an issue with it (if you didn't see the next email).

Please don't take it.

Thanks!

-- Steve

>  
> > Can you take this?
> > 
> > -- Steve
>
