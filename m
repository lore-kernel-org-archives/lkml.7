Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058520879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfEXHM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:12:58 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34767 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbfEXHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:12:58 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8206DFF80C;
        Fri, 24 May 2019 07:12:53 +0000 (UTC)
Date:   Fri, 24 May 2019 09:12:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20190524071253.xfimg5mlvzevj2nk@flea>
References: <20190521105151.51ffa942@canb.auug.org.au>
 <20190523115355.joyeqlmbjkufueyn@flea>
 <CAL_JsqKN6+f5FXUVs03VSv2AKvqaS0XemKFSYFthaxPoHJVwEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hfshwxlp636xi7sx"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKN6+f5FXUVs03VSv2AKvqaS0XemKFSYFthaxPoHJVwEg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hfshwxlp636xi7sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2019 at 11:10:39AM -0500, Rob Herring wrote:
> On Thu, May 23, 2019 at 6:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Tue, May 21, 2019 at 10:51:51AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Today's linux-next merge of the drm-misc tree got a conflict in:
> > >
> > >   Documentation/devicetree/bindings/vendor-prefixes.txt
> > >
> > > between commit:
> > >
> > >   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> > >
> > > from Linus' tree and commits:
> > >
> > >   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
> > >   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9700RTWV43TR-01B")
> > >   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronics")
> > >
> > > from the drm-misc tree.
> > >
> > > I fixed it up (I deleted the file and added the patch below) and can
> > > carry the fix as necessary. This is now fixed as far as linux-next is
> > > concerned, but any non trivial conflicts should be mentioned to your
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflicting
> > > tree to minimise any particularly complex conflicts.
> >
> > I just took your patch and pushed a temp branch there:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git/commit/?h=drm-misc-next&id=3832f2cad5307ebcedeead13fbd8d3cf06ba5e90
> >
> > Rob, Stephen, are you ok with the change? If so, I'll push it.
>
> The 'tfc' line is missing a ':' on the end.

That's on me, sorry.

> Does the file pass dt_binding_check like that?

No, it didn't but I overlooked it somehow. I've pushed that patch with
the extra semi-column.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hfshwxlp636xi7sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOeZdQAKCRDj7w1vZxhR
xZr9AP9GA2LoSNSb8Aw3lEDA0VSIAbX2AciLEGPTA/XJg9DJNQEAjA43h9VqiTXF
qjCOtN/i2lxT8YXjFbrhoaQuY7/4yQU=
=kgcI
-----END PGP SIGNATURE-----

--hfshwxlp636xi7sx--
