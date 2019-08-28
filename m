Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E235EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE71420856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH1MJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:09:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41368 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1MJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:09:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id i4so2662881qtj.8;
        Wed, 28 Aug 2019 05:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uY/0QthbDm0KRk0gieS7xBLQazGhEOHEGV7wuOo/gng=;
        b=BGYAmdWj4B0XNk0rvMFA8tozmwzlR/M2xf3gkPNBZ4Q75U4KsbWj7RWdimXtUWgmaF
         2AwdsadbK+097tHgmE8MeraL+TJquf7NML3n6UnH6caAWoMhXoWiQ7X8QCqOWOxmY+km
         Ks8aHnGFPHX8hYOHJx/jL7wykxOrVaksZ5minRY1ssfEqfduZd5F2AgrutHiSytCg9Jz
         XuujESQpo1AovCoC1gz9ZTswRCpm+f+FHkZ3tlnNgwlXdakP7TRvPR/xIaUViQKJ3Oq7
         v1VoXrxUGM4jHtuQ1x4Fx7R3QWUUk9OwW4HSz5STfHavQRcLkLBfPLJPkYG0nx+YGQu0
         W2jg==
X-Gm-Message-State: APjAAAXFfGVzyYZeZLZ8inEwAeyrhU8MsJtchiL1dbBtcevg7RiADsA4
        8i1NWcyG7LBgCu7EmnpV7hOh+mndbdyB84HZENg=
X-Google-Smtp-Source: APXvYqxPjCZy8Yr70wpAUsKG4hqpSsecPtkX5jagW7DEkIoSG6k0GIS1TjLQmGSzQOE2w0NAJB8sdbquABde5znr26Y=
X-Received: by 2002:ad4:45c7:: with SMTP id v7mr2362538qvt.63.1566994166270;
 Wed, 28 Aug 2019 05:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190827154851.10486-1-enric.balletbo@collabora.com>
 <20190827161045.GC26807@tuxbook-pro> <CAK8P3a2h2gUhxcVgD5JhR1Uo4qUSuG5yp4RCrAxevNmyD4ZRTA@mail.gmail.com>
 <2db6cde1-9e7f-8b1c-f2e4-80bdd2478d28@collabora.com>
In-Reply-To: <2db6cde1-9e7f-8b1c-f2e4-80bdd2478d28@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 14:09:10 +0200
Message-ID: <CAK8P3a3zYpgouGAibyMjDykZmy+ABnx6AD2cYpHnXq9Zsw2V=w@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: defconfig: Update configs to use the new
 CROS_EC options
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        SoC Team <soc@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Yannick Fertr?" <yannick.fertre@st.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:10 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> On 27/8/19 18:12, Arnd Bergmann wrote:
> > On Tue, Aug 27, 2019 at 6:08 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> >>
> >> On Tue 27 Aug 08:48 PDT 2019, Enric Balletbo i Serra wrote:
> >>
> >>> Recently we refactored the CrOS EC drivers moving part of the code from
> >>> the MFD subsystem to the platform chrome subsystem. During this change
> >>> we needed to rename some config options, so, update the defconfigs
> >>> accordingly.
> >>>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> >>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> >>
> >> Can we make the entries in the generic arm64 defconfig modules?
> >
> > Good idea.
> >
> > Actually I would prefer to have all of them as modules for consistency,
> > if at all possible.
> >
>
> It is very common boot Chromebooks from an USB device, the EC needs to be
> built-in in order to boot from these devices, otherwise you should use an
> initramfs. I'd like to avoid forcing people to build an initramfs just to boot
> from these devices if possible, in fact, my usual workflow is without initramfs,
> and knowing that with the default defconfig just should boot helps a lot sometimes.
>
> Note that, it's not the case for EC subdevices, these are already build as modules.

Ok, fair enough, let's leave it built-in then.

> BTW, Lee asked if this patch should be squashed with the patches that really
> renames the config options to help bisect ability, I don't have a hard opinion
> as I don't usually run the config option between bisection steps, so please let
> me know what do you prefer and I'll respin the patches ASAP if that's the case.

I'm not usually worried about bisection in defconfig changes, since like you
say most commonly one would not run 'make defconfig' betweens the
bisection steps.

If we really care about it, we could keep a symbol like this
in drivers/platform/chrome/Kconfig for one release:

config CONFIG_MFD_CROS_EC
        tristate "Enable ChromeOS Embedded Controller"
        select CROS_EC
        select CHROME_PLATFORMS
        select CONFIG_MFD_CROS_EC_DEV
        help
           This is a transitional Kconfig option and will be removed
           after everyone enables the parts individually.

      Arnd
