Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EDC21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557305891;
	bh=VcOcbcSWmvlpOLjisqafGwTCzPtqOaTUyYdLw+TCYpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yVpHaxCswBhiTEw2mwfxluKPVDVpfjUeb1Pgb+jV6S8RoU7asrNMNzGH7csR6FyP/
	 +Eri1YYRYAIGjwF2rADosJOcKoxRLSn5BkW4B1IPFzN2dk7ybvz4qoU+vZQPCr16Zo
	 WdeZBG5QxxdXlxw6Qzs7oXN0aPPzXjNvJwUU63q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEHI6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:58:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38784 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KTjwJzNEtFSkajH3vzYgeB4/wr8Nulp6GSXxHnJTs1w=; b=R/IiKVNHytRDHVp/N5eLDfhDs
        vKurTSDWONqGK7kDJXnhJBuIEAQZCyUomPODNRHRadpwsxEDApU5oPf+fjzItGm3zmR8Qrk+X/11T
        0Z34cRPGkvW9gAuglwnjhnKIUN32a/CNtozggzi0qilCF0vcvONfZId1mWGvRQTd1DPu0=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIOr-0007cn-97; Wed, 08 May 2019 08:58:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id DBC1D44000C; Wed,  8 May 2019 09:57:58 +0100 (BST)
Date:   Wed, 8 May 2019 17:57:58 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Message-ID: <20190508085758.GE14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
 <20190508070058.GQ14916@sirena.org.uk>
 <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xTSxoVlouPBwYsmu"
Content-Disposition: inline
In-Reply-To: <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xTSxoVlouPBwYsmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 10:08:44AM +0200, Jerome Brunet wrote:
> On Wed, 2019-05-08 at 16:00 +0900, Mark Brown wrote:

> > The advantage of mutexes is that they are very simple and clear to
> > reason about.  It is therefore unclear that this conversion to use
> > atomic variables is an improvement, they're generally more complex=20
> > to reason about and fragile.

> The point of this patch is not to remove the mutex in favor of atomic
> operations

Sure, but you mixed in a conversion to atomic operations as well.

> I can put back mutex to protect the flag if you prefer.

> Another solution would be to use the mutex as the 'busy' flag.
> Get the ownership of the hdmi using try_lock() in startup() and
> release it in shutdown()

> Would you have a preference Mark ?=20

Probably using a mutex for the flag is clearer.  I'd rather keep things
as simple as absolutely possible to avoid people making mistakes in
future.

--xTSxoVlouPBwYsmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSmhYACgkQJNaLcl1U
h9BLvgf9EVKAriQdgUhiq7Dz6aMAyyxmJDlqE/NScBYilBPz2t8G+HA2cvFlWiFK
zs5sJD8+Ilb+vIkLNTYWOwVllxdbBD/DYbm5YwxrZ2wF/J0Baa/8aW1UfCnnrtZr
pZnLGa9koscaXO7WSfi736t4neICdQZssXTNKBYfocxxD3ZkL0Yy2fUQRt4/WSr1
+aIF3xIlY+Hc36obOIKYk1Ds+1fIwYGjFtzeeSz8ucaJGI0/GZE3ATnVQ/RjtEly
dSq+r0n7kb/ZLWLDJipmPae0Q4gqdaQ/mtt825n0U5JTJVS5hWjEZHMbX1WhwzvJ
+Tc+JzCa2D7cicvc2W2OsR9GrWD0CA==
=dhQr
-----END PGP SIGNATURE-----

--xTSxoVlouPBwYsmu--
