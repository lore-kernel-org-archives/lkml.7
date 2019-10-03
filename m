Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA35215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570115759;
	bh=TYOnIuRjzhdf6d/+AussWQ/jrj8Mub0Q/qfG0zOFxO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XqSUFCf7kRoxW+9b26ROJn2R+LmiwXA4DypPTTsQitAa72EuTFpHdTK0kX2Lbwwng
	 Zr2vVYZ2Dax6NtHnPYTcXPEZ6VmUk2kiAcT13FUaE0jx6ORbR7xSxe0/TRgdlbOVKE
	 SBTWPNU+B4R/Mc1BdxMEU/1+zkOiffTUya6SFEUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfJCPP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJCPP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:15:58 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C542133F;
        Thu,  3 Oct 2019 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570115758;
        bh=TYOnIuRjzhdf6d/+AussWQ/jrj8Mub0Q/qfG0zOFxO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9Bv8u+dZ3vkxt9uu7BIYGOCnTaR8sUQzSd2GMf//E/hio6zBr/ZX3/1uNSKXwmwC
         He33ej1ByT54C6yQ0ToG1Dv7oO7FsaLJ8XSqG2Rygxs6e8hX08T58RwyUpstqrfuPQ
         n+HknfP9I6Vj4Kwin0VcsSvZ2UWnfgIdax1nR+No=
Date:   Thu, 3 Oct 2019 17:15:55 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/mcde: Fix reference to DOC comment
Message-ID: <20191003151555.64qabct3jmd74ypi@gilmour>
References: <20191002153827.23026-1-j.neuschaefer@gmx.net>
 <CACRpkdZ0ekYtZ4bZ-A4NZN6HO6XJzwpdZ_HjUL=FoWfG08UBtg@mail.gmail.com>
 <CACRpkdYDuAx6OhFYiXT+79a1NphtfPQfyY=o7jKi0Bas5vr7+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wxihfagc5o75k2e"
Content-Disposition: inline
In-Reply-To: <CACRpkdYDuAx6OhFYiXT+79a1NphtfPQfyY=o7jKi0Bas5vr7+g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wxihfagc5o75k2e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 03, 2019 at 04:39:39PM +0200, Linus Walleij wrote:
> On Thu, Oct 3, 2019 at 4:34 PM Linus Walleij <linus.walleij@linaro.org> w=
rote:
> > On Wed, Oct 2, 2019 at 5:39 PM Jonathan Neusch=E4fer
> > <j.neuschaefer@gmx.net> wrote:
> >
> > > The :doc: reference did not match the DOC comment's name.
> > >
> > > Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> > > Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> >
> > Both patches applied!
>
> ...but I can't push the changes:
>
> $ dim push-branch drm-misc-next
> dim: 9fa1f9734e40 ("Revert "drm/sun4i: dsi: Change the start delay
> calculation""): committer Signed-off-by missing.
> dim: ERROR: issues in commits detected, aborting
>
> Not even my commit, apart from that it looks like it does have
> the committer Signed-off-by. I'm confused and don't know what
> to do... anyone has some hints?

Yeah, it's pretty weird, I just pushed without any trouble.

Did you rebase or something?

Maxime

--7wxihfagc5o75k2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZYQqwAKCRDj7w1vZxhR
xfd6AQD/zc6r1v0NTQoKgRKELqgow/1Hm8wGjF422mloLB4VLQEAyokgh0l6DFKA
QgASZMRMHm9asS0gq4v//8nwRHxrUAc=
=ahDz
-----END PGP SIGNATURE-----

--7wxihfagc5o75k2e--
