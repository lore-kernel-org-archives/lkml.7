Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A40C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0194321773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553754598;
	bh=ukCG6zxy2vntRW8cZqv7qCBpM5TvSlSz0njnZXYpz4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n3S4bEuUly5MGdESC3ib5uDl5V1CH5pTJ0E2kvga0yXHEiGq0Z2LoCGk8pZwFB+LI
	 eCkNO2yqduJOTwCBiGqiqNVYO7irpuvprky3enMIHyd4mSfjCrAhmaBk7LqM295IUh
	 Xn/2jN/vil8Hm/sUPoEG4ewIQOWfmW7QWEr/x1FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfC1G34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfC1G34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:29:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30D720811;
        Thu, 28 Mar 2019 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553754595;
        bh=ukCG6zxy2vntRW8cZqv7qCBpM5TvSlSz0njnZXYpz4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlQIBDbgAsbb7bjX8PbF7mqzRYN/MvVrvMmrGdD5igNHlfC3sZRQUjc9I65ZUlm0U
         UNfwUVNSnWLSz4WoFAuzwMW1HNJXS670Yx8BpriamJ+gc84Zqaq0tVZ4VdGTgE8vHc
         tDt5empFKL5ujXEMP8nCRjOmzV5VzZXfMnZhKxsY=
Date:   Thu, 28 Mar 2019 07:29:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull v2] habanalabs fixes for 5.1-rc3
Message-ID: <20190328062951.GA24619@kroah.com>
References: <20190326081335.GA4175@ogabbay-VM>
 <20190327010901.GA30198@kroah.com>
 <CAFCwf135COOzZmtJEGUFhJaOdBpETLB6VnSmXRabBtyLs3f6Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf135COOzZmtJEGUFhJaOdBpETLB6VnSmXRabBtyLs3f6Kg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:09:13AM +0200, Oded Gabbay wrote:
> On Wed, Mar 27, 2019 at 3:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 26, 2019 at 10:13:35AM +0200, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > A couple of important fixes for habanalabs driver:
> > >
> > > - Fix host crash upon resume after suspend
> > > - Fix MMU related bugs which result in user's jobs getting stuck
> > > - Fix race between user context cleanup and hard-reset which results in
> > >   host crash
> > > - Fix sparse warning
> >
> > Much better, thanks, now pulled and pushed out.
> >
> > greg k-h
> 
> Hi Greg,
> In which branch do I see that ? I tried to find it in your char-misc
> repo but couldn't find it.

It should be in the char-misc-linus branch of the char-misc.git repo on
git.kernel.org.  Note, I was in the air for a long time yesterday, so
the emails probably went out 8 hours before I was able to push out the
git repo, but it should all be synced up now.  Sorry for any confusion
there.

greg k-h
