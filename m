Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E674C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A912073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLJUwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:52:09 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfLJUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:52:08 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mdva2-1i7Mwb1bSo-00b4PA for <linux-kernel@vger.kernel.org>; Tue, 10 Dec
 2019 21:52:07 +0100
Received: by mail-qt1-f181.google.com with SMTP id d5so4137026qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:52:07 -0800 (PST)
X-Gm-Message-State: APjAAAWPqDqi+ERyVsWLR1DqU/752knclVNS7+nqczWfjx6fyrngY/00
        l6Ej6uCh5lrkS7FXCqZX97fhokjqk7KojRgd5tA=
X-Google-Smtp-Source: APXvYqx1uN5tm9eCOzoQBysKWKFpMTzZPxr5PqaW9bDfYB2yfC5l95PFbwxivepFESYFJ8F3qgkDRXUfr5anVcdWFA0=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr31351077qte.204.1576011126328;
 Tue, 10 Dec 2019 12:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20191210195941.931745-1-arnd@arndb.de> <cded03ab-40fe-a904-7b1f-5b3623bb7af4@amd.com>
In-Reply-To: <cded03ab-40fe-a904-7b1f-5b3623bb7af4@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Dec 2019 21:51:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3XHWPBOsCpFtdoT8F-pAMXaekDOX1rNjjMWKLN6WSK6w@mail.gmail.com>
Message-ID: <CAK8P3a3XHWPBOsCpFtdoT8F-pAMXaekDOX1rNjjMWKLN6WSK6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: include linux/slab.h where needed
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Yang <Eric.Yang2@amd.com>, Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Strauss <michael.strauss@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oljtm7MBh2EuGsqK1MIrX4qRTs1Z1e9HmMtnoaYHANv/WhV8rvN
 K+hUUimEFinqfuX1IStG/MVsMB1i84npQqXWb2ap9FiARR5myeB5Qdl/mPFC147TfsK4jpF
 Ty6JaHcePLAGWkIOyDEu9PDeUgO2Ym8jXEWgfI5qSqfs4YAQE7ieYq9UPGc0yIdjavUo4aC
 4loBY2QeeEZyzG3pFWwoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:szinTJ8XRQ8=:JC4e7kScSbrCX0Ai7I196b
 A/UFOnF1+vLwkCOfTtgLvrMKGDcEHZiaUqObl1GorkWek+lO8SWrQqL74YIXJlnX/ZdJh+BsD
 stiwjPZnrMrsqkEZftDfUrlw6w4SMMA+cv+yzUWNQVcZ9OmDGtQYQCaAPJw0J2rhmb/d1OpV2
 XQex49onnR/Eoh4G+R11gF+UoB8KnlS5nQz7jV2h1QrwGcp6HO1Gole2dx8QuYu3Hc4+lnoeN
 GJNRfxyzBU+ZSK8ymJ8nrDIUt5BErV/vKeKaA8/510/s/QrueeMadqY1GNasLs6pgE7UdeAcl
 33QbgVPtRLcozDU1kw7APme/QoA/zlLvNum3nMyGRHYSRY1rsJiwlXEwGdCGHL7GsFXrr9Axq
 koE0XZSBelCqlVNJqRg3p0CYqu48++lSLMzrk3Z+MQLT8LtgWLz5iODvF4zmMKXmDRTs6S7gz
 Ble/2ZUo+uFinTvgWl6rR1Np3+1ZbB5Nq2TVt+1RsFfaufU7/JaQr0FQCt5q8C8dEIm0VAxKB
 66hb3Z+Ei7ShhQ4E5fRTjwp2v3CB6xW7trssSdkUbPx2TTba1Wwa+utN54MJlFvCC4LU8+K1N
 qoHugotG+iGtV1yoSCVg1Zl0N1CnkBIIAxQh2BC56i6ge6ECfuhXjGfXTAoJyOsiT5/IRYTx7
 KmaekWcN5DGLXrJUp5jTnrvwn0idjtuz1YuuLVKdQuMmbMyOPaYehHqQsBkRqckT2o7Huup9V
 8qb9QwvtJfol2zlsMFmlnzlDVKMiGUBmLklziUYizJ2ehj4N2VhD8XNYBpyjUJqmT2tG8qQhi
 VRLFDaeXxbajc0XpvutK7leawKgIXvPapgfFAhh4qxFRD4aHBUHulHtK9On3tjjPwABPRexuZ
 6YK4bkDirsSkoxM3Xkkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 9:30 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2019-12-10 2:59 p.m., Arnd Bergmann wrote:
> > Calling kzalloc() and related functions requires the
> > linux/slab.h header to be included:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'dcn21_ipp_create':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:679:3: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
> >     kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
> >
> > A lot of other headers also miss a direct include in this file,
> > but this is the only one that causes a problem for now.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> What version of the kernel are you building?

This is v5.5-rc1, plus some local patches.

> We have:
>
> #include <linux/slab.h>
>
> in os_types.h which gets included as part of this file:
>
> #include <dc.h> -> #include <dc_types.h> -> #include <os_types.h>

I don't see linux/slab.h in os_types.h. I now see that commit
4fc4dca8320e ("drm/amd: drop use of drmp.h in os_types.h")
was merged into linux-5.3, which may have caused this.

I also don't see anything in os_types.h that needs linux/slab.h.

    Arnd
