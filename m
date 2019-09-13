Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C6C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930020693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbfIMPec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:34:32 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:56490 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388052AbfIMPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:34:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9637C182CED28;
        Fri, 13 Sep 2019 15:34:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet96_7e8e2efbebd31
X-Filterd-Recvd-Size: 2567
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 15:34:29 +0000 (UTC)
Message-ID: <595dffd5c7ba9196522319d2e087c9c1a8e67104.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Don't complain about nominal authors if
 there isn't one
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Sep 2019 08:34:28 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909131014410.1466-200000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1909131014410.1466-200000@iolanthe.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 10:22 -0400, Alan Stern wrote:
> On Thu, 12 Sep 2019, Joe Perches wrote:
> 
> > On Thu, 2019-09-12 at 16:55 -0400, Alan Stern wrote:
> > > checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
> > > nominal patch author" if there is no nominal patch author.  Without
> > > this change, checkpatch always gives me the following warning:
> > > 
> > >         WARNING: Missing Signed-off-by: line by nominal patch author ''
> > 
> > When/how does this occur?  Example please.
> 
> The patch itself is a good example.  Attached to this email is the
> patch file in the form I keep it (from quilt, not git; note that quilt
> doesn't do a good job of handling the "---" line so I leave it out and
> insert it when submitting the patch).  Try saving the attachment and
> running it through checkpatch.pl.  Here's what I get:

Andrew?

Does checkpatch emit this warning for you on
your quilt content?

If so, how do you handle it?

> $ scripts/checkpatch.pl /tmp/checkpatch-author-fix.patch 
> WARNING: Missing Signed-off-by: line by nominal patch author ''
> 
> total: 0 errors, 1 warnings, 8 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> /tmp/checkpatch-author-fix.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> Would you like me to resubmit the patch with this example added to the
> patch description?
> 
> Alan Stern

