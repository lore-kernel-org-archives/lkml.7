Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D536C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEA520872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555428321;
	bh=TXd1Que8q9JefKDbB3lywOdQ7QEexs6IfO+013D9kjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A9ZFhA0fAXzba5KgM+ZUuAMQvBwmJ0VImw4SPT29ti9O/MWBgTVXuLy5PjwLbC1rn
	 QsiaNDmfxKMfTha5M4aEHJ5dK/mRpUAZp5SvUW2ASnHJBoDs3HbWPf4Uv3FDSaUmzg
	 cYtGjxOg7p0j0dYhDx3bEX4d/ZTTTBXMSUK0nHYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfDPPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:25:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDPPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=97s3gR9q9+SKOqjcylt2aLK8wsMHkUVQhNRWHvepVQU=; b=XQHnRwLtmGAesf34VkHozGKtQ
        N54d9PmcR1F3xs4zJEVW3IJC3ddnVogAJwq/FMC7Usc7b8YS1lIMksrXjhm+JXDpGdFH+lSv5wCeQ
        KUxGDlyACxTSVWDMZ9phfI+xNR3Llf0yglIf9iQHrQb1EnXkjzchISy0+s3I+oXvsW9dc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGPxR-0007Rb-Sk; Tue, 16 Apr 2019 15:25:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5D1791127BAE; Tue, 16 Apr 2019 16:25:13 +0100 (BST)
Date:   Tue, 16 Apr 2019 16:25:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V1 2/3] Documentation: devicetree: regulator: add binding
 for slg51000
Message-ID: <20190416152513.GD4834@sirena.org.uk>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
 <969035f30e614fd68288a0e21b729ae53ef3fca0.1555389447.git.eric.jeong.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <969035f30e614fd68288a0e21b729ae53ef3fca0.1555389447.git.eric.jeong.opensource@diasemi.com>
X-Cookie: Who messed with my anti-paranoia shot?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 01:37:26PM +0900, Eric Jeong wrote:
>=20
> From: Eric Jeong <eric.jeong.opensource@diasemi.com>
>=20
> Add device tree binding information for slg51000 regulator driver.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  The binding
itself looks good, just the subject for the patch.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly189gACgkQJNaLcl1U
h9BW4gf/ZSbFJ35+XH3l4hbuO2Z72nfkvFx+gVrWx0cOy8sG9V7hp+YM1skdVwRN
x1H+eySCuBZ34hBsQ4E3+u8L+5ZuiTyufAPoErTGjNzrRWkJcNdEC+tPiP3OcnI4
FnblZe/sfxRmYEoI/3LYqgDCNEw0JPoAyXlFLf0MbFF16F1COlsptNswjMMCej0p
pS0JT9jeXM9a/snOaK+cQKm/TKUEAK5GjWou96KOPMha+3IOWrRpH8wz59JJ2oQu
bES1viNPAF9ABipn5s6mCcT2pPMvOFstdK+Q3DWFcnMk4T9O0/4Oo/emOppTxsY6
TvepcSNVIbSVpo+QfXnIVBRbk9Mryg==
=PBl8
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
