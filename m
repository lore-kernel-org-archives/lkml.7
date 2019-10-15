Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE4DECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C066320663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfJOUXZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:23:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39422 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfJOUXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:23:24 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iKTLm-00085H-4l; Tue, 15 Oct 2019 22:23:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v7 0/6] tpm: Add driver for cr50
Date:   Tue, 15 Oct 2019 22:23:15 +0200
Message-ID: <11998737.dOvWaeisEJ@phil>
In-Reply-To: <20191014195607.GK15552@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org> <4042311.vcUrecXYXX@diego> <20191014195607.GK15552@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 14. Oktober 2019, 21:56:30 CEST schrieb Jarkko Sakkinen:
> On Fri, Oct 11, 2019 at 09:50:27AM +0200, Heiko Stübner wrote:
> > Am Montag, 7. Oktober 2019, 00:39:00 CEST schrieb Jarkko Sakkinen:
> > > On Fri, Sep 20, 2019 at 11:32:34AM -0700, Stephen Boyd wrote:
> > > > This patch series adds support for the H1 secure microcontroller
> > > > running cr50 firmware found on various recent Chromebooks. This driver
> > > > is necessary to boot into a ChromeOS userspace environment. It
> > > > implements support for several functions, including TPM-like
> > > > functionality over a SPI interface.
> > > > 
> > > > The last time this was series sent looks to be [1]. I've looked over the
> > > > patches and review comments and tried to address any feedback that
> > > > Andrey didn't address (really minor things like newlines). I've reworked
> > > > the patches from the last version to layer on top of the existing TPM
> > > > TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> > > > palatable than combining the two drivers together into one file.
> > > > 
> > > > Please review so we can get the approach to supporting this device
> > > > sorted out.
> > > > 
> > > > [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org
> > 
> > [...]
> > 
> > > OK, so, I put these to my master in hopes to get testing exposure.
> > > I think the changes are in great shape now. Thank you.
> > 
> > on a rk3399-gru-bob it works nicely for me, so
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Thank you! I updated my tree with your tag. Mind if I also add
> reviewed-by's?

I think I did spent enough time with the patches to warrant that, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Heiko


