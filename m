Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87573CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C56420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407880AbfJXLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:06:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60864 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390184AbfJXLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:06:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A11C58022A; Thu, 24 Oct 2019 13:06:30 +0200 (CEST)
Date:   Thu, 24 Oct 2019 13:06:46 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        gregkh@linuxfoundation.org, mathewk@google.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, rajatxjain@gmail.com
Subject: Re: [PATCH] drm: Add support for integrated privacy screens
Message-ID: <20191024110646.GA3419@amd>
References: <20191023001206.15741-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20191023001206.15741-1-rajatja@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-10-22 17:12:06, Rajat Jain wrote:
> Certain laptops now come with panels that have integrated privacy
> screens on them. This patch adds support for such panels by adding
> a privacy-screen property to the drm_connector for the panel, that
> the userspace can then use to control and check the status. The idea
> was discussed here:

Much better than separate /sys interface, thanks!
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2xhcYACgkQMOfwapXb+vIjEwCfZNt9uNWn1cpGqm52zi2jnmLS
FSgAn2E8jnEY2ASQyMChHIEUwyWX5mIJ
=yjtg
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
