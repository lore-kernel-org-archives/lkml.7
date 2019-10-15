Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3577C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17DE20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfJOGsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:48:11 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:60566 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJOGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:48:11 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2A815200A4D;
        Tue, 15 Oct 2019 06:48:09 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 6C9A08090E; Tue, 15 Oct 2019 08:48:01 +0200 (CEST)
Date:   Tue, 15 Oct 2019 08:48:01 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Michael ." <keltoiboy@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Morgan Klym <moklym@gmail.com>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>
Subject: Re: PCMCIA not working on Panasonic Toughbook CF-29
Message-ID: <20191015064801.GA104469@owl.dominikbrodowski.net>
References: <CAFjuqNh1=B7Ft6v7nzo3BW70EbAvK=Eko_4yqrJ4Z4N3w_Y+Xw@mail.gmail.com>
 <CAFjuqNjLJw8J0nU2oo8rDfDUBavHLC7D0=AAwM62tp6=kHHk-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFjuqNjLJw8J0nU2oo8rDfDUBavHLC7D0=AAwM62tp6=kHHk-A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:04:28PM +1100, Michael . wrote:
> Good afternoon kernel developers
> Please accept my apology for contacting you directly about this. A
> small group of friends, some of whom are CCed here, have come together
> to try and find a solution to a problem that originated with the
> demise of kernel 2.6:32. First some background to the issue. We are
> all users of Panasonic Toughbook CF-29 models (ranging from Mark 1
> through to Mark 5). These Toughbooks have 2 PCMCIA card slots which
> are used by a variety of people for different purposes. On the CF-29
> Mark 1 through to Mark 3 these slots work without problem. On the
> CF-29 Mark 4 and Mark 5 the last known kernel the top slot worked with
> was 2.6:32. This has been confirmed all all major distros by most of
> the small group of friends I mentioned earlier.
> 
> Thinking it was just a kernel config issue I did some comparisons
> between Debian 6 (Squeeze), Debian 7 (Wheezy), Ubuntu 10.04, and
> Ubuntu 10.10. On all machines both slots functioned as they should
> with Debian 6 and Ubuntu 10.04 but the top slot stopped working on
> Mark 4 and Mark 5 machines on the next release with the next kernel. I
> also tested Ubuntu 10.04 and 10.10 with the 2.6:32 and 2.6:35 kernel
> and both slots worked with the 2.6:32 kernel but not the 2.6:35
> kernel.With my comparisons I merged the config from 2.6:32 into the
> current kernel for Debian 4.19 and rebuilt the kernel, no matter what
> configuration changes I made the top slot still doesn't function on
> Mark 4 and Mark 5 machines.
> 
> This issue, and its apparent start, has been confirmed on all major
> distro family groups. So this brings me, actually the small group of
> dedicated Linux users who own Panasonic Toughbook CF-29s, to contact
> you to ask for help in resolving this issue. I have some questions,
> and I realise the 2.6:32 kernel is long gone now but I'm hoping this
> is not a lost cause, what changes would have occurred between 2.6:32
> and 2.6:33 that would have stopped the hardware working on Mark 4 and
> Mark 5 CF-29 Toughbooks but not Mark 1 through to Mark 3? Would it be
> possible to correct the problem so that the hardware on our machines
> works as it should. While we are not kernel devs or even programmers
> we are enthusiasts who love Linux and our machines and we are hoping
> that together with you and the kernel dev group we can fix this issue
> together.
> 
> I have attached various tar.gz files with ls* outputs so you can see
> the information we have so far. Thank you for taking the time to read
> this.

Is this with 16-bit PCMCIA cards, or with 32-bit CardBus cards? Either case,
please provide the output of

	dmesg

	lspci -vvv

and

	lspcmcia -v -v

(ideally all for a working and non-working configuration).

Thanks,
	Dominik
