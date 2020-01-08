Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B821C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE20206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAHIZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:25:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:25:32 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M6DSo-1imtiz3GKO-006feL; Wed, 08 Jan 2020 09:25:29 +0100
Received: by mail-qt1-f178.google.com with SMTP id k40so2110480qtk.8;
        Wed, 08 Jan 2020 00:25:29 -0800 (PST)
X-Gm-Message-State: APjAAAUVJcur91k6COxzGQDAVGvdKx2A/RkImD4jpAsweb0/3PApGTcf
        0Q6E9KYQjbE8V50zljgfPlNO7tA3DVXajJud4fA=
X-Google-Smtp-Source: APXvYqxo1JZhvOPCBQPM+a8aOATlvbZDJjTr/hwxzR+Dg/SgLXNsNMz44+CS7FY2RXBXTHIAAV0lb1p8dTXhOGbqEVI=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr2496507qtr.142.1578471928598;
 Wed, 08 Jan 2020 00:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20200107220938.2412463-1-arnd@arndb.de> <CAL_JsqJ0bVEkDfUw9+8gf=EVN=xjH4F1uyrmtWQfgc80FsTvew@mail.gmail.com>
In-Reply-To: <CAL_JsqJ0bVEkDfUw9+8gf=EVN=xjH4F1uyrmtWQfgc80FsTvew@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 09:25:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b5Chu2Bjt1Rto+2rgoyX0hr-fa3YmeYkyNE-05YHheA@mail.gmail.com>
Message-ID: <CAK8P3a2b5Chu2Bjt1Rto+2rgoyX0hr-fa3YmeYkyNE-05YHheA@mail.gmail.com>
Subject: Re: [PATCH] of: add dummy of_platform_device_destroy
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ud5vZVq+DoTLU60wLe1FP6anNS3xDaBUZsRiYTw3oR4dQTckzXl
 letZZFolOWU12mzxBMt5KcrK5VDqAGbY9HOa+I4gpFyoeFyhuQgfZ7aBgHjNoozrKChK6ON
 qfjtiz+yGoN1/rgrWTh3kbyqiBx5q9Rilo4XYLV/f910lBEFPXX+jI9Wi8p1VXd0VZVdq8n
 UU2Oa8rs6gvchVpQfhrGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yK24Jz0MwPc=:Oudvt2ykSk6ZhyN5hlY59Y
 y0DXEpMQuyqYIcJF+7MweSP12KcNBb4HzFR8g7IeIEzHxtxijEtiXXtC6xbg1q8b930RkIpxF
 Cf1NvoS6V1EMZ97jiV1YMskeKZoMIyb6m8OSxNdFi52QsCIZgPn6Q+7UODhlgRRgYXofJZGQM
 l/ZzEsKAjUJaOiImeeX1n4n5LOwydj3FPBfiPM3UQE2vft+iSM8aNLuiSlcUhZ8rLK/knJpnE
 RJ/Vgy/yxVSd9cI15DA9sFVNdEHBd3VQcBhvxd/NS3d8uXxjujosx/63oG4bmxjgvdkKgcMqB
 QWQ/oM10lRYX45CIA+3iZHqsQKbC0BM1bXS+wn5tA5Zz3Zsa8Bdt9caqYEsDhozGYGBoiTExv
 jEpOZ5RhsaeNKaG/W36RJhn0lyFJ5kT0BsEf9G5z767QJdMNIJTpo9XPWrlqEE/FiNRCo4aVt
 Td1e6ge3gjfj5o5yQLu/SCTxCku/HJOrZXyhJ3SbPPfOGBZgJTouPAsrNvLWXKRFpiKzGDSPy
 ipJ0DU1b1CvICJhMpUL0/bLfEjSxrBiBrVe3+PLQbXIGU7F90bl+XDr66iNIxIIk2t0TymgMk
 RIn4nSum9gr0whXsVe0hV4evdaJyACoM9skhkz704FcLfrif2GYJqx7XRaYKGHi7otZUmc8GQ
 3SfsGeSRRDU498J9qJsJIimXgw+VT78No2hFjRl/AQM0ykyLz4LPVM1VfMdu3p22U1dSfPBFU
 MlB/L38kdAco6lkJVHSCx54V2LuxGI1tCA67t9ibenMkCUZWtcdGKNTee6qNYrr9VwXGjqUDA
 xUs4ZkjUz00xbmJlpqLXsqFFm7QJqMg56tOadnD5wGbo07DMypnWf7wW7hlOwmumEvg9TjweI
 csOuE4GW0AcBf1l6cx8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 12:04 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jan 7, 2020 at 4:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The new phy-j721e-wiz driver causes a link failure without CONFIG_OF:
> >
> > drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
> > phy-j721e-wiz.c:(.text+0x40): undefined reference to `of_platform_device_destroy'
> >
> > Add a dummy version of this function to avoid having to add Kconfig
> > dependencies for the driver.
> >
> > Fixes: 42440de5438a ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/of_platform.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> > index 84a966623e78..2551c263e57d 100644
> > --- a/include/linux/of_platform.h
> > +++ b/include/linux/of_platform.h
> > @@ -54,11 +54,16 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
> >                                          struct device *parent);
> >  #ifdef CONFIG_OF
> >  extern struct platform_device *of_find_device_by_node(struct device_node *np);
> > +extern int of_platform_device_destroy(struct device *dev, void *data);
>
> This is already declared, so don't you want to remove the existing one.

Yes, this is what I had intended. I'm surprised there are no warnings when
the compiler sees both an 'extern' and a 'static inline' declaration, but both
clang and gcc seem to accept this, as long as the 'static inline' declaration
comes first.

> >  #else
> >  static inline struct platform_device *of_find_device_by_node(struct device_node *np)
> >  {
> >         return NULL;
> >  }
> > +static inline int of_platform_device_destroy(struct device *dev, void *data)
> > +{
> > +       return 0;
> > +}
>
> I'm curious why this is needed, but of_platform_device_create() is not?

I think what happens in the driver is that this is called from the
probe function
after calling some other interfaces that always return an error without
CONFIG_OF, so the compiler manages to optimize out that call.

I agree it makes sense to treat create the same as remove, I'll send a new
version addressing both comments.

     Arnd
