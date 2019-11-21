Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C0620659
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PymkjOAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:24:26 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59519 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:24:25 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xALAOLBX022410;
        Thu, 21 Nov 2019 19:24:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xALAOLBX022410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574331862;
        bh=JcLX7D3CXanPLZcBh2rx5qAiol6xBUPrVbHtsQ/A0Tk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PymkjOAxeTHo2+buFpmnrbgesnJiHpveqGfdKDc2R/6EzRtyt3pWEDuYwJ3m2FDWG
         CKehgoOjfhu3EMvVuhkdp7k35ifDWeyDDKoaVRp+9H1UMG30bI4aLnXT/26/q/4CqO
         W5EMZOZN0V7y1pOURIqb5iyItvQ1aWiQap5PtRpycoY/1vsl1kF7YY/LFbgc/RMDTn
         z/k0vELRQszRvuJjjOeokgw0Oq8QbJmxCv6d8mygYLUAJBsUMXm3wPLbYKPSdYfhmL
         +4cA6qx01sfyk4VFNJcc2CKFyfPrpr3w+Rao7+8HYEzXBmnM4nQPITfttS1yBP/SSO
         LVwboQeHliJMw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id r22so792027uam.11;
        Thu, 21 Nov 2019 02:24:21 -0800 (PST)
X-Gm-Message-State: APjAAAWgep34Y+yigXEyOdQfHsJ6T4wxa8wIrTeNcPVOyiWbHdemmbOE
        8sXCYkXCn8xNf7EFvkFWRGm13vxhOSu8ZUgbeEA=
X-Google-Smtp-Source: APXvYqw/aVCgnKJDvq6ztT3UGVD4j248axKaGhITiWpkbXumzL5wr9NirEnlL4DX5NPtupeCYN1H/uGWaksNJyDqGXY=
X-Received: by 2002:ab0:3395:: with SMTP id y21mr5081794uap.25.1574331860583;
 Thu, 21 Nov 2019 02:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20190808173028.1930-1-yamada.masahiro@socionext.com> <CAEbi=3cZ29rmO55DcZSi8PmELay08HByabPETu_UOgXKZPk0cw@mail.gmail.com>
In-Reply-To: <CAEbi=3cZ29rmO55DcZSi8PmELay08HByabPETu_UOgXKZPk0cw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Nov 2019 19:23:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATw0V8yzh=62QefN+hHvUfaHNW1ZtSmLhtVJHJDqvbXMA@mail.gmail.com>
Message-ID: <CAK7LNATw0V8yzh=62QefN+hHvUfaHNW1ZtSmLhtVJHJDqvbXMA@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unneeded clean-files for DTB
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Nickhu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 6:46 PM Greentime Hu <green.hu@gmail.com> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B48=
=E6=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:31=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > These patterns are cleaned-up by the top-level Makefile
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/nds32/boot/dts/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefil=
e
> > index fff8ade7a84f..f84bd529b6fd 100644
> > --- a/arch/nds32/boot/dts/Makefile
> > +++ b/arch/nds32/boot/dts/Makefile
> > @@ -5,5 +5,3 @@ else
> >  BUILTIN_DTB :=3D
> >  endif
> >  obj-$(CONFIG_OF) +=3D $(BUILTIN_DTB)
> > -
> > -clean-files :=3D *.dtb *.dtb.S
>
> Thanks, Masahiro.
> Acked-by: Greentime Hu <green.hu@gmail.com>


Would you apply this to the nds32 tree?



--=20
Best Regards
Masahiro Yamada
