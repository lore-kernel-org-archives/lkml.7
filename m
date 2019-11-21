Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C84EC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DDD2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574321264;
	bh=gPWdK3ZQs3w3pA48qJ20NHH19/TD+hbiKK+54x6ca3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I7GehOYiqVehHlAq0pzxMCe6L7XfHLPxDP5/GSnROY8kG37VQ3tnQ73I1r/NICAuK
	 fjd4dTMysVAlrh8leeu9wNK4eVdC1JzBLd9Fejl6XiiJmSWbPUeZnN8Nv7IjgPS1eU
	 +3lURmXBDilpQ77Bm5qcWJP10F66hDEmmLFcA3cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKUH1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUH1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:27:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BD02089D;
        Thu, 21 Nov 2019 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574321260;
        bh=gPWdK3ZQs3w3pA48qJ20NHH19/TD+hbiKK+54x6ca3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTdxGys+fI/YWmhs8ajHyqe9MpZFOMqsSpbZM4ITK0fB17xJiuhgJvs1fxMLYpCvf
         82lTIevOKs+X04tx7NsT34LTKYCScq8DKhMoySraei9v6CsowPflU/BOZu2x2R4Hh7
         1jj4m0+06Cvw+2SmBRdkw30QwC1TqHDSmWmZ5vfs=
Date:   Thu, 21 Nov 2019 08:27:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: Fix Kconfig indentation
Message-ID: <20191121072738.GA368332@kroah.com>
References: <1574306408-20021-1-git-send-email-krzk@kernel.org>
 <20191121072124.GA356838@kroah.com>
 <CAJKOXPeW_ffza48Bbxm7Od-Xo_Vt-Qfy+8OY5w8AzZOPkxriXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPeW_ffza48Bbxm7Od-Xo_Vt-Qfy+8OY5w8AzZOPkxriXg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:22:27PM +0800, Krzysztof Kozlowski wrote:
> On Thu, 21 Nov 2019 at 15:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Nov 21, 2019 at 04:20:08AM +0100, Krzysztof Kozlowski wrote:
> > > Adjust indentation from spaces to tab (+optional two spaces) as in
> > > coding style with command like:
> > >       $ sed -e 's/^        /\t/' -i */Kconfig
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > ---
> > >
> > > Changes since v1:
> > > 1. Fix also 7-space and tab+1 space indentation issues.
> >
> > Same here, I already applied v1, so this one does not apply :(
> 
> Hi Greg,
> 
> I missed your notification that the patch was applied and then I
> worked on a updated version fixing few more whitespace errors (pointed
> during review on other patches). This supersedes v1 but if you do not
> want to rebase, I can send it later as a separate patch.

My public trees do not rebase, so I need a separate patch, thanks.

greg k-h
