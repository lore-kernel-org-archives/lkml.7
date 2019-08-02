Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A75C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3182121773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfHBJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:24:47 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:18765 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfHBJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:24:46 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x729OV9N012895;
        Fri, 2 Aug 2019 11:24:31 +0200
Date:   Fri, 2 Aug 2019 11:24:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
        linux-doc@vger.kernel.org, Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190802092431.GB12845@1wt.eu>
References: <20190725130113.GA12932@kroah.com>
 <20190802044908.GA12834@1wt.eu>
 <20190802065729.GA24024@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802065729.GA24024@kroah.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:57:29AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2019 at 06:49:08AM +0200, Willy Tarreau wrote:
> > Hi Greg, Thomas,
> > 
> > On Thu, Jul 25, 2019 at 03:01:13PM +0200, Greg Kroah-Hartman wrote:
> > > +The list is encrypted and email to the list can be sent by either PGP or
> > > +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> > > +certificate. The list's PGP key and S/MIME certificate are available from
> > > +https://www.kernel.org/....
> > 
> > Just thinking, wouldn't it be useful to strongly encourage that the
> > document should be in plain text format ? Otherwise the door remains open
> > for sending you a self-extractable EXE file which contains an encrypted
> > Word doc, which is not the most useful to handle especially to copy-paste
> > mitigation code nor to comment on. Even some occasional PDFs we've seen
> > on the sec@k.o list were sometimes quite detailed but less convenient
> > than the vast majority of plain text ones, particularly when it comes
> > to quoting some parts.
> 
> What document are you referring to here?  This just describes how the
> encrypted mailing list is going to work, not anything else.

I mean the document describing the issue that the reporter is going to
send to the mailing list.

> But yes, we have had some "encrypted pdfs" be sent to us recently that
> no one can decrypt unless they run Windows or do some really crazy hacks
> with the gstreamer pipeline.  But that's separate from this specific
> mailing list, we can always just tell people to not do foolish things if
> that happens again (like we did in this case.)

That was exactly my point :-)  Just like the process indicates what list
to contact to report an issue, it can also indicate the preferred way to
efficiently report these issues.

Willy
