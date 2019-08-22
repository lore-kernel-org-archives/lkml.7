Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2423407
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfHVOI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:08:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45043 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbfHVOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:08:26 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7ME87e2032076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 10:08:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3493342049E; Thu, 22 Aug 2019 10:08:07 -0400 (EDT)
Date:   Thu, 22 Aug 2019 10:08:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Sebastian Duda <sebastian.duda@fau.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: Status of Subsystems
Message-ID: <20190822140807.GA2730@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
 <20190820171550.GE10232@mit.edu>
 <57a7ae11-282f-8b93-355c-4bc839f76b23@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a7ae11-282f-8b93-355c-4bc839f76b23@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 02:10:13PM +0200, Enrico Weigelt, metux IT consult wrote:
> 
> > We certainly don't talk about "inheritance" when we talk about
> > maintainers and sub-maintainers.
> 
> What's the exact definition of the term "sub-maintainer" ?
> 
> Somebody who's maintaining some defined part of something bigger
> (eg. a driver within some subsystem, some platform within some
> arch, etc) or kinda deputee maintainer ?

"It varies".  That was my whole point.

And there are some files, such as fs/fs-writeback.c which is rarely
touched by Al Viro (the fs maintainer) and mm/page-writeback.c (which
is rarely touched by the MM maintainers).  Both of these files are
related to writeback of buffered writeback, and the people who touch
are a smaller set of file system maintainers, and discussions
generally happen on linux-fsdevel.

Which git trees these changes go up through are also not necessarily
as specified by the maintainers files, for a number of reasons,
including avoiding git merge conflicts.

There is a desire to document more of these branch specific issues
(for example, the Networking branch has very specific times when
patches will be accepted for review) but that's a work in progress.
And I think a lot of people have been nervous about documenting
things, since once documented, there are process mavens will say, "you
documented it as FOO" and now you are doing BAR and complain that it's
a process violation, when in fact all rules have exceptions, and
sometimes those exceptions and when they get invoked are complicated.
Worse yet is when the documentation isn't precisely correct, and then
they get taken as gospel truth.

That doesn't mean we shouldn't document them, but a lot of care needs
to be taken.  It's also hard because the people who know the processes
the best are also some of the more busy people, and the downside if
the processes aren't documented *precisely* with most exceptions
documented, etc., are the same people.  (See the discussion over what
does "Reviewed-by" mean, and what meaning attaches to it as an example
where IMHO how it was used, and how it was documented, were not the
same thing.)

Cheers,

					- Ted
