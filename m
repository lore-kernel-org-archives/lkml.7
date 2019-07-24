Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D958C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586112083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfGXIxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:53:02 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34835 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfGXIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:53:01 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3181760012;
        Wed, 24 Jul 2019 08:52:54 +0000 (UTC)
Date:   Wed, 24 Jul 2019 10:52:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     "kishon@ti.com" <kishon@ti.com>, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <20190724085254.2amajixbxllgfluq@flea>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
 <20190711112039.leuvelpm7opeoaxq@flea>
 <678F3D1BB717D949B966B68EAEB446ED2FF5B22D@DGGEMM506-MBX.china.huawei.com>
 <20190717163753.ti6swjfhm7fczcn4@flea>
 <678F3D1BB717D949B966B68EAEB446ED2FF5D942@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhoe2rfuq6ldgivi"
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED2FF5D942@DGGEMM506-MBX.china.huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhoe2rfuq6ldgivi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jul 20, 2019 at 03:03:20AM +0000, Zengtao (B) wrote:
> >-----Original Message-----
> >From: Maxime Ripard [mailto:maxime.ripard@bootlin.com]
> >Sent: Thursday, July 18, 2019 12:38 AM
> >To: Zengtao (B) <prime.zeng@hisilicon.com>
> >Cc: kishon@ti.com; Chen-Yu Tsai <wens@csie.org>; Paul Kocialkowski
> ><paul.kocialkowski@bootlin.com>; Sakari Ailus <sakari.ailus@linux.intel.com>;
> >linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >Subject: Re: [PATCH] phy: Change the configuration interface param to void*
> >to make it more general
> >
> >Hi,
> >
> >On Wed, Jul 17, 2019 at 06:36:09AM +0000, Zengtao (B) wrote:
> >> Hi Maxime:
> >>
> >> Thanks for your reply.
> >>
> >> >-----Original Message-----
> >> >From: Maxime Ripard [mailto:maxime.ripard@bootlin.com]
> >> >Sent: Thursday, July 11, 2019 7:21 PM
> >> >To: Zengtao (B) <prime.zeng@hisilicon.com>
> >> >Cc: kishon@ti.com; Chen-Yu Tsai <wens@csie.org>; Paul Kocialkowski
> >> ><paul.kocialkowski@bootlin.com>; Sakari Ailus
> >> ><sakari.ailus@linux.intel.com>; linux-kernel@vger.kernel.org;
> >> >linux-arm-kernel@lists.infradead.org
> >> >Subject: Re: [PATCH] phy: Change the configuration interface param to
> >> >void* to make it more general
> >> >
> >> >* PGP Signed by an unknown key
> >> >
> >> >On Fri, Jul 12, 2019 at 02:04:08AM +0800, Zeng Tao wrote:
> >> >> The phy framework now allows runtime configurations, but only
> >> >> limited to mipi now, and it's not reasonable to introduce user
> >> >> specified configurations into the union phy_configure_opts
> >> >> structure. An simple way is to replace with a void *.
> >> >
> >> >I'm not sure why it's unreasonable?
> >> >
> >>
> >> The phy.h will need to include vendor specific phy headers
> >
> >I'm not sure this is an issue.
> >
> >> and the union phy_configure_opts will become more complex.
> >
> >And this was the plan all along.
> >
> >> I don't think this is a good solution to include all vendor specific
> >> phy configs into a single union structure.
> >
> >The thing is, as Sakari have stated, this interface was meant as a generic way
> >to negotiate a configuration between a PHY consumer and a PHY provider (ie,
> >whatever sends data to the phy and the phy itself).
> >
> >If you remove the explicit type check, then you need to have prior knowledge
> >(and agreement) on both sides, which breaks the initial intent.
>
> I get your point, so if we follow your design, it will look this:
>
> union phy_configure_opts {
> 	struct xxxx1_phy phy1_opts;
> 	struct xxxx1_phy phy2_opts;
> 	struct xxxx1_phy phy3_opts;
> 	.....
> }
>
> And the general phy framework needn't to know about the type but
> just pass through, the caller and the phy driver definitely need to
> know what they are doing.

I'm not quite sure what you mean here. The configuration only applies
to the current PHY mode. So the phy consumer will have changed the
mode, and the PHY will have accepted it.

That change is also doable from the framework.

Then, which part of the union is being used is easy to figure out for
both parties, since they agree on it already.

> So I suggest a more general type void *, otherwise the general phy
> will need to see a lot of details which is not that general.

Except that this effectively becomes a black box that the framework
has no control and / or knowledge about.

Which means that it cannot do any kind of checks on it anymore, and
again, that the consumer and driver need to have prior knowledge of
what is being passed, without any way to check whether it's actually
what needs to be passed.

To some extent, the union also allows that, but it's just less
explicit and in general worse, to just pass void* here.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zhoe2rfuq6ldgivi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTgcZgAKCRDj7w1vZxhR
xbVJAQC2WbhGtzvCUsqlgubaKt5tOZDSw/86LuIRNUn0C631dQD9GWfS8I5V23G8
OJ5HZ5/L3OnvQJfGu3rgI+p9a7tHdgU=
=jk2+
-----END PGP SIGNATURE-----

--zhoe2rfuq6ldgivi--
