Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E15DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2920663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfJOU1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:27:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42068 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726776AbfJOU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:27:11 -0400
Received: (qmail 25917 invoked by uid 2102); 15 Oct 2019 16:27:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2019 16:27:10 -0400
Date:   Tue, 15 Oct 2019 16:27:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
In-Reply-To: <595dffd5c7ba9196522319d2e087c9c1a8e67104.camel@perches.com>
Message-ID: <Pine.LNX.4.44L0.1910151626080.1462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

Alan Stern

On Fri, 13 Sep 2019, Joe Perches wrote:

> On Fri, 2019-09-13 at 10:22 -0400, Alan Stern wrote:
> > On Thu, 12 Sep 2019, Joe Perches wrote:
> > 
> > > On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> > > > checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> > > > nominal patch author" if there is no nominal patch author.  Without
> > > > this change, checkpatch always gives me the following warning:
> > > > 
> > > >         WARNING: Missing Signed-off-by: line by nominal patch author ''
> > > 
> > > When/how does this occur?  Example please.
> > 
> > The patch itself is a good example.  Attached to this email is the
> > patch file in the form I keep it (from quilt, not git; note that quilt
> > doesn't do a good job of handling the "---" line so I leave it out and
> > insert it when submitting the patch).  Try saving the attachment and
> > running it through checkpatch.pl.  Here's what I get:
> 
> Andrew?
> 
> Does checkpatch emit this warning for you on
> your quilt content?
> 
> If so, how do you handle it?
> 
> > $ scripts/checkpatch.pl /tmp/checkpatch-author-fix.patch 
> > WARNING: Missing Signed-off-by: line by nominal patch author ''
> > 
> > total: 0 errors, 1 warnings, 8 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> > 
> > /tmp/checkpatch-author-fix.patch has style problems, please review.
> > 
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > 
> > 
> > Would you like me to resubmit the patch with this example added to the
> > patch description?
> > 
> > Alan Stern

