Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE434C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070220B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aujc7JBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDZGHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:07:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfDZGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:07:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44r3VC0ZK8z9s7T;
        Fri, 26 Apr 2019 16:06:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556258819;
        bh=ex1Tq565NI+kaJ4rqLl3oqMlyhAU2NtSa45+i+Fkgr8=;
        h=Date:From:To:Cc:Subject:From;
        b=Aujc7JBQ78aBTFtGeby3iMzTcKNG4Uo/M7lRkk8ymUS5rpQ/bf10q8BSVl8I3o22g
         tJPRKWcP8nM7bNrXfbr0E2tTIE+ikmVmPxUmZr1xLr10SxHQ9fBTaWiYmB9ACTIRfo
         9jDQbfl3J6EPjWAf9gnWE2xk4E20RaX2ysLyheu7UPyowqQQyFmxPcKt8aVAJUsaCb
         sciqeQ3lJg/4mrimeOUmL+M6FpgSliF7DGYLUtwqE693uCvf3F23vkiKXYxZR1QioG
         Mp5kQcmEsohcMEgwBgRbYFax5AmUXLji8IJwYTu+kaMzZkQAOz63p5qTM/cO9KzWps
         CuxsE6GJ12fRA==
Date:   Fri, 26 Apr 2019 16:06:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Cristiano Borges Cardoso <cristianoborgescardoso@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Jules Irenge <jbi.octave@gmail.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20190426160658.4929d1ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R5yihW0B/19T1CiRiJ4Pyoy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R5yihW0B/19T1CiRiJ4Pyoy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/media/zoran/Kconfig
  drivers/staging/media/zoran/videocodec.c
  drivers/staging/media/zoran/videocodec.h
  drivers/staging/media/zoran/zoran.h
  drivers/staging/media/zoran/zoran_card.c
  drivers/staging/media/zoran/zoran_card.h
  drivers/staging/media/zoran/zoran_device.c
  drivers/staging/media/zoran/zoran_device.h
  drivers/staging/media/zoran/zoran_driver.c
  drivers/staging/media/zoran/zoran_procfs.c
  drivers/staging/media/zoran/zoran_procfs.h
  drivers/staging/media/zoran/zr36016.c
  drivers/staging/media/zoran/zr36016.h
  drivers/staging/media/zoran/zr36050.c
  drivers/staging/media/zoran/zr36050.h
  drivers/staging/media/zoran/zr36057.h
  drivers/staging/media/zoran/zr36060.c
  drivers/staging/media/zoran/zr36060.h

between commit:

  8dce4b265a53 ("media: zoran: remove deprecated driver")

from the v4l-dvb tree and various commits from the staging tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/R5yihW0B/19T1CiRiJ4Pyoy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCoAIACgkQAVBC80lX
0Gx9Rwf7Bi9v27JI+CUkXu1c4zKuj7ZMQfnCtLRBZ//cn6MnKUnnb0unp9K7ceCA
fYM7Se3TOfDJSvy4XKv/jfPCxuS/hPAuTA2xpXKdRJWiVgFMaGDhqC12DshkfYJ7
L/SyKk+o9affZCx8SBIXWMmOg1Frwx8XfdmFMT3En6yAww6B9PepthvAYUyNH3Fl
aRGkdOTKbTveyEnIfVYiiym/mEc8jnFnz59mSO4iUzb60oe1bxCvJQ5fMQ5Zzdto
SQPF7TNhFRgK9XSQpIEJdGprhIjrlux2bsvoX6fS7HindLkZJE2qhEPmqVjwaJIo
vJoMjGcgZaS8rlxMLm5zUQ0TQnX3Ig==
=S+98
-----END PGP SIGNATURE-----

--Sig_/R5yihW0B/19T1CiRiJ4Pyoy--
