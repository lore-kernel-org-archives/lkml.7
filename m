Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA14C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A16320684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfHLNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:55:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47529 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfHLNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:55:23 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AD3FC240003;
        Mon, 12 Aug 2019 13:55:19 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:55:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        paul.kocialkowski@bootlin.com, wens@csie.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] media: cedrus: Improvements/cleanup
Message-ID: <20190812135519.ysmqytkhtln7sknc@flea>
References: <20190530211516.1891-1-jernej.skrabec@siol.net>
 <274221f1-b2d2-83aa-d84b-e1c572a1b832@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ghcmst6jaoa4kn7"
Content-Disposition: inline
In-Reply-To: <274221f1-b2d2-83aa-d84b-e1c572a1b832@xs4all.nl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ghcmst6jaoa4kn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Mon, Aug 12, 2019 at 02:12:21PM +0200, Hans Verkuil wrote:
> On 5/30/19 11:15 PM, Jernej Skrabec wrote:
> > Here is first batch of random Cedrus improvements/cleanups. Only patch 2
> > has a change which raises a question about H264 controls.
> >
> > Changes were tested on H3 SoC using modified ffmpeg and Kodi.
> >
> > Please take a look.
>
> This has been sitting in patchwork for quite some time. I've updated the
> status of the various patches and most needed extra work.
>
> It seems that patches 4/7 and 5/7 are OK. Maxime, can you please confirm
> that these two are still valid? They apply cleanly on the latest master
> at least, but since they are a bit old I prefer to have confirmation that
> it's OK to merge them.

Yes, you can definitely merge those.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5ghcmst6jaoa4kn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVFvxwAKCRDj7w1vZxhR
xaNLAPsEGPiyqOdRajYEA4cGxVY18jjPs7B80tUGLwn7y/lX7QEA1hoN114NPrjR
odSkIRw1Cs9MkNQXMbozY4cjiWx8ZAs=
=JSLg
-----END PGP SIGNATURE-----

--5ghcmst6jaoa4kn7--
