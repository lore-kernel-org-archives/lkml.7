Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE0A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715086;
	bh=p8l9SzF3kiIac7Zn/76HtlmVZqN6tzyOkNzCjjdwSNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2Vj5mMLqaUFg0FEgrDR6mMAQCAFlK4es2cW1IRcWthsNCokDbSGH1XW4NQmN6sn1
	 6P34vavERr0xxGc6ME3ADxMmVbxMpTFuM0oC/t0ITunfCZlmZp5L7gumJaNWhQ8SxC
	 xibvQkyo3DMDKTa6mDslriajWwCybJH9+gpBOY84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfC0TbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:31:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfC0TbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9//SiVVHE1o8QV7AhZE5kciOjA9lzEsCX/ioITe2cOs=; b=f+9dgrEcde6IqnnUjO7F4RTqB
        fMS3hR5RWRHG1BGf3E64k5uX3K8f5T8YJVRPN1CKy2IWJ4xbT9LWR8fOHDvWnkRotKng2TSXInxCf
        0gil1DJsEbMSQfNSDADdFRzBFsn92EVPRq/r+nIDZvdcqxJjgtIX2pnTciPQS7Blpkcjo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h9EGa-0000iW-Mm; Wed, 27 Mar 2019 19:31:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 31C691128E2B; Wed, 27 Mar 2019 19:31:15 +0000 (GMT)
Date:   Wed, 27 Mar 2019 19:31:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 5.0 107/262] ASoC: qcom: Fix of-node refcount
 unbalance in apq8016_sbc_parse_of()
Message-ID: <20190327193115.GB11404@sirena.org.uk>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-107-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-107-sashal@kernel.org>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 01:59:22PM -0400, Sasha Levin wrote:
> From: Takashi Iwai <tiwai@suse.de>
>=20
> [ Upstream commit 8d1667200850f8753c0265fa4bd25c9a6e5f94ce ]
>=20
> The apq8016 driver leaves the of-node refcount at aborting from the
> loop of for_each_child_of_node() in the error path.  Not only the
> iterator node of for_each_child_of_node(), the children nodes referred
> from it for codec and cpu have to be properly unreferenced.

Given that the device tree is entirely static on all platforms using FDT
I'm not convinced that it is sensible to backport any of the fixes for
references not being dropped that are more than one liners,
realistically nothing is ever going to notice the extra references but
there are things that will notice if we underflow references so there's
some risk we could break things somehow.  Seems like it's all risk for
zero benefit.

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlybz4IACgkQJNaLcl1U
h9CR/Qf+IK1dAuZTewE12cGZTVrjxwfm2PU1rGE3uRQuGjgJALFdp02GF4wKOC/I
cZnzlL+k6Vy++7+TuInPAdr61tDNemUhW/yv7RM3alJFPrlLRTe12NG0uf5Wkieh
PE2PETkHvmMcQz48si8yZ66TDMhrNnlz5UdEJ2aNiJmLlpTga2IZluESXYbhYXoh
DCXMSgLfU8TgkW8CJbx0GoOIiXC9BNLaBeo3MLbg5jGsTQ9dxuJ3DqPwh22vrIR4
m2zrhHCgQ3DcSpEMBF9shEvr88+Tb99KKmGehphI9ZoNbb0Avi8iBy23TMzN75pu
BoJU87YnDd2eTBZWdJqTJHF5iJySwA==
=vUtI
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
