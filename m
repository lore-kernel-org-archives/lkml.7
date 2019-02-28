Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30180C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ADB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368279;
	bh=d9Fnt7h8JVsgePf/Xp/5197DVDsk15WNv/erwfjZqyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vLO9x0BxwdIUhbKOoAHkDrEoNuAE3aQPSHAo3IMy6lky7G1Yc1CVa5Pekf7i2Ijpi
	 ICw05ScrWZuhQ+cJkCl3W377UtzeojjRy4cbkgS8HKbPn44Ca44YsbdZgu258X1XLw
	 cjQoRQp8+nkQrDpMHrWZUKgWXQ1UoZtGPP0W7AKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfB1Ph5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732208AbfB1Ph4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:37:56 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FA5218D9;
        Thu, 28 Feb 2019 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551368275;
        bh=d9Fnt7h8JVsgePf/Xp/5197DVDsk15WNv/erwfjZqyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qatioSbEHWqtsTDpJORUjJz0D1kSBOB6Os61XglmPXRR5qhbi9rp2Ig0mzG7Kr6nT
         dVtrfMNFfnLygjqmUJGKKiY+lJYCxboroT3zqrEBLr/Ep6K/FYbYNB0lDRd0nwH1gE
         8Dhi4HtdQxRF/xU8uydpdfhXXKz6wF6R0+GfeGwY=
Received: by mail-qt1-f170.google.com with SMTP id u7so14751027qtg.9;
        Thu, 28 Feb 2019 07:37:55 -0800 (PST)
X-Gm-Message-State: APjAAAVuZq9FsqWhE8a1EtDbe9WgmuciCk+P1xFDHKJX2bzrcQ/BLJY6
        xcQfGwqDIcA1o/OwklhpStPeHu1ZU4Rmg5buAg==
X-Google-Smtp-Source: APXvYqx9QcG+QKclLDKNC4bwxAoXMtgqvzvQbLRUOLlwSeWtXHH49hDWkAeqxI8e2DKOMhViR3JpoVBytrPjYs1/cpw=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr6962500qvq.106.1551368274651;
 Thu, 28 Feb 2019 07:37:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <20190223003041.GA16670@bogus> <20190228064923.GA3773@localhost.localdomain>
In-Reply-To: <20190228064923.GA3773@localhost.localdomain>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Feb 2019 09:37:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBUyygGu9FRb+hye+1DyRgdATm_64+XfsvwEa8AvZhJg@mail.gmail.com>
Message-ID: <CAL_JsqKBUyygGu9FRb+hye+1DyRgdATm_64+XfsvwEa8AvZhJg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/13] devicetree: bindings: Document first ROHM
 BD70528 bindings
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:49 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Rob, All
>
> Sorry for long delay - I was ill for a few days. Back at the business
> now =)
>
> Rob, maybe dropping the RFC tag has messed your book keeping? This
> is the latest version:
> https://lore.kernel.org/lkml/90c3b820baf072a7cc3a21aa50c661774a045158.1550148989.git.matti.vaittinen@fi.rohmeurope.com/
> and I thought it already had the Reviewed-by tag from you :)

I thought I ignored RFC tag, but could be that. My script (and memory)
aren't perfect.

> On Fri, Feb 22, 2019 at 06:30:41PM -0600, Rob Herring wrote:
> > On Tue, Jan 22, 2019 at 11:45:38AM +0200, Matti Vaittinen wrote:
> > > Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> > > drivers) and 4 GPIO pins which can be configured for I/O or
> > > as interrupt sources withe configurable trigger levels.
> >
> > 'dt-bindings: mfd: ...' for the subject.
>
> I see at least the patch subject comment is still valid though. Do you
> want me to change it and resubmit the series?

No, if that's the only thing, it's not important.

Rob
