Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B31C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D0421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfCUSSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:18:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:18:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02274AE30;
        Thu, 21 Mar 2019 18:18:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DFC9DA820; Thu, 21 Mar 2019 19:19:47 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:19:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Stable patches that don't apply to older kernels and how to get
 them
Message-ID: <20190321181946.GA28481@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Greg KH <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190321151413.GB8120@suse.cz>
 <20190321163941.GA11121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321163941.GA11121@kroah.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:39:41PM +0100, Greg KH wrote:
> On Thu, Mar 21, 2019 at 04:14:14PM +0100, David Sterba wrote:
> > Hi,
> > 
> > would it be possible to have a git repository with all patches that are
> > submitted to stable@ but don't apply directly?
> > 
> > I get notified by mail, that's fine though it's not that convenient to
> > see all the pending patches for backport to a given version.
> > 
> > My proposal:
> > 
> > - create a separate stable-unapplied git repository
> > 
> > - if a patch does not apply to a given version, it's stored as-is to a
> >   directory of the base version (like 4.4)
> > 
> > - once a fixed version is applied to stable-queue.git/released-4.4, the
> >   patch in the other repo is deleted
> > 
> > I believe this can be highly automated and once implemented would not
> > too much additional work to the stable workflow. I could possibly write
> > a scraper of the mail archives to pick the patches and manage the
> > repository but I think that a central repository could help other
> > maintainers too or to spread the load to all interested developers.
> > 
> > If something like that already exists, please let me know.
> 
> Nothing like this exists, sorry.
> 
> And if you want to automate this, wonderful, but I do not have any time
> to do so, and it does not fit into my workflow at all.  Patches that do
> not apply are the exception by far, not the rule, so I doubt this would
> really help out much.

I'm concerned about patches that are sent to sable but don't get applied
in the end. IOW dropped on the floor, unless somebody cares, which is
probably the maintainers that are known to be overloaded.

So, I'm looking for some kind of help, to extend the stable workflow and
address the problem where it happens and where the whole mail and git
machinery already is.

The number of unapplied patches has raised recently for me because I
started to closely examine which stable versions could be affected. And
go as far as 4.4.

Why there are otherwise only a few patches that don't apply, I can only
speculate and I think that differs by subsystem. That stable kernels are
potentially missing stability fixes should be a concern in general. But
well, it seems I have to help myself here.
