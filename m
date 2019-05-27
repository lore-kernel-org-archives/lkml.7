Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10990C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0C2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE0J2I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:28:08 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34671 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfE0J2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:28:07 -0400
Received: from xps13 (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EC5A420000F;
        Mon, 27 May 2019 09:28:03 +0000 (UTC)
Date:   Mon, 27 May 2019 11:28:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Jeff Kletsky <lede@allycomm.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
Message-ID: <20190527112802.08b86fa5@xps13>
In-Reply-To: <34004a59-5643-e405-13ca-3581659fc745@kontron.de>
References: <20190522220555.11626-1-lede@allycomm.com>
        <20190522220555.11626-4-lede@allycomm.com>
        <e438022f-3444-9aae-adac-2dd3dd0071b7@kontron.de>
        <e0682730-b69d-d774-d98f-53858e390d8b@allycomm.com>
        <34004a59-5643-e405-13ca-3581659fc745@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 27 May
2019 06:35:59 +0000:

> Hi Jeff,
> 
> On 24.05.19 02:12, Jeff Kletsky wrote:
> > (reduced direct addressees, though still on lists)
> > 
> > On 5/22/19 11:42 PM, Schrempf Frieder wrote:
> >   
> >> On 23.05.19 00:05, Jeff Kletsky wrote:  
> >>> From: Jeff Kletsky <git-commits@allycomm.com>
> >>>
> >>> The GigaDevice GD5F1GQ4UFxxG SPI NAND is in current production devices
> >>> and, while it has the same logical layout as the E-series devices,
> >>> it differs in the SPI interfacing in significant ways.
> >>>
> >>> This support is contingent on previous commits to:
> >>>
> >>>     * Add support for two-byte device IDs
> >>>     * Define macros for page-read ops with three-byte addresses
> >>>
> >>> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
> >>>
> >>> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>  
> >> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>  
> >>> Reported-by: kbuild test robot <lkp@intel.com>  
> >> I dont't think that this Reported-by tag should be used here. The bot
> >> reported build errors caused by your patch and you fixed it in a new
> >> version. As far as I understand this tag, it references someone who
> >> reported a flaw/bug that led to this change in the first place.
> >> The version history of the changes won't be visible in the git history
> >> later, but the tag will be and would be rather confusing.  
> > 
> > Thank you for your patience and explanations. I've been being conservative
> > as I'm not a "seasoned, Linux professional" and am still getting my
> > git send-email config / command line for Linux properly straightened out.  
> 
> Being conservative in such cases is not a fault at all. I'm not an 
> expert either. I'm just recommending what I think might be the "correct" 
> way to do it.
> 
> > Should I send another patch set with the `kbuild...` tag removed,
> > or would it be removed in the process of an appropriate member
> > of the Linux MTD team adding their tag for approval, if and when
> > that happens?  
> 
> I don't think that's necessary. Miquèl is the one to pick up the patch, 
> so he could probably drop the "Reported-by: kbuild" when he applies it.

I will drop it.

Also, please do not add an empty line between tags, they should be a
single block. I will also modify your commits for this time.

Thanks,
Miquèl
