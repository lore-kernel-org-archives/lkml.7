Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D234D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfDARwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:36 -0400
Received: from anholt.net ([50.246.234.109]:46758 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732284AbfDARwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:52:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2AE4E10A0220;
        Mon,  1 Apr 2019 10:52:34 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id al1mPtCC0dIY; Mon,  1 Apr 2019 10:52:32 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CC6D010A280C;
        Mon,  1 Apr 2019 10:52:32 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 5DE9E2FE33BA; Mon,  1 Apr 2019 10:52:32 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/7] drm: Add a helper function for printing a debugfs_regset32.
In-Reply-To: <14f34f5ce32ca4943aec42e32878d6dcc7ea5524.camel@bootlin.com>
References: <20190220210343.28157-1-eric@anholt.net> <14f34f5ce32ca4943aec42e32878d6dcc7ea5524.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Apr 2019 10:52:31 -0700
Message-ID: <8736n11ulc.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Le mercredi 20 f=C3=A9vrier 2019 =C3=A0 13:03 -0800, Eric Anholt a =C3=A9=
crit :
>> The debugfs_regset32 is nice to use for reducing boilerplate in
>> dumping a bunch of regs in debugfs, but we also want to be able to
>> print to dmesg them at runtime for driver debugging.  drm_printer lets
>> us format debugfs and the printk the same way.
>
> Looks good to me!
>
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks!  Merged all but patch 3 (unreviewed) and patch 5 (needs patch 3
to avoid oopsing).  Sending out a rebased version shortly.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiT+AACgkQtdYpNtH8
nuh5mA//WrE5t0tlFG7qvNZARAuvvMlGUADM7MES8TIJlopJ7P91N4sCbMXTi2yX
746ICu6HCmCALJ0ggdvJmqBWelh1EAoTvCbU8eZMi2447ZjXtJpULCOtpQF2EunC
svt0sFZZRJOg8yVQ7HLNIdyinlSIJIFLG6tIetX/1A3qJU6SeeZLWhu+nlmZ2Gu2
vO3Rljcn0B/O1DhxNX2IjH2W+6jCQ2aV3r/VCZyuafc6uVhr9bOQwoSVW/nPiKpf
dufTMPcjQ6VGQ47/f047bC9/G5pMkqhaV93LkDC2nzrQ3JHUkhN4S8Q9xmkaK5/n
3dr7lcfqdzZ6niQVnBdZXVzfpqYZqnbZf42+TaBs9/WiaYtQLnOHqTaANIhCzqlz
teYhMXEiTINz1rXeqjLJji0QP/d3MFmOG/2wC3SIcyL19a7qmPKbfChlOKWtYdLW
SNGDt1iEjkpXmwFKovHnBevuKOzpCOuDaEZlMH0piobLutAS5EuGKuz9OeihuuFP
JPtrqVH0agnlifApkkIhwossdErtNAVdO2YCl24sE8BG/NHACm7CuwB6Kv7995kr
yctuFsrXI54SNXQQGSlSSZJ++BS+fUXRBXRcs4V4OqlwoNjbumJPyRnTNHA7Wuhm
RTcqSPOuEBczw45gG8ayJ5ruNPSEbKjdrWhengpOGXBuWPBkrpQ=
=Z28W
-----END PGP SIGNATURE-----
--=-=-=--
