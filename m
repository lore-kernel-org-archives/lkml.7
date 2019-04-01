Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E603EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8C420840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfDAOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:44:40 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54949 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:44:39 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 92B9940015;
        Mon,  1 Apr 2019 14:44:34 +0000 (UTC)
Date:   Mon, 1 Apr 2019 16:44:34 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
Message-ID: <20190401144434.7n7lyiwan4eevgcn@flea>
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <c97024b97d3261dcf41aad3c8bc1c5d9906f33c9.1553032382.git-series.maxime.ripard@bootlin.com>
 <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iwvm5grjjbxassz5"
Content-Disposition: inline
In-Reply-To: <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iwvm5grjjbxassz5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Fri, Mar 22, 2019 at 03:55:19PM -0400, Nicolas Dufresne wrote:
> Le mardi 19 mars 2019 =E0 22:57 +0100, Maxime Ripard a =E9crit :
> > V4L2 uses different fourcc's than DRM, and has a different set of forma=
ts.
> > For now, let's add the v4l2 fourcc's for the already existing formats.
>
> Hopefully I get the fixup right this time, see inline.

Thanks a lot for that extensive review.

About the single vs multi-planar issue, I'd be inclined with just
supporting single-planar formats for now, and extend it later to deal
with multiplanar formats.

Would that work for everyone?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iwvm5grjjbxassz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKIj0gAKCRDj7w1vZxhR
xc5XAQCWJ0SmAXDtEg5F40yWfEoJRAUonrA9FZw78i6DOoQw/gD7BaIjPhVdiX2M
iVd1TxGMpsYo2RYXF7tt5GelhhdyAAk=
=vJ+5
-----END PGP SIGNATURE-----

--iwvm5grjjbxassz5--
