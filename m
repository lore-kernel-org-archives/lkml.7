Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68920883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552393453;
	bh=SfZAYMqd/Hl/SZhXVZVni2EWGYrH95ErS/2WoVWRD/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oAFJgFArYkUIxXXifzCUkPovk/c6ezF3GdHJCi+Ly4ZPDhkCMSqoEcRSZTtdflpr0
	 ea2VussIUxug1sxmFAJndToOAQjPDaFiOKFzOUXAqObTVJIuWh3JLKKXvwHbHGZFdj
	 MehuSy6B41H0Wsu40zsUrshb5P9dH0YdGlUIOY9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCLMYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:24:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfCLMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mpIy8bIXv3UeB91tWNDTuUxdU9RJ3/ZdDSRdNMr3UvE=; b=Sr0+jlvkitpvlGbtYUQ4Td/ol
        jZ2pVGYbFFnnd3NhhcYphr0KZaDdyWo/3/h4b0SiR/MXob8PFd6MQU1L7vmnkzC8h+aDKA/njQ6ap
        jY6zAW2BNgs1o4cZn4335xi3mgcyyKaewr7mSORMcCHwKOIcezCxdz9OOek+bPj9U7Zt4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h3gS1-0003Me-NR; Tue, 12 Mar 2019 12:24:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 10679112887A; Tue, 12 Mar 2019 12:24:09 +0000 (GMT)
Date:   Tue, 12 Mar 2019 12:24:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Volker Haspel <volker.haspel@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        han.xu@nxp.com, john.ogness@linutronix.de
Subject: Re: [PATCH v2 0/1] spi: spi-fsl-qspi: call spi_unregister_controller
Message-ID: <20190312122409.GD6983@sirena.org.uk>
References: <20190312101203.14207-1-volker.haspel@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20190312101203.14207-1-volker.haspel@linutronix.de>
X-Cookie: If you have to hate, hate gently.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 11:12:02AM +0100, Volker Haspel wrote:
> Changes since v1:
>  * use devm_spi_register_controller() instead of calling
>    spi_unregister_controller() in the remove function

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyHpOgACgkQJNaLcl1U
h9DjtQgAg5eiDB3pBA1vGOD4u4Xy5yMzK8wjQMOqxRAQ73fPQF9KQhm9vS+vdgOA
UrWrpMUXubQN1SAIDu2WP7XNz5xiAx4U4Clz29xsLeagiGPQ7pvxoK13WNA2iaoy
8DwgOmx2qpTGNWh3X1NNIKMVVOD7MnAnGNGGT7s1AfnANb3jr10j7iaLDRrR8+o0
i9K5Cjbh+2JHZ6KNOGBYIV7toLDGC8PX34MhMfeY7EMTxbTGrAhFt/uflOYi5YHY
cpsjrZ1tyfbpDLYQ+jPGRGfZ0Tk0YO19oguBoUwf4Kd1AirPfUb45XE4cGPQfJ2T
IlW6mPvjUSvMJc7CLW3dPd3ZE+DQBg==
=aWMA
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
