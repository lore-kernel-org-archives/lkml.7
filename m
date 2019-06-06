Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF25C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F4720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ccbib.org header.i=@ccbib.org header.b="Xfkl4O7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfFFOHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:07:03 -0400
Received: from h1.radempa.de ([176.9.142.194]:35084 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfFFOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:07:03 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 10:07:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.cosmopool.net (Postfix) with ESMTP id 0B80890FE45;
        Thu,  6 Jun 2019 15:59:33 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
        by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t6ScGfx02b-c; Thu,  6 Jun 2019 15:59:32 +0200 (CEST)
Received: from stardust.g4.wien.funkfeuer.at (77.117.149.20.wireless.dyn.drei.com [77.117.149.20])
        by mail.cosmopool.net (Postfix) with ESMTPSA id 513A190213F;
        Thu,  6 Jun 2019 15:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ccbib.org; s=201902;
        t=1559829572; bh=yRX2r+1exJu+xt6035zadTL1ALZUnRaTg/CjqI7wAzk=;
        h=From:To:cc:Subject:In-reply-to:References:Date:From;
        b=Xfkl4O7wX3W5m8UlC0jDHhFkqAU2BvG0QxydrPbS9pMTSjHknn5s/c1SBTbtruCcq
         coWAmuJr1yuOJaqZowoulZ4CcLBNmsNeCqUBUAZ7PircVahSQsVhWKIyeT5tBQ5436
         fIYEpSYrT8cO2D3AnUl0hF34wAuI64BKWaKomt8Y=
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
        (envelope-from <harald@ccbib.org>)
        id 1hYsvP-0000PY-Pz; Thu, 06 Jun 2019 15:59:27 +0200
From:   Harald Geyer <harald@ccbib.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
cc:     Torsten Duwe <duwe@lst.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I
In-reply-to: <20190605120237.ekmytfxcwbjaqy3x@flea>
References: <20190604122150.29D6468B05@newverein.lst.de> <20190604122308.98D4868B20@newverein.lst.de> <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com> <20190605101317.GA9345@lst.de> <20190605120237.ekmytfxcwbjaqy3x@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
   message dated "Wed, 05 Jun 2019 14:02:37 +0200."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1582.1559829566.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 06 Jun 2019 15:59:27 +0200
Message-Id: <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, this discussion is getting heated for no reason. Let's put
personal frustrations aside and discuss the issue on its merits:

Maxime Ripard writes:
> On Wed, Jun 05, 2019 at 12:13:17PM +0200, Torsten Duwe wrote:
> > On Tue, Jun 04, 2019 at 08:08:40AM -0700, Vasily Khoruzhick wrote:
> > > On Tue, Jun 4, 2019 at 5:23 AM Torsten Duwe <duwe@lst.de> wrote:
> > > >
> > > > Teres-I has an anx6345 bridge connected to the RGB666 LCD output, =
and
> > > > the I2C controlling signals are connected to I2C0 bus. eDP output =
goes
> > > > to an Innolux N116BGE panel.
> > > >
> > > > Enable it in the device tree.
> > > >
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > > ---
> > > >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 65 +++++++++=
+++++++++++--
> > > >  1 file changed, 61 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > index 0ec46b969a75..a0ad438b037f 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > @@ -65,6 +65,21 @@
> > > >                 };
> > > >         };
> > > >
> > > > +       panel: panel {
> > > > +               compatible =3D"innolux,n116bge", "simple-panel";
> > >
> > > It's still "simple-panel". I believe I already mentioned that Rob
> > > asked it to be edp-connector.

Actually just dropping the "simple-panel" compatible would be a poor
choice. Even if "edp-connector" is specified as binding and implemented in=
 a
driver, there are older kernel versions and other operating systems to
keep in mind. If the HW works with "simple-panel" driver satisfactorily,
we should definitely keep the compatible as a fall back for cases where
the edp-connector driver is unavailable.

If think valid compatible properties would be:
compatible =3D "innolux,n116bge", "simple-panel";
compatible =3D "edp-connector", "simple-panel";
compatible =3D "innolux,n116bge", "edp-connector", "simple-panel";
compatible =3D "edp-connector", "innolux,n116bge", "simple-panel";

I can't make up my mind which one I prefere. However neither of these
variants requires actually implmenting an edp-connector driver. And each
of these variants is clearly preferable to shipping DTs without
description of the panel at all and complies with bindings after adding
a stub for "edp-connector".

> And the DT is considered an ABI, so yeah, we will witheld everything
> that doesn't fit what we would like.

I fail to see how the patch in discussion adds new ABI. While I understand
the need to pester contributors for more work, outright blocking DTs, that
properly describe the HW and comply with existing bindings, seems a
bit unreasonable. (Assuming there are no other issues of course.)

Also note that the innolux,n116bge binding suggestes using simple-panel
as fallback.

HTH,
Harald

-- =

If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
