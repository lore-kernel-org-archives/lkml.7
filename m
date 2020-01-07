Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C0AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB079207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgAGIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:16:52 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAGIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:16:50 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MDhth-1ixE5X3eAp-00AmD0; Tue, 07 Jan 2020 09:16:49 +0100
Received: by mail-qt1-f175.google.com with SMTP id n15so44692831qtp.5;
        Tue, 07 Jan 2020 00:16:48 -0800 (PST)
X-Gm-Message-State: APjAAAVLNlX09h5hPb2/cal2uS7lP3qsYeB+oOolGFQBBl+2Ou7Qyamk
        7McbzSLWqRl3NdpAx4nPeW5IikTqLR7IvbkgkpE=
X-Google-Smtp-Source: APXvYqy5Ck9gkPV52yg24WY0VrQ2y2C1CXBRF6Y6+8OBXLwg0dzkbS2jd5oixwoipa94cQmOYesNS9M2hLIm4uQS2qw=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr78397663qto.304.1578385007686;
 Tue, 07 Jan 2020 00:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20191210195333.648018-1-arnd@arndb.de> <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
 <9c9169cc-0da5-f247-c8f7-f6913ca2bfb5@linux.intel.com>
In-Reply-To: <9c9169cc-0da5-f247-c8f7-f6913ca2bfb5@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jan 2020 09:16:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1it2a1CmkkOfVqhLE33jmKWhHEtria+ESoz6uSkcP8_w@mail.gmail.com>
Message-ID: <CAK8P3a1it2a1CmkkOfVqhLE33jmKWhHEtria+ESoz6uSkcP8_w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: add SPI_MASTER dependency
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:keaxXrj9ZK7CoS2HwsxwVxblkq5qp5kthzW2l815MQ+j0uJEsco
 BY5/GhEFvapn3ptCQXm4ueSJyfi+cgyeJQRs9F6NXeA3pR2wimnqDrAxZvuRjE18qhZHVfK
 QhaeMTYFwGGbXd7Q884jD6lx/TnRvOzJ/voBqGBAPIGrM/LYqJy99AZIvmHxKjrIpeAzrzH
 N3fhx2WGc3sPIX4vRSBvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PgASF3VQxFE=:nKNVgxdHBtDervSUuG7Nd7
 5kSRCLp3DgCyN268JgfJEmkb4FAo8jum+RQxly5KMlytHt0n6fEGvkToPRaMCKDgtR9UKiCfn
 MbM9uLeDF5sQqfneaw7Vdpt6WbPs0UkxDfjIHnROf0dUnvTr0Gf7/ojEhriSLCQfTZHEjdM80
 o5MwJxOzfX7iFIaOtlAX/pdljspEJ5VgY5tjKD+x/pU3ULwaUjSeOmm08Ib/PMYv1PywqjARv
 ZWFZ2ETdHWy51kzPYAdUNqFdiDCE8Jtye1TvWkQui3ZdyaAPD9EOJ8JGeqjpNwBichIe1ilOV
 nPeseGXhkOXeVC+TrR7XyOEiirpzPCSy1hlzACg/ko6mr9LcjTnRficx9AdR92Ht+hOw8QZ8X
 j9vAO32nHh6zpOwVg6AC1fVySu7j/EjA2PGrOQeGCo3XsUk/um7fNKQtMisrZ+hh9YKTRF5+/
 k7mJFaNMKIZ+GVR19HGoiGe917q3FCRfdnon9nL8BqFLWR1YAg5q7zynwvcdtj/AeTR+0NL0K
 Ol6aKcdlU9fvw790yPQzEHFukvE8jFZMzSaqePg9Gyg2/tmhj82VgRzWh7M+gagTssgsjLiug
 KyaLYqgI3bEmhEIOTDQSuD6MuPPc/qpY84rRYcDImr6ANXHnLnZVXXCeSEZN6xfrzCdDI1zRA
 K5tBisyjqP4zxn+Z8jMJYGjvSdIyIYrAWjaOca9Q0J72nlKAcEAJ2JpKSbkKx2vBTnvZz4Iz2
 orreQUqdwnYMNh1wTq+OwMU0bIe13EVQTwjVyd8ev9l3TLXaOdFLjO6EBRv9EZA5jjl8oBWpC
 9sqagF1eG6rnVLLXZCHAbFQ6Mz/wmoxH8qX4Ih2pBljcUX2IDhxRMbWEhm5bWtZH84xdT8bh8
 1TMJ10IBSc5POVnyrxqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 10:55 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 12/11/19 4:59 AM, Jon Hunter wrote:
> >
> > On 10/12/2019 19:52, Arnd Bergmann wrote:
> >> When CONFIG_SPI is disabled, the newly added code for the DSP
> >> firmware loading fails to link:
> >>
> >> ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> >> ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> >
> > Would it be better if the above functions or the functions that call
> > these are conditional on CONFIG_SND_SOC_RT5677_SPI?
>
> they are already conditional, with a fallback provided:
>
> #if IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI)
> int rt5677_spi_read(u32 addr, void *rxbuf, size_t len);

Right, this fixed the problem.

> in theory if SPI is not enabled the fallback static inlines would always
> be selected?
>
> Arnd, if you can share the .config that exposes this problem it'd be nice

I just tried it again and it seems that the issue was already fixed by
commit fb3194413d1e ("ASoC: rt5677: Fix build error without CONFIG_SPI"),
which had not been merged by the time I created my patch as an
alternative workaround.

      Arnd
