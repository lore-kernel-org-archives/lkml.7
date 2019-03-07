Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCGPbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:31:06 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46467 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfCGPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:31:06 -0500
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9B9EC2001E;
        Thu,  7 Mar 2019 15:31:03 +0000 (UTC)
Date:   Thu, 7 Mar 2019 16:31:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190307153103.hsckxwzg2ypckicy@flea>
References: <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
 <20190301093038.oz56z22ivpntdcfw@flea>
 <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
 <20190305092830.ef45kxzhdnxlh63g@flea>
 <9f189569-bf76-22d2-3bf7-db710f616998@wiesinger.com>
 <20190306073605.modlx4yhdzbg7sfz@flea>
 <34300c49-fe89-77cb-444a-f6de02d41a62@wiesinger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yiolvsyzm44msxql"
Content-Disposition: inline
In-Reply-To: <34300c49-fe89-77cb-444a-f6de02d41a62@wiesinger.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiolvsyzm44msxql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:03:00PM +0100, Gerhard Wiesinger wrote:
> while true; do echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"; ech=
o -n
> "CPU_FREQ0: "; cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq;
> echo -n "CPU_FREQ1: "; cat
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq; sleep 1; done&
> ./stress/cpuburn-a7

Run cpufreq-ljt-stress-test

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yiolvsyzm44msxql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIE5NwAKCRDj7w1vZxhR
xcShAQDBWSeEDEQjj/DWW1+cTKk9oxJ2h09VFL7aSTCsuY2JAgEAviFRRoIU8EKz
hP9rJgcGmIkj0Q5nQwx8mx1dTm/Z1QA=
=MYLM
-----END PGP SIGNATURE-----

--yiolvsyzm44msxql--
