Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2FDCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJUGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:53:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:53:36 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MspyA-1i2in805iC-00t9Er for <linux-kernel@vger.kernel.org>; Mon, 21 Oct
 2019 08:53:34 +0200
Received: by mail-qt1-f181.google.com with SMTP id c17so16399593qtn.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:53:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUiuTQRwKOWkXObROdqlTIhKhBxX4IgO6B1CjsEYzCfxptmLHOQ
        DhecMocNTIA4A7PMFHyqbNRmJfWe/83OGRxxaTQ=
X-Google-Smtp-Source: APXvYqzYcUAYVHni2nqAfOPQIYdHwgcZEdAAjv1mOE8IjJCV7hvfGNf5JhTchMHWyrOMCNUibIt1I1R+FjIbw4CmeQc=
X-Received: by 2002:ac8:729a:: with SMTP id v26mr22612098qto.18.1571640812963;
 Sun, 20 Oct 2019 23:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191018163047.1284736-2-arnd@arndb.de>
 <20191019184234.4cdb37a735fe632528880d76@gmail.com> <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
 <20191019222413.52f7b79369d085c4ce29bc23@gmail.com> <CAK8P3a3UztT5aqDTiBNDssHWcdYQNqbhiY_hxJ+AHuM54hgCWQ@mail.gmail.com>
 <20191019231418.c17b05f73276539536b4732c@gmail.com> <CAK8P3a0FfTjNAvJG1yUi==bLBjeVaJ0oseaqs-ZouZKHrFdBHQ@mail.gmail.com>
 <31d57d94-9701-1c46-6ce2-c43eaa16f444@gmail.com>
In-Reply-To: <31d57d94-9701-1c46-6ce2-c43eaa16f444@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Oct 2019 08:53:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZUgF0iH+BAw0ny-UwUYxoZ94apgYhD_vi4AiN5USwZw@mail.gmail.com>
Message-ID: <CAK8P3a2ZUgF0iH+BAw0ny-UwUYxoZ94apgYhD_vi4AiN5USwZw@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:at46vGeiDth9D4mVN7gu1SXOH1V85f3IsH9ESbwEW0Ik7IgEmGJ
 yhw2xiNW8BKwjjw3MARjUSntH+Qw2qxaTwx7xVRxA8zTBzChDTBHbsu4+XRJoV80V2mOlFh
 JZ5b79chMXuFkxWaJcHlpfO2mFWdiKOZwNm06v4uRpnqR0VxIp93NH/YD1Q/XAYPkBXsGkz
 F63WSseP52pXbB9htrXHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lSNLnVxCop4=:t1wwKdu1Etvt2JVZVrKiMS
 gxeu44lX2EDdvLLjatZMT0XVcKpbwLmida1yqqLZgKaIzsduQUmNc86Wp/P6ULnvCL8s+bAIS
 Id/iVELVR4ceB38kSgYGhNth3uBAZPLu6Nn1zw769FWVth0du2Gs/mJKXaf/ZfElMDC/5LEkr
 R2Y43jvZxtrGx3YNO2ZXo+gJTp23OE3Z5PsPhhJwk0jTYOLeHUAdH+syytiwNas8gKhM1mcCv
 36voAFLhp1As4ETM8v7gjrW5fyYyax+wrXiKsqOGjD/NyXih+vBSPr5QK/TDG2ZnD4JYA+6Tt
 CYpZnuOf3nHC/TyjDlcVP2OnB//S7KXKD50iz5ieEGyBnHeDHVyO90vhGOEp7Gibr2yz2jfOY
 m3lIhu5bUD/d0SJL9OpJ/zqf6CghzS0LnpV3zbA7c0qSz6F/30GWhbaiuqung66Rs7b1Mizm5
 O0+uk61teTQSpSawV4r2aMmbICNPSqBMKp+2bIQ3CoVAfNeIRUhHm9tv+0KY5g1soqtoaEvWs
 FW8LFWNhGVo4fc4hVOEg304xk2PWPfG+9XuwKpUHwovUWk/twD5QUpaKTP+WJZup8iBW8TyOH
 GwtlZF0gLfsVe2r/RtPejSIM6cDg+kJw1BnaPknzwxbXXo51syn3QCbauxedQofpepw7JdTQh
 BGKPNGRYPS6k81oNXDYuqAXh3y4H8/76JEcYYTYMuoeYTZA+xKEa7MCcX7ZteqPXNILB8zSwo
 Bccw88PIMO6IMOPiF8Bdwqjwp5b/iTMbhSxS1qFGbrf1QqElerHq4cvIh8su3ogzqyaOwxUhM
 McJC9fVRyBNxCNbZkTa0kcD4XkP+T6xxTby0IO/RKPFxgHkDAoGLwlWgTRc+shzWE1DwzdwF9
 J3TLeDHitfLzc4zq413A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 11:47 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On 20/10/2019 13:49, Arnd Bergmann wrote:
> >>> Ah, that makes sense. so all interrupt numbers need to
> >>> be shifted by a fixed number (e.g. 1) like we did for
> >>> other platforms (see attachment).
> >> Yes, the below patch resolved both GPIO and DMA issues.
>         ^^^^^^^^^^^^^^^
> >> Previous patch (selecting IRQ_DOMAIN_HIERARCHY) is not
> >> required.
> >>
> >> If you re-spin all 3 ep93xx-relevant patches together, you can put my
> >> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> >> on them.
> > Awesome, thanks for testing.
> >
> > I only remember sending two patches  for ep93xx:
> >  ARM: ep93xx: make mach/ep93xx-regs.h local
> >  ARM: ep93xx: enable SPARSE_IRQ
> >
> > and have added the Tested-by tag to them now. Is there a third one
> > I missed?
>
> The patch shifting the IRQ-numbering by one is a prerequisite for the two
> above patches, right?

Ah, now I see what you mean. I had folded that change into the sparse-irq
change, but you are right that it makes more sense as a separate
changeset before the other ones. Changing that now.

Thanks,

       Arnd
