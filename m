Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB00C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEAD214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfDWHXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:23:25 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4388 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:23:23 -0400
X-IronPort-AV: E=Sophos;i="5.60,384,1549954800"; 
   d="scan'208";a="30648803"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 23 Apr 2019 00:23:22 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Tue, 23 Apr 2019
 00:23:22 -0700
Date:   Tue, 23 Apr 2019 09:22:54 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the at91 tree
Message-ID: <20190423072254.qa772iolhha7xb6l@M43218.corp.atmel.com>
References: <20190423084042.29fd9c03@canb.auug.org.au>
 <CAK7LNAQWMVqbN9Bytz7WWrUvJ_fe8joUR+R4jmszV54pkucvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQWMVqbN9Bytz7WWrUvJ_fe8joUR+R4jmszV54pkucvyA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:27:52PM +0900, Masahiro Yamada wrote:
> External E-Mail
> 
> 
> On Tue, Apr 23, 2019 at 10:33 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the at91 tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > arch/arm/mach-at91/pm_suspend.S:17:10: fatal error: pm_data-offsets.h: No such file or directory
> >  #include "pm_data-offsets.h"
> >           ^~~~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   ab690fa1eb4b ("ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91")
> >
> > I used the version of the at91 tree from next-20190418 for today.
> 
> 
> Sorry, I missed to test the out-of-tree build.
> 
> -I $(srctree)/$(src) is not added
> when check-in assembly files include a generated header.
> (I think this should be automatically cared by Kbuild, though.)
> 
> 
> Ludovic,
> 
> Could you drop this patch for now?

Yes I dropped it from my PR for 5.2 and remove it from at91-next.

Regards

Ludovic
