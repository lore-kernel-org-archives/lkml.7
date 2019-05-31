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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA4EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87AB2695F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559309042;
	bh=PdF02o/rD3t+wyvNrxQLq41/UX2h2s4D+ejyI1/rASw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJGui0JhW/DyPIFL+rcMUzCWVhU9SsrUOeJ++154+wUEep+qvlImEvuOiDICy6oGV
	 7tRYRgJz7KVpmUg4wy85kLKRlNzRRRacNTNTdtiZgscRJojjNeB+pLau/WJW7d1jBd
	 FFYBqpNcho4yPNLrpAAQL5Yunbf2mxO9gX5hu2h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEaNYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:24:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE85B26958;
        Fri, 31 May 2019 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559309040;
        bh=PdF02o/rD3t+wyvNrxQLq41/UX2h2s4D+ejyI1/rASw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfnWinhd9ehkso9a/1g8DKmRW3Alz36ju+PDqIVhVGE1tCmb4Qxk5jHdc9jY+QRXY
         2ka5ZfCmJxcfdP4tuqEzOuXr/iSTldqv3ye/bIBJyhBdxcCUuWbB005baLbg9LK0I4
         9VjeyhuKy9kLL5j6kbKcSjE/loqyMVS8FUPsV1E0=
Date:   Fri, 31 May 2019 06:24:00 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 1
Message-ID: <20190531132400.GA5518@kroah.com>
References: <20190531014808.GA30932@kroah.com>
 <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 09:17:06AM +0200, Geert Uytterhoeven wrote:
> Hi Greg, Thomas,
> 
> On Fri, May 31, 2019 at 3:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> >
> >   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-1
> >
> > for you to fetch changes up to 96ac6d435100450f0565708d9b885ea2a7400e0a:
> >
> >   treewide: Add SPDX license identifier - Kbuild (2019-05-30 11:32:33 -0700)
> >
> > ----------------------------------------------------------------
> > SPDX update for 5.2-rc3, round 1
> >
> > Here is another set of reviewed patches that adds SPDX tags to different
> > kernel files, based on a set of rules that are being used to parse the
> > comments to try to determine that the license of the file is
> > "GPL-2.0-or-later" or "GPL-2.0-only".  Only the "obvious" versions of
> > these matches are included here, a number of "non-obvious" variants of
> > text have been found but those have been postponed for later review and
> > analysis.
> >
> > There is also a patch in here to add the proper SPDX header to a bunch
> > of Kbuild files that we have missed in the past due to new files being
> > added and forgetting that Kbuild uses two different file names for
> > Makefiles.  This issue was reported by the Kbuild maintainer.
> >
> > These patches have been out for review on the linux-spdx@vger mailing
> > list, and while they were created by automatic tools, they were
> > hand-verified by a bunch of different people, all whom names are on the
> > patches are reviewers.
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I'm sorry, but as long[*] as this does not conform to
> Documentation/process/license-rules.rst, I have to provide my:
> NAked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> [*] The obvious solution is to update Documentation/process/license-rules.rst,
>     as people have asked before.

I don't understand, what does not conform?  We are trying _to_ conform
to that file, what did we do wrong?

thanks,

greg k-h
