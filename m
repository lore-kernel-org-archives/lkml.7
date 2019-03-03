Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A05FC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5D20857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551627132;
	bh=Tg5EurnMIMPdCMGc4aOuceSYhOJyeuFB7usfSgHjbW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EV216y7u6L9HKHy3xulta8BRGhPFggyRY+x+4N/frNnbbc2UQJNX2KibOpOlcETIt
	 uzU2z9P09Egcy5xnUODnaKSInHIGAVyJdLAzgItOzun0bjuDRQ6wbtTfLtGTdJ0pKL
	 aQ6rpoVFcQOAuFhi9IGlZx0We/zzzcM3poAD7aoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCCPcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:32:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C604020835;
        Sun,  3 Mar 2019 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551627129;
        bh=Tg5EurnMIMPdCMGc4aOuceSYhOJyeuFB7usfSgHjbW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBzkuHBwt2cetWX4bXDlSRviJqmL7toEn03Gx2iVvjd1V6zSmEpr+A8iUtvNAJea0
         +v0jS0ZUunYk0JWRnN0GSCUHGhG6q3YZRrHDMUHbAzgGDTA83aktQQH1KwXbkycNWd
         IFj5uVHsYzRuYJLD2UslSEj5De/W+AcVw8J2/uxw=
Date:   Sun, 3 Mar 2019 15:32:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings
 documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
Message-ID: <20190303153201.440ac325@archlinux>
In-Reply-To: <CAHp75VeMTd32S+bTgU2f1AS-NB67iuM+erT8qNJgPS7O0E1Cjg@mail.gmail.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <CAHp75VeMTd32S+bTgU2f1AS-NB67iuM+erT8qNJgPS7O0E1Cjg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:48:14 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 21, 2019 at 7:04 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > Fixes V2:
> > * make get_mount_matrix() functions more readable (use temp variable)
> >   (suggested by Jonathan and Andy)
> > * add these readability improvements also for ak8975 and mpu6050
> >   (suggested by Jonathan and Andy)
> > * squash bindings documentation into single commit for better discussion
> >   (suggested by Linus)
> > * FOR DISCUSSION: add some more clarifications to the bindings documentation
> >   and an attempt to define the magnetometer orientation
> > * add "iio: Allow to read mount matrix from ACPI" to the beginning of
> >   the series to make it compile
> >   (suggested by Andy)
> > * replace of_iio_read_mount_matrix() by iio_read_mount_matrix()
> >   (required by "iio: Allow to read mount matrix from ACPI")
> > * drop patch to convert bma180 to devm (potential race)
> >   (suggested by Jonathan)
> >
> > PATCH V1 2019-02-20 15:01:02:
> > This patch series adds the mount-matrix to several iio sensor drivers
> > used in handheld devices.
> >
> > The mount-matrix translates the quite arbitrary orientation of the sensor
> > on some printed circuit board to user-tangible orientation in handheld
> > devices that relates to typical screen orientation.
> >
> > There was a bindings documentation by Linus Walleij but the patch
> > did not make it into mainline. Therefore I resend it here.
> >
> > Next I have added some clarifications (at least I hope it clarifies)
> > in a second patch.
> >
> > Finally, the patch set implements the hooks for the mount matrix
> > in several iio drivers: bmc150, bma180, bmg160, itg3200, hmc5843.
> > This includes also one patch for the bma180 to convert it to devm API.
> >
> > We use them in different variants of the omap3-gta04 so a separate
> > patch set will provide device tree additions for them.
> >  
> 
> Thank you, it looks nice.
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

Thanks to Linus and Andy for reviews.
I've picked up all but they documentation patch.  I think
it is 'very nearly there', but would like a few really minor
tweaks.  Seemed silly to stall the other patches on that though!

Thanks,

Jonathan


