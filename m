Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B3C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDF1216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852525;
	bh=jHLZ73c2oxXHBVT/gAxpI+H7/jWyuFVM1Lkpp+CXza8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a3JhLv9UgwrdHLNkpJd1nbU58/fKu+UPvULTW0VwsbLmNWmPrE/SGW5YOLv/SSsVL
	 s9OZMjmUPEMxgAaJRYD1S70OI5OyYb0kNMl/0TV/M8qFEOybCUB4VsaX/QQBpRZysn
	 9FxO8acwR2XuUJTGQ57vmwIowwg+7sORrHhUFiVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfI3OIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfI3OIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80FC221D56;
        Mon, 30 Sep 2019 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852523;
        bh=jHLZ73c2oxXHBVT/gAxpI+H7/jWyuFVM1Lkpp+CXza8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPtXgjmUPcTl/xsvQNrcPbqzJLxtBIYxMH8diXGxX81fKZWmR+tgRj+mpb9Tum0lB
         i4O4McIcZPIl5CUqp/c4M8/rvq+piENnouDYwmYeKnR3LGAR/hgswHrrh+6UqZV5sU
         4rezhyJnBSOdI6KOb3JU8Gs35cXjnxFV2aSa2dMg=
Date:   Mon, 30 Sep 2019 10:18:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC] Makefiles in scripts dir needs to move  one place
Message-ID: <20190930081816.GA2036553@kroah.com>
References: <20190930081041.GA11886@Slackware>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930081041.GA11886@Slackware>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 01:40:41PM +0530, Bhaskar Chowdhury wrote:
> 
> Hey Greg ,
> 
> Absolute trivialities, but might break few scripts, but make things
> clean..
> 
> We have so many *Makefile.* cluttering in the top level scripts dir.
> Can we please move those in one place, means create a dir and put all
> of them in it.

Why?  What would that help with?

> And call those in the scripts with that dir preceded . Kindly , let me
> know how awful that would be.

I can not parse these sentances, sorry.

greg k-h
