Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 11:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A02089C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 11:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfJTLuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 07:50:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfJTLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 07:50:07 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MGyl3-1iIdLR0uDj-00E7RH for <linux-kernel@vger.kernel.org>; Sun, 20 Oct
 2019 13:50:06 +0200
Received: by mail-qt1-f180.google.com with SMTP id o25so2801586qtr.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 04:50:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUgFM4iK0vguIr07QrnBAhZEo+5LLVwR1XuSCMxtQEo9TfPYVzi
        E3O7NEhJPM2TwPWVSkyjS0HEFOestOZZ1St1Fuk=
X-Google-Smtp-Source: APXvYqyxuhiTjd0SZIgrrlxCYnlIXemNBz+y2/q75Jl/HJqU52fQRIar8MefLrwU+CB3BTQDPgAXmZ7VKZ/vpTH0v2o=
X-Received: by 2002:ac8:38e3:: with SMTP id g32mr19668378qtc.304.1571572204064;
 Sun, 20 Oct 2019 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191018163047.1284736-2-arnd@arndb.de>
 <20191019184234.4cdb37a735fe632528880d76@gmail.com> <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
 <20191019222413.52f7b79369d085c4ce29bc23@gmail.com> <CAK8P3a3UztT5aqDTiBNDssHWcdYQNqbhiY_hxJ+AHuM54hgCWQ@mail.gmail.com>
 <20191019231418.c17b05f73276539536b4732c@gmail.com>
In-Reply-To: <20191019231418.c17b05f73276539536b4732c@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 20 Oct 2019 13:49:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FfTjNAvJG1yUi==bLBjeVaJ0oseaqs-ZouZKHrFdBHQ@mail.gmail.com>
Message-ID: <CAK8P3a0FfTjNAvJG1yUi==bLBjeVaJ0oseaqs-ZouZKHrFdBHQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ipN5pgCBdWVbpdw0ZxmQ4rh3BVAFDvoUpvRFfgRUVsApWLHB6c5
 kGRtCsTyj2lHOzDC7+T62bPCzJ0e+LN7AtbD5UacJLeS/sVYZPZb9EwmtLLHUXzGoTDOTJ6
 VGrRnBsfBM6vX6crPT9NI+8LI+1jydnRuAZrTkgTPBxMzkpdpXT2eFYX/aRWSZTSIYX/Y3Z
 5nHmIx+/WJIPwrWM/6OXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOM2IqTK++Q=:DjpxBMrOUZILcluUNODRoR
 NTa6CP6QMVhjTlCbrUdxfT8+muh7aKL+0qzs7O5oyf4cbajvO1+Vbxm46oAkpTQUtt9N6/bAm
 2wiS8lxLTVhjxC9U+On0SeAd6KmWJbz2cfBVRuC+GFUsRnM2rP6na1z+n9WhdaVWDgPdNfBRC
 mHDkCf/wqJfwzb087omemoUqBrqPzo4ctqKdWmUUAjfUfAc8bGg/TBH1A11hHQ+W0VKdGJmWl
 KJyxzxerFnzIn/OhAbt2U2gZPoFkGC8sPo5/v97gHN/geyf7jtv/5/6SKCkW9dKUGagcDlNP4
 DYzk3mNmjCzDbFHJKcnH1BLpcsYGjRe4BW8XfLmyp1NGwuYC8WVVkt1d7Z4JBJgbmujvcM90g
 uK3lobYbEmpobHbT+ilVAb2tXHprAlo0EHXmUfJLFib9pXUOCTLtysQc4O441QpTx8pFJ5Vbi
 yDJhzpLOn9yYNN9tDf62vunE2cfXoDBxv8deKp+7J7nZCiN8HRnQsrnHrpX+33Uq+Ror3J9Gk
 Xu38AkzZ1v9SsGAGRVD2DZb0j9J2y410nKsLwDbtpmJ5zhGsJu358xV8LR2SUflBRoVZI0kym
 Ul9vD9GM9AEpmEE5MX9ySWyVXDSystimed3+erIMVq8KUyW8mVrEzB32r3PDffTB7nvlF1yjB
 rYzo1pSc0FxK/qXq7RCkStBd1OMQrGCb4sNyazK6Z/4WTI8MO7aie0lvnuQNHZ2EBAHAfem71
 nU6wKs7XRJ3UcdI+1IXYp3+9iQcqZzRoqhOvJMINCqjkuH5EizqYR+pxngrRd+lzJsZJcpbt+
 TNWvnVwPe8u5esxvB6Xfoy8fYIsCwq0dsd50EKeB6cZNw8wvStm7D1Re1eAehjBaVvXc0wznV
 Jeh+JvsmFzv4NbTK5csw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 11:14 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Sat, 19 Oct 2019 22:44:18 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> > Ah, that makes sense. so all interrupt numbers need to
> > be shifted by a fixed number (e.g. 1) like we did for
> > other platforms (see attachment).
>
> Yes, the below patch resolved both GPIO and DMA issues.
> Previous patch (selecting IRQ_DOMAIN_HIERARCHY) is not
> required.
>
> If you re-spin all 3 ep93xx-relevant patches together, you can put my
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> on them.

Awesome, thanks for testing.

I only remember sending two patches  for ep93xx:
 ARM: ep93xx: make mach/ep93xx-regs.h local
 ARM: ep93xx: enable SPARSE_IRQ

and have added the Tested-by tag to them now. Is there a third one
I missed?

      Arnd
