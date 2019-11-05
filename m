Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF27CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9905204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfKEBbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:31:45 -0500
Received: from cynthia.allandria.com ([50.242.82.17]:50898 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfKEBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:31:45 -0500
X-Greylist: delayed 2300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 20:31:45 EST
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1iRn5y-0007nh-Q1; Mon, 04 Nov 2019 16:53:18 -0800
Date:   Mon, 4 Nov 2019 16:53:18 -0800
From:   Brad Boyer <flar@allandria.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
Message-ID: <20191105005318.GA29558@allandria.com>
References: <20191001073539.4488-1-geert@linux-m68k.org>
 <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org>
 <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com>
 <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:14:04AM +0100, John Paul Adrian Glaubitz wrote:
> On 11/4/19 12:06 PM, Geert Uytterhoeven wrote:
> > Amiga is fine.
> > 
> > Mac and Q40 are not, apparently.
> 
> I have not been able to come by a Q40 or 68k-Mac with an
> IDE controller, unfortunately.
> 
> If the Mac IDE controller is the same as on the PowerBook
> 3400c, I would be able to test a converted driver as I have
> that PowerBook.

I have a couple old macs with IDE. I have a PowerBook 190 and a
Performa (a 636? - it's buried away so I'm not 100% sure) both with
IDE drives. I'll try to find time to pull one of them out and see if
they still run. Can Linux run on a system with a 68LC040 these days?
I know there were issues with FPU emulation at various points. Both
of those would lack FPU due to using a 68LC040 chip.

The 3400c is PCI based and so probably isn't at all compatible. It
should be using the same driver as the other PCI models. There is
already a PATA_MACIO configuration option for that style. The 5300
is the one that's basically an upgraded 68k model (it's nearly
identical to the 190 internally).

	Brad Boyer
	flar@allandria.com

