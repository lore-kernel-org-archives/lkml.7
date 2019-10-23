Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2AACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60E20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392075AbfJWNgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:36:09 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389807AbfJWNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:36:08 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMGZS-1igRY912gQ-00JNsX; Wed, 23 Oct 2019 15:36:07 +0200
Received: by mail-qk1-f180.google.com with SMTP id a194so15664356qkg.10;
        Wed, 23 Oct 2019 06:36:06 -0700 (PDT)
X-Gm-Message-State: APjAAAUs+06u4SNx39KClRYOpsTnfrvFRb9XBO/YIh26An3BB/kzEwwh
        bYGBVR4fTdXCelohvVrEfzWBgbptP7y61NCK43g=
X-Google-Smtp-Source: APXvYqwqW5j67aigUtbaQwMvvZPaRM75Zx1vwHK4rpCvIcwvfeEYCvDuZFw2giioKFckU9rb9ypL7pHNYyg0dml8Ps0=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr9047061qte.142.1571837765100;
 Wed, 23 Oct 2019 06:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-28-arnd@arndb.de> <20191023131321.GH11048@pi3>
In-Reply-To: <20191023131321.GH11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:35:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a03JtFrCYFUQAFnSENghrXSCDBQXB-QfiDG3yTxXxdpaw@mail.gmail.com>
Message-ID: <CAK8P3a03JtFrCYFUQAFnSENghrXSCDBQXB-QfiDG3yTxXxdpaw@mail.gmail.com>
Subject: Re: [PATCH 28/36] fbdev: s3c2410fb: remove mach header dependency
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dlcVjROea1jaoI1MdzPRxFVjhVzRcIC5nkL5pQCG9c45CBvt/Gw
 OtS9RyEw9Wl+/QXCFcTyHcQMzd/kSbVdMywUxqWJw7PBsf3xheHztLfkvmMef+6rB5f7XYD
 /wypCgz03sZllX8iYByJGqCmIUTWHW6TPGSiQfO0sUcn6Xc1mp2mcMglRC9PpdWFJFEDpOm
 s+GIC3mT/30V55XKx434g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SlBXf2eBKF8=:LpnGX2aRKKhX+6Ax5hvUbj
 RP/UDtVFQ4CgxwMrzqfiKPJkWvny8Z0/R9H0m5Bqp2PeRqPVZCAOQ2pc0Gex5YkqWhsbqv7At
 srpiYCqw3yPZDMvr88lHykMICXKXo/LE0++1APDBQw9fL9pcwqWhCV48GVPlH8ifb15ihMvXH
 4/KDZSw3yTUyvP/p1H67XmJp1jwZZDUJ2OpsEm4jwGxk+fX/F8kR0FSk60wLMnvT98MK8b2+i
 QAFoZUHlVdwcf04eSa0jCr6rOo8mrmH0SzjpKUmfsS9KXsXPcdm3BsA7EbuaLBfmgKZhea1D6
 cyhZPK4e6Dnfzsl8GmWxC6t0yVaFhNDj/5CcH4QzwSV74tX3urzqXC9hb/xH1shGi/XQm7D3d
 bq6PFa9Fhy795yfhUIG6ws8qk9gQKW2rtDg9WMXpeaUPJqbItjT+LGN+Byt0kK0HPwUtWS8d0
 FnVH+tA+VpSBR9cPbMGU2LEJIeiXVk0/L7tTYslYYnTGjZr9VjA+O3Pft5pPaSEV+1sxMHzRq
 hl5vin0aqfPk6RkNWHvqrL/omUGzLE9mPNq0hywEMkyG6n4G74bgN5tgf3Cli2Pa/IrXL6p2w
 vHlnf76tnf34Aj6Z4Aq12PR4rgC/bxe58YVqlF2WhfNgzU1EYDN9tr4NPyTekO26fzrzeD3LW
 x8Vl/W8hfAgUzYesNEN9UJZ6u496nXVieIBUbBWCHT3HwqzlHK97MSSDF7QcFRX185C6nOw4W
 ZwIjzC1VNizQYPonXkpiDX8Cb9GSYkbUjArBdKKAqNGRF1Xt8XC/LOx1tVORgmYdaBiEakrWu
 meRx9kHAMRafEfqq2gQPp9euWpIDeUnG1xjAVBkHWaXXUboEVAumYTPUUx4vqB5bJx9Q20ZsD
 QL3BGk5AOyeSPKwFkSVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:30:12PM +0200, Arnd Bergmann wrote:

> > @@ -321,6 +320,7 @@ static struct s3c2410fb_mach_info jive_lcd_config = {
> >        * data. */
> >
> >       .gpcup          = (0xf << 1) | (0x3f << 10),
> > +     .gpcup_reg =    S3C2410_GPCUP,
>
> Nits: indentation before/after '=' looks wrong. Tab should be
> before '=', one space after.

Ok, fixed now for the four boards that had inconsistent indentation --
jive, mini2440, smdk2440, and rx1950. Unfortunately each board
seemed to have its own way of doing this.

      Arnd
