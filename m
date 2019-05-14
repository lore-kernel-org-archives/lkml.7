Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67393C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2320675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557825079;
	bh=5iwEwLS1q3rI3tAGb5MvfXH7TArOjbZqT169gIY63aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F+q0pBdqgkfzSu8XrtuIOBPecOAUNqYwz3m+WByxc7zho3VvDHqTEMBZbXK45g5GZ
	 ddTPFo0iujPcD1CcW9HryGyAlhIvcGulKFbXuNt107/+RYSNoTiy7bdXj4ev2Rudlp
	 yH1fXczpP+rO5/kS+iXSYv5iTPB1V9SmO2JTOGts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENJLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:11:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5iwEwLS1q3rI3tAGb5MvfXH7TArOjbZqT169gIY63aw=; b=qeo8z6lcGC5Q+l4zSa6K3Udf0
        TyPkOkFdLABZunCuMBawHnkr3YMpTu7Oop8c9CpS8YB/3hww/qqEyCFVmTnNw57JKF4/YWgwz/17f
        u0Auz0Y+RgjXpNwholppjO3aJRQ+GBjcltgeLpccEOVc9NPognMGJa/LSwmxOrVudpYz0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQTSl-0000YL-13; Tue, 14 May 2019 09:11:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 055E11128518; Tue, 14 May 2019 10:11:06 +0100 (BST)
Date:   Tue, 14 May 2019 10:11:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "angus@akkea.ca" <angus@akkea.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>
Subject: Re: regulator: BD71837: possible regression
Message-ID: <20190514091105.GA8665@sirena.org.uk>
References: <34f520784f0b489861d62bc30749bf2a@www.akkea.ca>
 <4efe8d75766719eee3987fd80b2c11a0e66c75fa.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <4efe8d75766719eee3987fd80b2c11a0e66c75fa.camel@fi.rohmeurope.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 06:14:41AM +0000, Vaittinen, Matti wrote:

> I am not sure but perhaps the regulator core is changed so that this
> parent/child relation must be modelled using <foo>-supply properties in
> device-tree. Are you able to bisect the change which breaks this? There
> may be other regulator drivers doing the same as bd718x7 is (which
> means trusiting to setting the supply_name in desc to be enough - and
> without deeper understanding I'd say it should be enough).

The framework will look for the parent regulator and warn if it can't
find it but it should still instantiate it if the mapping is a hard
failure (as opposed to a probe deferral).

> If this change is intentional and buck6-supply and buck7-supply are bow
> required also in DT, then we should reflect this fact also in bindings
> doc for BD71837 and BD71847.

It is always and has always been best practice to wire up the regulators
as completely as possible; this is less error prone and gives you more
ability to take advantage of framework improvements.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzahikACgkQJNaLcl1U
h9A4wwf+LXRrOGq+A/gGUmt/59Lbdhs1W19J/aIKbsahi0GaJVe5W0PWktgCOWuC
88TkX5EsPmUzcMoU91yOBATpxa5PGtxjqK+esXGStEB342WrPEaieL4skqpS9GXx
eawQSVIRM0l1i6kmzonT++Vpk6dP96A1sTmRXWiFQqMl9suDaC/rexsbY9F5ywjK
cZiCbTfEUbMi39soGbQU2hKr3DMBjIZgMt8njq2SUZfQkzPxcK+B7mC4Dt2PZQTn
AWuPxXySqB0VxAs7L2t05OkVqI93d1PF4aOJoLMug5B1GNYb2elAzQfCpW0D60H7
BZZV3sujvkvcvvrZk4IvzyTiQmbbDQ==
=okbM
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
