Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F21C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700820989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557298039;
	bh=+/sbnSv6AbtIwYruxIrAxUaL5fbiA9dDj37HiDI0eD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWSTjAgXXIaf4nv7FYYNB2lIOwohchcEbxVtQzX6teiAuekofUcvZt3Hmlt+XOuUj
	 9emOujVisrRb2AHoqid52zUDBL0oXV6BfCOfXirE+f0CyH70J3nkvGXxAmZUFTRVAu
	 SjyBYsrf4JSYHUsTN8CpmVva0R2CGIlZVhYZHEEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEHGrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:47:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JL+LbvhP4oFaheRjv1trtE6LxKEuCxpw/hxnybibOFo=; b=Qsn5PZyAJb85n6FqIXoq1Doyz
        kbkc0hHAcXtVzfw/JBOHJ69xaPfVn45wJxDEG19KUWUmYVOuKaJm8+O/G4lI6RgJHEyV7mMo9XBML
        nw1V6KwivS4K8ciuY109zuFeuteox5h4x87lY42q0sp6+Qg2/6EqKtAKh6XybsTrQeNYk=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOGM0-0007Ah-RD; Wed, 08 May 2019 06:47:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 19A1744000C; Wed,  8 May 2019 07:46:51 +0100 (BST)
Date:   Wed, 8 May 2019 15:46:51 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5] ASoC: fsl_esai: Fix missing break in switch statement
Message-ID: <20190508064651.GO14916@sirena.org.uk>
References: <a2c4e289d292ac0e691131784962305f8207a4d8.1554971930.git.shengjiu.wang@nxp.com>
 <dc58fb7a-dab8-2ee0-43e0-76da75ca2e0d@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lBnNT+4yy4PYvQEb"
Content-Disposition: inline
In-Reply-To: <dc58fb7a-dab8-2ee0-43e0-76da75ca2e0d@embeddedor.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lBnNT+4yy4PYvQEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 10:59:00PM -0500, Gustavo A. R. Silva wrote:
> Mark,
>=20
> I wonder if you are going to take this patch.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--lBnNT+4yy4PYvQEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSe1oACgkQJNaLcl1U
h9CRVwf+J9kZp0ZGivYa2xRG/gV/6+6GHD70rFDgUlJM6lyD5Sr264ngHIIHZt27
YTxbrddXS+2NIcXwPl9j4eedxLJAXhjpoXMmRl2GyESUp1RS9GJpe4c8HfY4fkRn
TO7sDDFXMnFzXfI16ITdJFcrH8RXhPYkh1rYqLXkVwSYwImRLe4nbPsvmSQkG9a4
0x9yMs3yEAC6jCN0HF90Zq973JpS0yopSjEHwMCgmWo0oop4myuowyxhdE+fGP+g
kBs9soUAjBx8kAPvfXQoDJ5eszn+jX6uYuwb0OPzmo1TxM4JyzEFb4mgdR0yIaoC
Gp7eTnQ86sEao0Ju9pY+yfmZp9fz1w==
=wKTe
-----END PGP SIGNATURE-----

--lBnNT+4yy4PYvQEb--
