Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8548C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8496D20673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgAHKd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:33:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:42961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAHKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:33:59 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MdNPq-1jOCQf1WKm-00ZM6v for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 11:33:57 +0100
Received: by mail-qv1-f42.google.com with SMTP id u10so1180888qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:33:57 -0800 (PST)
X-Gm-Message-State: APjAAAWi6W0wG7HQ7ieAwb7Jb5YLAorTtipbKgQNICRw8Fh9h9DjVXt0
        BRJTFZeFANvMKD3GCAHbnNlX/TiIv3gpPh7WSKI=
X-Google-Smtp-Source: APXvYqxXCQd6CIRrMcZAzZ7Jb6On5M7WksNLfnrFz14xSPP1bwLoo6JqWqEWphK9g72g0rLwxLfzVPITgsRsCo+vDTw=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr3277751qvp.210.1578479636142;
 Wed, 08 Jan 2020 02:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107203231.920256-1-arnd@arndb.de> <87zheyqnla.fsf@intel.com> <20200108100831.GA23308@ravnborg.org>
In-Reply-To: <20200108100831.GA23308@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 11:33:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1FKOV=1No7Q0g1vF_NQmVHK+g0VOqzPL499Pxbbt1aPQ@mail.gmail.com>
Message-ID: <CAK8P3a1FKOV=1No7Q0g1vF_NQmVHK+g0VOqzPL499Pxbbt1aPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_panel: fix export of drm_panel_of_backlight, try #3
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L7zqKiPlDJkdUly7V9ueinJEQiEwKj47K8gm8+eKeFUwv2oJnEI
 XAa0+ZITGd5IQsYOdHmoIO1SVFWekKL+ndlIAQ31UgEQ+ReP/aOxwEbSi4RUCUGyGbCGoTd
 oBSY6WsxnYMq1UsKNZxftEhi6dzcUe3Z17u3rBiAoST4dvzpL1Usw0XQc2aDgjES4qPasRR
 6WyWt2OIGDemBrx+jCMZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lz4cYoS1mHs=:VHbTjdYsCzDm07BGtqDzDE
 wUSKRkcJz6BjijmPu1o5lx24medaASzxhkEafj0yCAUkBiXjqSUcjeZ9dz5GLszsr0mK/zabC
 Wj/6lw7og47rIEOsBOEmFiCQ7iR/tTABUPf9l9fH0Xq/QeeP+D82pXWWTTAcdG0TG+p/1WD5s
 yHYEuxQgysx9qNbWPnP255pivLUS6vNxIPRuBGagHtfBZRN7CDCOCil/y79f4pU0AVNA5t5Yi
 s94pSWoptogYzxNF/EhHnEMHMLY9gwTPWDALDi7Md8pqptbbnYDzEMWDrTFdIssbNAcj48nQq
 F5WU8fGtLYU9V8vNxuy1F5ZoTiiTgwG5Sqswq7JxlrGl7iiViQ6qrraBOHYnskgKoo3Pa5Muu
 Bmb0jkPw1ev6v7uuiH1SA6Zm1VpFGtVZrY6AthTawHnztxsKtTf2l+T5JZI4y5e2yY0hLCx3/
 MfOdM9GJdz8kyWfpQZSdhvnH6znr0torrRUJ7TzrW23pSMLPpJjTyR/40Bt6UZUtkUO44m3i2
 bTccJSDPSNHWUhjfb6EqEN98jr3WphIq06zrB5m9Aix62+V1RyCjmg7otCB2D1OGRkZLtxO/v
 JmlRyj+Ix9+GUhn0LTh6pTYk2eyDLFn917j7shc9feoybYlBSony6bAKsexueM0Z/SsPZAOD6
 xzCEACeM7pHVhjvJ7SvA1HiPqV+hZ7/i16QnMiNB8N5BRzpllWFWufKplpBXs+Vzy6pKy4n/v
 OlcqVuja9Sdh67T8mX2xGZQoCzx5DP00NgVvH9Va1OkaBUGb5u1tqGiFwb/48UecbwsUsaxkU
 HwPS9cZ/IYrMj729WgumdVUVWeqPxuVVpPtOVlFXsIVDeqvuVee3UctCC3BP1kQTovfHdLwc8
 rGnzQBKVkeGvfyT6nv3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 11:08 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jan 08, 2020 at 11:55:29AM +0200, Jani Nikula wrote:
> > On Tue, 07 Jan 2020, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Making this IS_REACHABLE() was still wrong, as that just determines
> > > whether the lower-level backlight code would be reachable from the panel
> > > driver. However, with CONFIG_DRM=y and CONFIG_BACKLIGHT_CLASS_DEVICE=m,
> > > the drm_panel_of_backlight is left out of drm_panel.o but the condition
> > > tells the driver that it is there, leading to multiple link errors such as
> > >
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sitronix-st7701.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sharp-ls043t1le01.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-seiko-43wvf1g.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-ronbo-rb070d30.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.ko] undefined!
> > > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.ko] undefined!
> > >
> > > Change the condition to check for whether the function was actually part
> > > of the drm module. This version of the patch survived a few hundred
> > > randconfig builds, so I have a good feeling this might be the last
> > > one for the export.
> >
> > Broken record, this will still be wrong, even if it builds and links. No
> > backlight support for panel despite expectations.
> >
> > See http://mid.mail-archive.com/87d0cnynst.fsf@intel.com
> >
> > All of this is just another hack until the backlight config usage is
> > fixed for good. Do we really want to make this the example to copy paste
> > wherever we hit the issue next?
> >
> > I'm not naking, but I'm not acking either.
>
> I will try to take a look at your old BACKLIGHT_CLASS_DEVICE patch this
> weekend. I think we need that one fixed - and then we can have this mess
> with "drm_panel_of_backlight" fixed in the right way.

I had also attempted to fix the larger mess around 'select' statements in DRM/FB
around BACKLIGHT_CLASS_DEVICE  several times in the past, and even at
some point sent a patch that was acked but never merged and later broke because
of other changes.

If there is a new approach, I'm happy to add patches to my randconfig builder
and see if there are regressions in some corner cases.

      Arnd
