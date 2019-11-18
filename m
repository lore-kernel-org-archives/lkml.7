Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F75C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E8D22304
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574106018;
	bh=lALNLNHKbLarFmQFbxabtTEuqMU5yok9zA5BXn9uNZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oAbdc/GTvg3Ey+X2WUzKYR9M3vFPWpSoyFjAlXi9tyvirk8zL7sloQ6It8iwAZk/N
	 /VRC8X7F/+MmQPWOKmOf+mAcbZ0zBA6OxPiTGuuvd0lUiWieUYD9LibtVekjPncFXK
	 I8xkWgu2OS4RvaYuvMV1k8Nwki1bASD7mDGaBa1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfKRTkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfKRTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:40:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9EA222A7;
        Mon, 18 Nov 2019 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574106014;
        bh=lALNLNHKbLarFmQFbxabtTEuqMU5yok9zA5BXn9uNZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iULnfiZRncZXT1wdLSC9N/cmrBnpdDaxGz1vqxUFjhYrjG2wrBsDICJKIzKr2ah3K
         PC7op5otsD/S+I5XTjZ6z+FAMOpQqrOpWogHC4nTNB/+r/Etv122svvoWte0CVDisG
         TNUfFwTcOAY8On1gGQ08uZAw4lS5dEensszJNeUQ=
Date:   Mon, 18 Nov 2019 20:40:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix
 build warning
Message-ID: <20191118194010.GA606660@kroah.com>
References: <20191117202435.28127-1-sudipm.mukherjee@gmail.com>
 <20191118114657.GA228826@kroah.com>
 <1505628642.90849.1574081270290.JavaMail.zimbra@nod.at>
 <20191118202257.6cfd1a7e@xps13>
 <884028732.91086.1574105504462.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <884028732.91086.1574105504462.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:31:44PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > An: "richard" <richard@nod.at>
> > CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>, "Kyungmin Park"
> > <kyungmin.park@samsung.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Jiri Slaby" <jslaby@suse.com>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-serial"
> > <linux-serial@vger.kernel.org>
> > Gesendet: Montag, 18. November 2019 20:22:57
> > Betreff: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix build warning
> 
> > Hi all,
> > 
> > Richard Weinberger <richard@nod.at> wrote on Mon, 18 Nov 2019 13:47:50
> > +0100 (CET):
> > 
> >> ----- Ursprüngliche Mail -----
> >> >> I was not sure if this should have been two different patch, but since
> >> >> this will be fixing the same problem so it seems its better to have them
> >> >> in a single patch.
> >> >> 
> >> >>  drivers/mtd/nand/onenand/Makefile                     | 2 +-
> >> >>  drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
> >> >>  drivers/tty/serial/Makefile                           | 2 +-
> >> >>  drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
> >> >>  4 files changed, 2 insertions(+), 2 deletions(-)
> >> >>  rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
> >> >>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)
> >> > 
> >> > I can take this in the tty tree if the mtd maintainer gives an ack for
> >> > it...
> >> 
> >> Acked-by: Richard Weinberger <richard@nod.at>
> > 
> > If it is not too late, I am not a big fan of the new naming which is
> > rather not descriptive. Files in the onenand subdirectory are:
> > * onenand_<something>.c for the base files
> > * <vendor>.c for the vendors files (currently: omap2.c and samsung.c).
> 
> Well, I'm fine with the naming either way. :-)

If you want to rename the mtd driver later, that's fine, I'll take this
for now for 5.5-rc1 and you all can bikeshed it for 5.5-final :)

thanks,

greg k-h
