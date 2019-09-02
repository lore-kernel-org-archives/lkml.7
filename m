Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0382173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfIBHjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:39:25 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:39637 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfIBHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:39:25 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x827dGbd055089;
        Mon, 2 Sep 2019 15:39:16 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id D72D1393744B8AE61146;
        Mon,  2 Sep 2019 15:39:16 +0800 (CST)
In-Reply-To: <CAFLxGvyAk33SZY2J-WYzKMW6N9mKiJ=y0XfmMd8RjUVV2Rp5vg@mail.gmail.com>
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw> <20190824130329.68f310aa@xps13> <OF22C5A579.E2E7676F-ON48258465.002F7F69-48258465.00322849@mxic.com.tw> <20190830115100.3fec9bf1@xps13> <OF08E1C5EC.4DAEB179-ON48258469.0025AFFA-48258469.0025D2F2@mxic.com.tw> <CAFLxGvyAk33SZY2J-WYzKMW6N9mKiJ=y0XfmMd8RjUVV2Rp5vg@mail.gmail.com>
To:     "Richard Weinberger" <richard.weinberger@gmail.com>
Cc:     "Boris Brezillon" <bbrezillon@kernel.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: D9829D6A:151B1372-48258469:0029F27D;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFD9829D6A.151B1372-ON48258469.0029F27D-48258469.002A0CDA@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 2 Sep 2019 15:39:18 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/09/02 PM 03:39:16,
        Serialize complete at 2019/09/02 PM 03:39:16
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x827dGbd055089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Richard,
 
> Subject
> 
> Re: [PATCH] Add support for Macronix NAND randomizer
> 
> On Mon, Sep 2, 2019 at 8:54 AM <masonccyang@mxic.com.tw> wrote:
> > > >                 nand@0 {
> > > >                         reg = <0>;
> > > >                         nand-reliability = "randomizer";
> > >
> > >                           mxic,enable-randomizer-otp;
> > >
> > > Would be better (with the proper documentation in the bindings).
> > >
> >
> > okay, thanks for your opinions.
> 
> Please document also when/why one wants to enable the randomizer.

okay, sure.

> 
> -- 
> Thanks,
> //richard

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

