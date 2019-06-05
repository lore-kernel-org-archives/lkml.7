Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D7EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992D82075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEUcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:32:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:35696 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEUcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:32:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0D9FC2E6;
        Wed,  5 Jun 2019 20:32:51 +0000 (UTC)
Date:   Wed, 5 Jun 2019 14:32:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] Add a document on rebasing and merging
Message-ID: <20190605143249.768d4b36@lwn.net>
In-Reply-To: <20190605015456.GA2710@mit.edu>
References: <20190604134835.16fc6bfa@lwn.net>
        <20190605015456.GA2710@mit.edu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 21:54:56 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> FYI, it looks like your patch somehow got hit by your text editor (or
> MUA's) line wrapping...

Weird, I haven't had a problem like that in decades.  No idea what
happened here...

> > +
> > + - Realize that the rebasing a patch series changes the environment in
> > +   which it was developed and, likely, invalidates much of the testing
> > that
> > +   was done.  A rebased patch series should, as a general rule, be treated
> > +   like new code and retested from the beginning.  
> 
> Shouldn't "reparenting" be used in this paragraph?
> 
> I suppose if a patch is getting dropped or modified that can
> invalidate some of the testing (although it really depends on the
> nature of what's being dropped or modified).  And if it's just adding
> a Tested-by tag or a CVE number in the commit description, it's not
> going to invalidate any testing.

I had thought about it and chosen "rebasing", but I can change it.

> > +Another reason for doing merges of upstream or another subsystem tree is
> > to +resolve dependencies.  These dependency issues do happen at times, and
> > +sometimes a cross-merge with another tree is the best way to resolve them;
> > +as always, in such situations, the merge commit should explain why the
> > +merge has been done.  Take a momehnt to do it right; people will read those
> > +changelogs.  
> 
> It might also be useful to mention it might be useful to put the
> commits which are needed to solve the dependency problem on its own
> separate branch, based off of something like -rc2, and then each of
> the trees which need the prerequisite commits can merge in that
> branch.

That is (I think) in the following paragraph:

> Possible alternatives include agreeing with the maintainer to carry
> both sets of changes in one of the trees or creating a special branch
> dedicated to the dependent commits.

Perhaps that last line should read "...dedicated to the prerequisite
commits, which can then be merged into both trees" ?

Then perhaps I can finally declare victory on this thing? :)

Thanks,

jon
