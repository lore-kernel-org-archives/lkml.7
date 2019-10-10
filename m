Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3022C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfJJPPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:15:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37020 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:15:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIa9h-0005FP-MT; Thu, 10 Oct 2019 15:15:05 +0000
Date:   Thu, 10 Oct 2019 16:15:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Nathan Chancellor' <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
Message-ID: <20191010151505.GH26530@ZenIV.linux.org.uk>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
 <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
 <20191004194330.GA1478788@archlinux-threadripper>
 <d0944174abe24165ac5cb63c52b89c42@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0944174abe24165ac5cb63c52b89c42@AcuMS.aculab.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 01:11:46PM +0000, David Laight wrote:
> From: Nathan Chancellor
> > Sent: 04 October 2019 20:44
> ...
> > > IOW, the code should have just been
> > >
> > >         ret = test(umem_src == NULL, "kmalloc failed");
> > >         if (ret) ...
> > 
> > Yes, I had this as the original fix but I tried to keep the same
> > intention as the original author. I should have gone with my gut. Sorry
> > for the ugliness, I'll try to be better in the future.
> 
> This rather begs the question about why 'usercopy' is ever calling kmalloc() at all.

Do you even bother to read what you are commenting upon, or is it simply the
irresistable pleasure of being seen[*]?

When a function called 'test_copy_struct_from_user' starts with a couple of
allocations, one called 'umem_src' and another - 'expected', what could that
possibly be about?  Something to do with testing copy_struct_from_user(),
perhaps?  And, taking a wild guess, maybe allocating a buffer or two to
be somehow used in setting the test up?

Or you could just go and read the damn function, you twit.

[*] sensu Monty Python, if we are lucky enough
