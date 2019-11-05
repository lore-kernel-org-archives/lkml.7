Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF1CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB10214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfKEDUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 22:20:01 -0500
Received: from cynthia.allandria.com ([50.242.82.17]:50938 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfKEDUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:20:00 -0500
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1iRpNi-0008On-J7; Mon, 04 Nov 2019 19:19:46 -0800
Date:   Mon, 4 Nov 2019 19:19:46 -0800
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
Message-ID: <20191105031946.GA31507@allandria.com>
References: <20191001073539.4488-1-geert@linux-m68k.org>
 <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
 <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
 <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de>
 <20191105005318.GA29558@allandria.com>
 <alpine.LNX.2.21.1.1911051318590.160@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1.1911051318590.160@nippy.intranet>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:33:00PM +1100, Finn Thain wrote:
> All the PB 190 machines that I've come across have a late revision 68LC040 
> CPU that is free of errata. Please see,
> http://www.mac.linux-m68k.org/docs/faq.php#sec-4.5
> 
> The Performa 636 is highly likely to be affected, but you can run Linux 
> from initramfs to avoid page faults in code sections. That would allow you 
> to test the IDE driver.
> 
> Or you can just replace the CPU with a full 68040, since it is socketed. 

I'll try the PB190 first anyway. It should be easier due to not needing
to setup a monitor. I'm not sure if I ever booted Linux on either of
them, since I acquired both about the time I started getting too busy
to spend time on such things. I just found the Performa, and it's actually
a Performa 630CD but I don't see any obvious difference based on the specs.

I just took a look at the macide driver, and it appears to do basically
nothing other than pass a list of addresses into the core ide code. It's
one of the smallest drivers I've ever seen.

> But watch out for leaking capacitors and batteries...

I should pull out every machine in my collection and look for those sorts
of issues. None of them have been checked in at least 5 or 6 years.

	Brad Boyer
	flar@allandria.com

