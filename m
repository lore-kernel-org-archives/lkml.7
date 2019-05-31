Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5427C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE6A26B4B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315154;
	bh=WFrfHvtJS3nL9Vp6xST+zS7Jr7Hh5gBCa/wmWTVcIMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eFxDuUhPolD08XEwQpfNf7OZwmmwHmuIwtoHDbjuUuKGjD/vk6cDNtbKTy7pOtEYs
	 EydB5WZIkjdmyu4l8NchmBxNqUD2gbIhRY4zXPEKCYVJsUtErYXbSb1qxlL9DSP5sf
	 VMNKvc8B23sa2714FrtdlDAg6Rf92dfT+s12rTAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEaPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaPFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:05:53 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBAA25468;
        Fri, 31 May 2019 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315152;
        bh=WFrfHvtJS3nL9Vp6xST+zS7Jr7Hh5gBCa/wmWTVcIMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZQT866djhnsQQVQ7DjM+uWDYfulCLXeTTRZsmBZZRi3wNsk5wzr1w66jI+OSgu9k
         e78hW2BUG9ot7mdNZbamDZqERtTvKyrEsx2yQQOqT1tFTG4ySDHf2ZsfhPno/N6vZK
         Crymgzspi8mahiJKBzMbu0OJW0bmVhNnDmOOY+kc=
Date:   Fri, 31 May 2019 08:05:51 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 1
Message-ID: <20190531150551.GA4191@kroah.com>
References: <20190531014808.GA30932@kroah.com>
 <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
 <20190531132400.GA5518@kroah.com>
 <CAMuHMdX3vQN5tF4-_vGjRQGdbxpPC+u4g-QU45=qykNZgwSj_w@mail.gmail.com>
 <20190531140209.GA31961@kroah.com>
 <CAMuHMdUYTaDS+bJpchsUyc+xNPJeYoxQ3vozQUPH=gacFEcdFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUYTaDS+bJpchsUyc+xNPJeYoxQ3vozQUPH=gacFEcdFw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 04:58:22PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, May 31, 2019 at 4:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, May 31, 2019 at 03:51:18PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, May 31, 2019 at 3:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Fri, May 31, 2019 at 09:17:06AM +0200, Geert Uytterhoeven wrote:
> > > > > On Fri, May 31, 2019 at 3:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> > > > > >
> > > > > >   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> > > > > >
> > > > > > are available in the Git repository at:
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-1
> > > > > >
> > > > > > for you to fetch changes up to 96ac6d435100450f0565708d9b885ea2a7400e0a:
> > > > > >
> > > > > >   treewide: Add SPDX license identifier - Kbuild (2019-05-30 11:32:33 -0700)
> > > > > >
> > > > > > ----------------------------------------------------------------
> > > > > > SPDX update for 5.2-rc3, round 1
> > > > > >
> > > > > > Here is another set of reviewed patches that adds SPDX tags to different
> > > > > > kernel files, based on a set of rules that are being used to parse the
> > > > > > comments to try to determine that the license of the file is
> > > > > > "GPL-2.0-or-later" or "GPL-2.0-only".  Only the "obvious" versions of
> > > > > > these matches are included here, a number of "non-obvious" variants of
> > > > > > text have been found but those have been postponed for later review and
> > > > > > analysis.
> > > > > >
> > > > > > There is also a patch in here to add the proper SPDX header to a bunch
> > > > > > of Kbuild files that we have missed in the past due to new files being
> > > > > > added and forgetting that Kbuild uses two different file names for
> > > > > > Makefiles.  This issue was reported by the Kbuild maintainer.
> > > > > >
> > > > > > These patches have been out for review on the linux-spdx@vger mailing
> > > > > > list, and while they were created by automatic tools, they were
> > > > > > hand-verified by a bunch of different people, all whom names are on the
> > > > > > patches are reviewers.
> > > > > >
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > I'm sorry, but as long[*] as this does not conform to
> > > > > Documentation/process/license-rules.rst, I have to provide my:
> > > > > NAked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > >
> > > > > [*] The obvious solution is to update Documentation/process/license-rules.rst,
> > > > >     as people have asked before.
> > > >
> > > > I don't understand, what does not conform?  We are trying _to_ conform
> > > > to that file, what did we do wrong?
> > >
> > > The new "-or-later" and "-only" variants are not (yet) documented in that file.
> > >
> > >    File format examples::
> > >
> > >       Valid-License-Identifier: GPL-2.0
> > >       Valid-License-Identifier: GPL-2.0+
> > >       SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> > >       Usage-Guide:
> > >         To use this license in source code, put one of the following SPDX
> > >         tag/value pairs into a comment according to the placement
> > >         guidelines in the licensing rules documentation.
> > >         For 'GNU General Public License (GPL) version 2 only' use:
> > >           SPDX-License-Identifier: GPL-2.0
> > >         For 'GNU General Public License (GPL) version 2 or any later
> > > version' use:
> > >           SPDX-License-Identifier: GPL-2.0+
> >
> >
> > They do not have to be documented in that file.  As what you quoted
> > said, "File format examples::"
> 
> My bad, I should have quoted the syntax rule:
> 
>    License identifiers for licenses like [L]GPL with the 'or later' option
>    are constructed by using a "+" for indicating the 'or later' option.::
> 
>       // SPDX-License-Identifier: GPL-2.0+
>       // SPDX-License-Identifier: LGPL-2.1+
> 
> Yes, this also predates the notion of "-only", so that is not documented
> there.
> 
> > Please look in the files in the LICENSES directory for what all of the
> > documented identifiers should look like:
> >         $ head -n 4 LICENSES/preferred/GPL-2.0
> >         Valid-License-Identifier: GPL-2.0
> >         Valid-License-Identifier: GPL-2.0-only
> >         Valid-License-Identifier: GPL-2.0+
> >         Valid-License-Identifier: GPL-2.0-or-later
> 
> Oh, so we can no longer look it up in a single place :-(
> I'm used to grepping in Documentation/process/license-rules.rst,
> as I don't know the exact syntax by heart.

scripts/spdxcheck.py knows where to look (in the LICENSES directory),
and gets run by checkpatch.pl as well, so you shouldn't have to look
anything up, you can use the tools instead.

thanks,

greg k-h
