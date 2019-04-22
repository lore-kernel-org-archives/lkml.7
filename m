Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7AFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A0E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555926331;
	bh=HkRaglHQToLd5+Y09kTvOtcXq6Ba9PeyskQdeapyE68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oyLH+nj1wh0p8AKPGCj+7vZ36dIIcCc4SXtMTpSlmsCDwsNbwVbhP59DWgtLBrheZ
	 cbKNN0vVAGzG15ReT/j18eoJLmaxRRbT6BOYVoCi30baKjdPJIuy6Ogq8I7vmzrm75
	 yfn+7oiWLk7GxDaYMNStVF4ekLzws/5MwysMooUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDVJp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDVJp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:45:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83EC2075A;
        Mon, 22 Apr 2019 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555926328;
        bh=HkRaglHQToLd5+Y09kTvOtcXq6Ba9PeyskQdeapyE68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FxtSjqKU6OjGU2ZrB0ciQ/u9zNWDHhaF1vMIkx+BL/kCzCyS47ZcL/azuaN8xhxQ1
         awCzGDflLgGdmL4AlkSzBQZzFdic6yoUpDW8tUXcYFBFMU9wLxcGFzJaM5bjAWR5wJ
         YpGwVePqfOrH+2cG/mkwAl+FgLJNCthtsqX7fMRg=
Date:   Mon, 22 Apr 2019 10:45:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mohan Kumar <mohankumar718@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] drivers/iio/gyro/mpu3050-core.c: This patch fix
 the following checkpatch warning.
Message-ID: <20190422104523.4bfca4ad@archlinux>
In-Reply-To: <CACRpkdY5cX=aP9nNwWeUd0Nx33MS0QJDnLKzbajADRsKCUVbOA@mail.gmail.com>
References: <1555257218-3830-1-git-send-email-mohankumar718@gmail.com>
        <CACRpkdY5cX=aP9nNwWeUd0Nx33MS0QJDnLKzbajADRsKCUVbOA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 13:50:18 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Apr 14, 2019 at 5:53 PM Mohan Kumar <mohankumar718@gmail.com> wrote:
> 
> > As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> > up to 20ms. so use usleep_range.
> >
> > Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>  
> 
> All right, should work as fine.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks and applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Whilst we are here, there is a 'false' warning that we should clear up at
somepoint (from sparse)

CHECK   drivers/iio/gyro/mpu3050-core.c
drivers/iio/gyro/mpu3050-core.c:544:48: warning: incorrect type in assignment (different base types)
drivers/iio/gyro/mpu3050-core.c:544:48:    expected restricted __be16 <noident>
drivers/iio/gyro/mpu3050-core.c:544:48:    got int

Line in question is setting the __be16 value to 0xAAAA where endian choice has
no effect.  I'll send out the trivial 'fix' in a minute.  Give the compiler
can sort it out at build time it should make no actual difference.

Usual arguments apply for why we bother to suppress 'false' build warnings
like this...

Anyhow patch shortly.

Jonathan



> 
> Yours,
> Linus Walleij

