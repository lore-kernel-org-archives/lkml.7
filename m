Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742312053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAHURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:17:51 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgAHURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:17:51 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MnJdC-1jWI1J3dsC-00jMcm for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 21:17:50 +0100
Received: by mail-qv1-f43.google.com with SMTP id p2so1974366qvo.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:17:49 -0800 (PST)
X-Gm-Message-State: APjAAAWYO60VpRJXD7yJGoPYWGEguWsAPlXppejViFcfamfOUvx6ixlO
        uwJhd1seIqiwLD1t/kHTobnco+2DVAIYsedMbZQ=
X-Google-Smtp-Source: APXvYqzAnhWsLJVUU5gIZirzQYVUkqnaExIjs6+GxvB+JpeQ3bcq39GJcmTczRoqMdXQWqf27Oikx5ybv5fsl0NqlYk=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr5886413qvo.222.1578514668816;
 Wed, 08 Jan 2020 12:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20200107203231.920256-1-arnd@arndb.de> <87zheyqnla.fsf@intel.com>
 <20200108100831.GA23308@ravnborg.org> <CAK8P3a1FKOV=1No7Q0g1vF_NQmVHK+g0VOqzPL499Pxbbt1aPQ@mail.gmail.com>
 <20200108164618.GA28588@ravnborg.org>
In-Reply-To: <20200108164618.GA28588@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 21:17:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1TmfqXA3gK0YwbPBSeydEs=b8Tae=JWvju4OZaSMUscA@mail.gmail.com>
Message-ID: <CAK8P3a1TmfqXA3gK0YwbPBSeydEs=b8Tae=JWvju4OZaSMUscA@mail.gmail.com>
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
X-Provags-ID: V03:K1:KM+7TQVlpJCb1GisxjjTNILj9flw+ear3Ihr79VLp22TAwd3qhx
 O5wRjaqooxF6L6kCfnit5EDBCtg7ubGxiaK70liVkEjPBlcumr7RXoOlbk78x5efaGdpBT2
 SeOfFE11t7L83ed6PUW5xSbxGV0ryt6NcrHFa18qlpZsD/ccK2VvCQDn9vWb7eyixaoDN99
 38gjUz5wHUBBD6putBeGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZXSvl7cY6d8=:793k/lBklweH2Td0TAU2cs
 WWdF2LG4CAqKLMBybFPKuYtbmFgT+WqwK0l3uSj6hEMjPAnWDIs+t5IIKGFOisrOKbP8wQ498
 8nySQEQjF3oK3RJUmcjEJSgG50jTFA/OYoB3rmlQcJEIJSnvrMtw1mbbCyREAoRL6aQc/iLHI
 mmZZ/iwCAf8h1EHox+4jTkcPHsXUiXcI46XLZjWD/u0SSRiYdDP8SWVfyMBbpa7iSdYC73SzE
 zNKgD12u1QIV7t1wj+2euV5p2DXyJKLg16FTWldMAPy93SDrKpCVxZuOYigb4gNCl3k6vnzgt
 z4uh803laPXecN6r0aNp2NI+DGEfYPTOmNBBYPSBNp/XaOChSlVd3/zK2/tevDMccw0pWGrzv
 0+KGwupeDyJ4iP4NXZ3doVCPfmZU1Pzrr6GsIvRK7a/cS9XBCnOFdLX/ikL7hT2nDxAcQ56Pt
 SLHXm/HLeh3OYS0xkSSFRLyWhqDwHkXOAC0zWei8bGjjtSTA16OR2rfvKyvMf64Pfe8Ascg6p
 6scUZwHL/2Lt25grToLa41xfONmk19lRqMTgdfQt6HPRqQ/9GFsfODLfR/tAJlVwzC+8OY29T
 VudgMaQ3fhd6IGA3gi9XS0zOdaODQcdw6WEv6kxylBtvpfX6ab8bTuWfx5eIet6x7K/okg8mY
 pg+jkoDQmx5mslzc8cVcEm92aTDY1NOFIFnG6HRMw/S+SEDKKcbR5PeHNZq4asvuWqU1IgB/X
 3nlkVfA2fNFxI4SbCklDA4axDz5DYiAkTQ9UWUooWYHJ8gO42j/DKGRsAVEIfuBmju1PLYGuw
 QTlTikl9cVicm97My6W9vPefpfD0vPmX1jxyQkP6gsT/db51eUHASqrvgsNJkrxRUAk4UEi0I
 siF2OUtyK9recT/CUbZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 5:46 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Arnd.
>
> > > > All of this is just another hack until the backlight config usage is
> > > > fixed for good. Do we really want to make this the example to copy paste
> > > > wherever we hit the issue next?
> > > >
> > > > I'm not naking, but I'm not acking either.
> > >
> > > I will try to take a look at your old BACKLIGHT_CLASS_DEVICE patch this
> > > weekend. I think we need that one fixed - and then we can have this mess
> > > with "drm_panel_of_backlight" fixed in the right way.
> >
> > I had also attempted to fix the larger mess around 'select' statements in DRM/FB
> > around BACKLIGHT_CLASS_DEVICE  several times in the past, and even at
> > some point sent a patch that was acked but never merged and later broke because
> > of other changes.
>
> Any chance you have the patch around or can dig up a pointer?
> My google foo did not turn up anything.

I found it now:
https://lore.kernel.org/lkml/20170726135312.2214309-1-arnd@arndb.de/

      Arnd
