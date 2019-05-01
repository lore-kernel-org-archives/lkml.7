Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A48C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D18208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556721805;
	bh=9tKwT2ZeC17GLvXSsWU11ugdWuMsY2C1LDPUQq3hwHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jE8AZ7OXWIeYtomEfnxW6FYjO6o7KwRltDTi7lnYwVfp4vr6WmFiRYK35nMdSouJL
	 LTwnFrnsoRtkfnBMXaPoNmhlT3cN4a4bHO2NvfoeAXdi9wgX/5ta/eDbQx+sKO9l3n
	 EXmWmavuOthGc446XjztigXUxuPXu2QX0uHBtGPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfEAOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfEAOnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:43:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018F9208C3;
        Wed,  1 May 2019 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556721803;
        bh=9tKwT2ZeC17GLvXSsWU11ugdWuMsY2C1LDPUQq3hwHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR7CFsD4onkxGgtE4UEQ10n7C4WCv4ErBnknlGIDk/MLnq+5qZHdbEtBvFGmULhTN
         AniQ08W7pblt8CI8oxu7rDYDM9XF+3AO0fX+j1M4qv5FgFC/iUcTga0C7mW/8c1I9a
         cyL/u0KX5iuAQ9Q1b3QO431VH+W9XbGkvPP+57IM=
Date:   Wed, 1 May 2019 16:43:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
Message-ID: <20190501144321.GB31461@kroah.com>
References: <20190501140624.6931-1-TheSven73@gmail.com>
 <20190501142332.GA13008@kroah.com>
 <CAGngYiXAz-10BtMs6K1mNwHgakK=U80hX4+Cf6tG8Vc3Ag=NOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXAz-10BtMs6K1mNwHgakK=U80hX4+Cf6tG8Vc3Ag=NOA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:33:28AM -0400, Sven Van Asbroeck wrote:
> On Wed, May 1, 2019 at 10:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > I don't "trust" the gitlab infrastructure, sorry, and I don't think I
> > have a valid gpg signature from you anywhere :(
> 
> What infrastructure do you trust? GitHub?

Hahahahahahaha

Ah, good one...

No, definitely not gihub :(

I "trust" git.kernel.org and sometimes one other system (whatever the
drm developers use).

> Just in case I need this in the future - I really don't want to start
> a political thread :)

If you want a kernel.org account, so that you can have a development
tree there for future work, I suggest you apply for one.

thanks,

greg k-h
