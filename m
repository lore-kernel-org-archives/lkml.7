Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D373C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A87E2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553837794;
	bh=75/BEDvMj0sgTthV87F60dynKtJgqT/KpDT+e9LTksU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NDxxoGn0KsxHYPlfra4FbXID77RvxLq2wFzOGGrdMaqEt9cGy5cp39qk0tOpF51OA
	 o7RBvHm1zc2QNDn4ccsuXVt+jLdrLvt2StkmDj4rRsIuKiKwuUhGqkUYjtwesScpGX
	 w5kVLJYKp4W7//J3pH0uZaWe+2UVKAeaxuPS8J4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfC2Fgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbfC2Fgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:36:32 -0400
Received: from earth.universe (dyndsl-031-150-142-041.ewe-ip-backbone.de [31.150.142.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12962173C;
        Fri, 29 Mar 2019 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553837791;
        bh=75/BEDvMj0sgTthV87F60dynKtJgqT/KpDT+e9LTksU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQZVGFQsTNsQ5SxjYjB/oWVd8yXewFJDRyWQKG9iClpfih/sNNu5sxxDfWcoLwYqd
         0Yylz/e9LZHCgRQ3fDnZg56nwurEwf0cqRgIc4pxgkSclWawF4OXsmNtz74vIVy9kv
         w+MPn5dIjFwE/kmxE3lCbOFx1ZMriduWfquRd7hI=
Received: by earth.universe (Postfix, from userid 1000)
        id 639293C08D5; Thu, 28 Mar 2019 22:04:37 +0100 (CET)
Date:   Thu, 28 Mar 2019 22:04:37 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190328210437.tcojjqynggk72zo2@earth.universe>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com>
 <20190322221654.GG19425@atomide.com>
 <dc24b66c-658e-41aa-c869-42c4a7e812a8@ti.com>
 <20190325145444.GK19425@atomide.com>
 <044f67e7-e196-a5b9-728b-a7c5f283f56f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghrii74l7jnyggtc"
Content-Disposition: inline
In-Reply-To: <044f67e7-e196-a5b9-728b-a7c5f283f56f@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghrii74l7jnyggtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2019 at 11:01:18AM -0500, Dan Murphy wrote:
> On 3/25/19 9:54 AM, Tony Lindgren wrote:
> > * Dan Murphy <dmurphy@ti.com> [190325 12:36]:
> >> On 3/22/19 5:16 PM, Tony Lindgren wrote:
> >>> I can control the backlight brightness just fine via /sys, and
> >>> backlight shows up as the trigger in /sys/class/leds/lm3532:backlight,
> >>> but /sys/class/backlight is empty and looks like drm can't find it.
> >>>
> >>> Do I need to enable some additional driver(s) to get this to work
> >>> with the drm driver?
> >>>
> >>
> >> Can you dump or point to the defconfig?
> >=20
> > This is just with the omap2plus_defconfig as in the droid4-pending-v5.0
> > test branch below [0]. That branch has Sebastian's drm patches. The
> > branch also has the older ti-lmu patches that I reverted for testing
> > before applying your new series and enabling it in .config.
> >=20
> > The drm driver (drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c) just
> > does:
> >=20
> > backlight =3D of_parse_phandle(node, "backlight", 0);
> > ...
> >=20
> > That should still work the same, right?
>=20
> Yes it should still work the same.
> I did not change the node name.
> So the DRM driver should find the node.

This will not work, since the next line tries to get it as a
backlight device, but it's an LED device instead:

of_find_backlight_by_node(backlight);

I suppose the backlight device could be instantiated on top
of the LED device somehow.

(sorry for slow responses; I'm quite busy right now)

-- Sebastian

--ghrii74l7jnyggtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlydNuIACgkQ2O7X88g7
+ppAog/9HDu2FtUIoAG8EpCXIUENPyp8q7H9suEpjKQ26n6wpdm1aeeAVUG/gUeT
CqqE77qq4O+k5ENxVK69W5t+8JiERfxLDRKfau53s6tVJ212uEq+8jGvFMr3DPgV
1ZGb2cAo/L7bGk01X6y6YWDduDM1C7KiVPAdp/Ui1ZJsbmyPTzxVGqchj8zt7pIS
aPVFvYOQsJ9Zx7661KBPS5+rYted2mJGhnRpLnTxJSJDtRYEq11V//FBkiap4o2p
B01rAQ0M/733SfuctnuJsyEfCEbJsq5DW0Ailp7YYTTWzfYbBsZgY95IeCOSMJZ7
Y/8EN95Whe1izlV3tCKqqf3nnQImn5MWFMZL+fGoW18uXxYGIhufwSyfBTUpAvWa
wVWI/+LFceoex6wsQU3h4MuJKqSwNA+NkLpN5WX1L/l/bgyDD6wpTMT4e/FcaXdC
AI3x7+T5QZcD2KfaJ7uLUsLZcNv4OvMvGnt9IBO465e4EKqDGnWLcjf8ziIYcf+9
gQi1VLqKtUclWXHsZLfAfOJzSXF9QD9Q0dn1iWNEzccA/QRLmg+af18urNSQ19j+
AaE5cwXQK4chIWUVWtzKbkwBS9Z3mj3G71DnVhpR9V6Wwr6z2GZjidAY6mSUhAwu
HZsslJMaTJaACoV7O/Vu4MRJ4i3m+dkGxhGXak1HHA7WBiyT0I4=
=tXzm
-----END PGP SIGNATURE-----

--ghrii74l7jnyggtc--
