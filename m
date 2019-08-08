Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58835C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291D8217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565268295;
	bh=lCsofZGv+cxb/oUf1c4muQ0GNQflHlLh+n32fEyltgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HYFrGe+a1V5Ocd3ESNsQd2mM3Ev837foNY1awoKaZQfpz4uxKRdc066vt2tGlSSSz
	 RMBcap17Q2qoo1mdeSQeHq4BJCQldcE2BtKMpteIM0JM2Mpy4NGNfaPrhj3SdizB5l
	 JEQr0MIUZEGw0ne0QLyeCEGpedIlAoJF2oHAGyoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbfHHMoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:44:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHHMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lCsofZGv+cxb/oUf1c4muQ0GNQflHlLh+n32fEyltgY=; b=rq4cT89puSmiOH6w551MDjl6P
        WFKsDiYQyjd16N+pdyGRdfd/4TbFM9y1ujcg5J0XPaEvbtEUC0HQUAQcsd32ZZasiVEHnZ/bQ1QAr
        /MeWf9p6T1hy+UyDZVVngOwOaODEFK6Lq4bcxCPDxX6ZZf35zRZ9DOHsQYHVJbLezWdoE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvhmY-0002rE-S3; Thu, 08 Aug 2019 12:44:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8BCD22742BDD; Thu,  8 Aug 2019 13:44:37 +0100 (BST)
Date:   Thu, 8 Aug 2019 13:44:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Message-ID: <20190808124437.GD3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20190808123655.31520-1-stefan@agner.ch>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 02:36:55PM +0200, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
>=20
> Deferred probes shouldn't cause error messages in the boot log. Avoid
> printing with dev_err() in case EPROBE_DEFER is the return value.

No, they absolutely should tell the user why they are deferring so the
user has some information to go on when they're trying to figure out why
their device isn't instantiating.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MGTQACgkQJNaLcl1U
h9AZOgf/ec4pDTD4WicmfgDb6XwsH4eD1aXoxrGSnAB5x5OCvTtls7jFlVUGSmQx
J9Ymtb5GfHoT9di2uTZimz1Pj8K97ahY3Ov4Tebl6pinVRZh9cH7j0L03gaxRDQP
EEVUkju6pq09n9JR8B2F6iIvoZb6YPRZcuOlZInlbwuW+S1hk25rmGvenhsryxgD
JytTBgBlByqutRVIPLSFI1MDLgyGoF5BtgAqqiCP+wccGpa5vSsfpdOY9lPkA/Dz
1J8RvlsWkcJg4Q/YPBAA96CS5IwlX2Cf2EVOs02vTFIldoZub8j/ZMSfhAJhNph8
pUWXwAmBMFjCoV9IoS4b5XlmBjq1Vw==
=Ire8
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
