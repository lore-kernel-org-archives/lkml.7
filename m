Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDECFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7492168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404630AbfJPOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:54:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44949 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfJPOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:54:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so21519092edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge8y9M+PbIEIsapWKOry+7z8a5UxWiYE6qcowbBaIEY=;
        b=RZ2nNU4CxUB362lxcFHzsFyB/ttPZRXY591wLbgsRSPYGnYuP2/wVDVREwvk28/S9v
         8oW1qbdzR1sg6KTB3hrziFj4xTrl6Bdd/0bboi7Z7tDaZJBvQvaQL7nvbSigH/OTd1Bx
         kRy/Jmq4qLbhGHsl2wg6CE+mXp1eDjsPwwiQWjT8IlfaJ4QslUr7JXKppy/IaIsF7SLJ
         30rveF02RMH/yt3fYp553QfKTbiIQ99QAuohegZ0tdBdCT7lmjxS7V/mSw0ncNrBy/Yq
         Dk9apRozdOeRGrQ2qOxP/IPZ94Sc37++dP5hyhDqX50zbNLS8Fq1pf/8WT7FvfqLqLRd
         tyuw==
X-Gm-Message-State: APjAAAXTwlFbp9qsGviA0fhgZC4cQ/dDeCcLLRy+pH5ZU9KPzCu7hRgp
        Rfu61dA5jPcgtYKMN9uYlL9l919I46U=
X-Google-Smtp-Source: APXvYqwV2j60+MJg7ZbQYx6MPV4/o8kKWRWQFQdtAJH7S+dy9w0RKRO4KKTbtEbMBhB4H9wEGX49Qg==
X-Received: by 2002:a05:6402:1351:: with SMTP id y17mr39437556edw.294.1571237680186;
        Wed, 16 Oct 2019 07:54:40 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id z39sm4072162edd.46.2019.10.16.07.54.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:54:39 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5so3284002wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:54:39 -0700 (PDT)
X-Received: by 2002:a1c:a9c5:: with SMTP id s188mr3395636wme.61.1571237678969;
 Wed, 16 Oct 2019 07:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191012200524.23512-1-alistair@alistair23.me> <20191016144946.p3tm67vh5lqigndn@gilmour>
In-Reply-To: <20191016144946.p3tm67vh5lqigndn@gilmour>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 16 Oct 2019 22:54:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
Message-ID: <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        alistair23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > connections.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > index 124b0b030b28..49c37b21ab36 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > @@ -56,6 +56,10 @@
> >       aliases {
> >               ethernet0 = &emac;
> >               serial0 = &uart0;
> > +             serial1 = &uart1;
> > +             serial2 = &uart2;
> > +             serial3 = &uart3;
> > +             serial4 = &uart4;
> >       };
> >
> >       chosen {
> > @@ -280,6 +284,27 @@
> >       };
> >  };
> >
> > +/* On Pi-2 connector */
> > +&uart2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart2_pins>;
> > +     status = "disabled";
> > +};
> > +
> > +/* On Euler connector */
> > +&uart3 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart3_pins>;
> > +     status = "disabled";
> > +};
> > +
> > +/* On Euler connector, RTS/CTS optional */
> > +&uart4 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart4_pins>;
> > +     status = "disabled";
> > +};
>
> Since these are all the default muxing, maybe we should just set that
> in the DTSI?

Maybe not, since people may want to only use RX/TX, and leave the other
two pins for GPIO?

ChenYu
