Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A438C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CCD2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553929831;
	bh=n1UJNyJD6WX9teGOgHoazOVtC4JCle7jchmbzyr8Ljg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jiw6BQRV0OlguTZgmUDvsOd8NFm82dSRxfZ2Wq9DRZOOVC0z02Tv/+ye/5mFWLf+J
	 P5O9zs8jmxQZmWLV47FP10aJlU4LnM4Jgl8GXILjizddt12HXRwW4Yb9TwdgHjwW3C
	 bZNzsjqNaltFGcdgz7CluGNRZBje0IM4gi3SWSX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfC3HKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfC3HKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:10:30 -0400
Received: from localhost (unknown [188.90.30.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA66D2184C;
        Sat, 30 Mar 2019 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553929829;
        bh=n1UJNyJD6WX9teGOgHoazOVtC4JCle7jchmbzyr8Ljg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpfLna661LkeYwdQn6Ld/X6yiQ+0GsVzcYLXGd3IpefOHGNB4zWI+i+7cvYGPwbHx
         ROd4JJVqjO/J2J0Vq//Bb5JFgmdMZup30jKgKrtQOWMUpsnjTLkKnEBL1aEGwg2KrA
         WGJjbm7LbPYTYhg0/YFD116CCm0cBNUbaVni4CyI=
Date:   Sat, 30 Mar 2019 08:10:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Driver core fixes for 5.1-rc3
Message-ID: <20190330071025.GA5068@kroah.com>
References: <20190329193944.GA11609@kroah.com>
 <CAHk-=wggq+RYy1F1Ym0W3juRNsFAOgAun25uLxziwUpQAmNVPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggq+RYy1F1Ym0W3juRNsFAOgAun25uLxziwUpQAmNVPA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:14:03PM -0700, Linus Torvalds wrote:
> On Fri, Mar 29, 2019 at 12:39 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > After 5.1-rc1, all of the users of BUS_ATTR() are finally removed, so we
> > can now drop this macro from include/linux/device.h so that no more new
> > users will be created.
> 
> Note that a quick grep shows that it still exists in the Chinese
> translation of filesystems/sysfs.txt..

Yeah, I wasn't going to touch that :)

Usually the translations take a few versions to sync back up again, as
they watch the English version for changes.

> Also mentioned in a comment, but at least there it talks about the "old macro".

Yes, I had to "open code" it in one place so I tried to document why it
was done that way.

thanks,

greg k-h
