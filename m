Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BEC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086821881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfIBGxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 02:53:15 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:61357 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfIBGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 02:53:14 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x826r6WT086056;
        Mon, 2 Sep 2019 14:53:06 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 47C3EA819EB3BFC4B9A5;
        Mon,  2 Sep 2019 14:53:07 +0800 (CST)
In-Reply-To: <20190830115100.3fec9bf1@xps13>
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw>  <20190824130329.68f310aa@xps13>
        <OF22C5A579.E2E7676F-ON48258465.002F7F69-48258465.00322849@mxic.com.tw> <20190830115100.3fec9bf1@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: 08E1C5EC:4DAEB179-48258469:0025AFFA;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF08E1C5EC.4DAEB179-ON48258469.0025AFFA-48258469.0025D2F2@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 2 Sep 2019 14:53:08 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/09/02 PM 02:53:07,
        Serialize complete at 2019/09/02 PM 02:53:07
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x826r6WT086056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel, 

 
> > > > 
> > > > If subpage write not available with hardware ECC, for example,
> > > > NAND chip options NAND_NO_SUBPAGE_WRITE be set in driver and
> > > > randomizer function is recommended for high-reliability.
> > > > Driver checks byte 167 of Vendor Blocks in ONFI parameter page 
table
> > > > to see if this high-reliability function is supported.
> > > > 
> > > 
> > > You did not flagged this patch as a v2 and forgot about the 
changelog.
> > > You did not listen to our comments in the last version neither. I 
was
> > > open to a solution with a specific DT property for warned users but 
I
> > > don't see it coming.
> > > 
> > 
> > Based on your comments by specific DT property for randomizer support.
> > to add a new property in children nodes:
> > 
> > i.e,.
> > 
> > nand: nand-controller@43c30000 {
> > 
> >                 nand@0 {
> >                         reg = <0>;
> >                         nand-reliability = "randomizer";
> 
>                           mxic,enable-randomizer-otp;
> 
> Would be better (with the proper documentation in the bindings).
> 

okay, thanks for your opinions.

best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

