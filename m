Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EDC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358612080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697625;
	bh=koCanOkVczvS52T73JPshYve2oe1v8MC5CVzIbc6FFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oeLejsVkRYh3dB0GGPig7gT8B9rKSk/NB8WBx9nCka8yPYXUduR/T+0Jyz2r/UPZu
	 UMTqhTQ08npN3KLGZUYJyNW6AOFlEQOuJ3mAGXBpLwFIC2uSRmniKET7i2j8TjeZ7I
	 SjeBW2IRerluC7a7Z8qCcjyqnAcQC6q1kHbgZ6JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGISkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGISkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:40:23 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4812A208C4;
        Tue,  9 Jul 2019 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697623;
        bh=koCanOkVczvS52T73JPshYve2oe1v8MC5CVzIbc6FFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rg4Kf+gWwQB7wGTO2ZJxE7BgB+ir2DZV1nIP7CbvwvdjxUxvCug7xMpH3KfH0n2o+
         ufWwlDpcVBFPYzl49Vpcll+lEFdbBJAUXE62gdJHMT2TSAT8hbrryMOYIKzQDC04no
         rsaJH+G7kjHSg0EM5NflHr78qmgCv9XXNXon6Irw=
Received: by mail-qt1-f178.google.com with SMTP id j19so22627980qtr.12;
        Tue, 09 Jul 2019 11:40:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWajnfUl5VpdaKr4IRi8x0vHvfyc69vFe4ViDfbg+FeHBVJQ6jD
        LhAxuh59UGIfRGZrnIqSBgScNkuHvZA8ZUbI1g==
X-Google-Smtp-Source: APXvYqzVdHUQy7kNe51NTmoxLixeCI0ZKWKOgMr6PxrBeJUBchUQj/myky27Tg2C8vC5QI9tQkIWqsTc+fws8sN66A8=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr19918584qtb.224.1562697622534;
 Tue, 09 Jul 2019 11:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190707132339.GF13340@arks.localdomain> <27a3468f-e7b4-e334-5956-8db87d04ff8c@suse.de>
In-Reply-To: <27a3468f-e7b4-e334-5956-8db87d04ff8c@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Jul 2019 12:40:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsO2MBOXUj3HT6=08VNsH7Ak_iJnxzdSOK3YF5+R387w@mail.gmail.com>
Message-ID: <CAL_JsqLsO2MBOXUj3HT6=08VNsH7Ak_iJnxzdSOK3YF5+R387w@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: arm: Document RTD1296
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Aleix Roca Nonell <kernelrocks@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 7:31 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Am 07.07.19 um 15:23 schrieb Aleix Roca Nonell:
> > Add bindings for Relatek RTD1296 SoC. And the Bannana Pi BPI-W2 board.
>
> "Realtek", "Banana"
>
> >
> > Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/realtek.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Docume=
ntation/devicetree/bindings/arm/realtek.txt
> > index 95839e19ae92..78da1004d38c 100644
> > --- a/Documentation/devicetree/bindings/arm/realtek.txt
> > +++ b/Documentation/devicetree/bindings/arm/realtek.txt
> > @@ -20,3 +20,16 @@ Root node property compatible must contain, dependin=
g on board:
> >  Example:
> >
> >      compatible =3D "zidoo,x9s", "realtek,rtd1295";
> > +
> > +
> > +RTD1296 SoC
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Required root node properties:
> > +
> > + - compatible :  must contain "realtek,rtd1296"
>
> I'm pretty sure that I had such a patch on the list already, so this is
> lacking my authorship.
>
> Also, Rob has been working to convert these to YAML, so we should
> probably complete that first and then add RTD1296 properly.

I'm just waiting for you to either ack it or apply it.

Rob
