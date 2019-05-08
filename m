Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67DC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5020656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Wx6Lz/ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEHBym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:54:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfEHBym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:54:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zKKT5hzNz9s3l;
        Wed,  8 May 2019 11:54:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557280478;
        bh=uoaM4/kFzgSgOBal6RL10pdCs262sqiKKMIevH31Us0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wx6Lz/ssAHJOmbV3p2X/ZFdVoZe+zNiKRt1vYZW/EDr6iKD+ZNmDcR7jwH1OEnreo
         1kZxGstI1UCFA3kmknosfHl8tzVusmngHQoMTNx2jRZ1uwWE0QujYoJQPJWq68Sqav
         dN7CzaOqrhRR9dyktrih29c+AcfOL8V6kZ3W3j4q9Vw4Fe13JSXapBmYiboWM+YmfC
         OpAFGeiFhFnlddcynv8C3yiPPVbMzT6y+qt1tOnLgrWQu7JW9vI1w6jMSvA9UQgqDL
         glJrQgaR9nAo0Wn2enlzmiM28bdJ9XcItD1XlBALgN2OVZtImcv5wYDbQ6FviTYH/1
         hqSSsL+JvlsEA==
Date:   Wed, 8 May 2019 11:54:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Cristiano Borges Cardoso <cristianoborgescardoso@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Jules Irenge <jbi.octave@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the v4l-dvb
 tree
Message-ID: <20190508115436.43cd6bc0@canb.auug.org.au>
In-Reply-To: <20190426160658.4929d1ad@canb.auug.org.au>
References: <20190426160658.4929d1ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y2.zRoqKy//H05ubAmjuWI6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y2.zRoqKy//H05ubAmjuWI6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 26 Apr 2019 16:06:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the staging tree got conflicts in:
>=20
>   drivers/staging/media/zoran/Kconfig
>   drivers/staging/media/zoran/videocodec.c
>   drivers/staging/media/zoran/videocodec.h
>   drivers/staging/media/zoran/zoran.h
>   drivers/staging/media/zoran/zoran_card.c
>   drivers/staging/media/zoran/zoran_card.h
>   drivers/staging/media/zoran/zoran_device.c
>   drivers/staging/media/zoran/zoran_device.h
>   drivers/staging/media/zoran/zoran_driver.c
>   drivers/staging/media/zoran/zoran_procfs.c
>   drivers/staging/media/zoran/zoran_procfs.h
>   drivers/staging/media/zoran/zr36016.c
>   drivers/staging/media/zoran/zr36016.h
>   drivers/staging/media/zoran/zr36050.c
>   drivers/staging/media/zoran/zr36050.h
>   drivers/staging/media/zoran/zr36057.h
>   drivers/staging/media/zoran/zr36060.c
>   drivers/staging/media/zoran/zr36060.h
>=20
> between commit:
>=20
>   8dce4b265a53 ("media: zoran: remove deprecated driver")
>=20
> from the v4l-dvb tree and various commits from the staging tree.
>=20
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the v4l-dvb tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/y2.zRoqKy//H05ubAmjuWI6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSNtwACgkQAVBC80lX
0Gw93AgAgXI+L7EKmqLwU/ffg+z9s8iyRFRYmx/S71Paap7Z9yoMxFDmQwgviuLU
hDT3h92tucDNb5eeFRg67dc+2pJ04VrcJMt9+X2euBqHKW6XXdxIIqx+CErWzqdi
zhcetUB1Y9S8ULEOaKX+WYhntTJBERFEBKWYA9dCVOGlZOZXLrzrt8Rc5yY8IflB
CCr2t3XL1BqF1S2ncuu457EydOKu1t/oJ+Qz9svxTTCowQKEjFqMIrJ6VQVZe16Y
1hQEbpmHbuIB6FlH+wzDfbex7qB5xGCTevesmk2YiFQ4tx8+aJ2GSFQpwfJRFVAI
teswJyi+AY3dB8oQhifiZmafApIqwQ==
=xf3A
-----END PGP SIGNATURE-----

--Sig_/y2.zRoqKy//H05ubAmjuWI6--
