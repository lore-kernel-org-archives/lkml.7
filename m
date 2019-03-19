Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2E20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cqvwo9pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSVVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:21:09 -0400
Received: from ozlabs.org ([203.11.71.1]:56403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCSVVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:21:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P5ZT2wF6z9sBV;
        Wed, 20 Mar 2019 08:21:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553030465;
        bh=fkVJTjx4UaiqbcGLLsAzWU+Eu1DAMpqTHLfGqqW2QHE=;
        h=Date:From:To:Cc:Subject:From;
        b=cqvwo9pznO1iOUcO/SFx/uKwf1NOkGEtXdXfwCcTwbkV2kg45DAva4Q4/3Hqb9pVA
         xcgqXvvIUj69+aILO+SMWoMcbjIztxlMGoIJkgwHmrY1JeVa7PmCOWoOQCoGEsvexa
         P35kHn9Ycy1GUdv+xNiKUiCommjHGLi0NzJJM5r5ojMxTHFiLJUolAqhd+OSgGy/oC
         6O4f8zUDyVZRWefMsU34C7Ow4r+p6Q1s4AbggGBxeDGIqSeu1+2mV0UuRpT/eLRy53
         W0iu+W8BVzKwNb1psauz3ostE+ZSwD1PVLUAXp5YGS2S7zLEIPkhfGuOMy2/EBW42Q
         lEa+HOz7nkLnQ==
Date:   Wed, 20 Mar 2019 08:21:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: linux-next: Fixes tags need some work in the v4l-dvb tree
Message-ID: <20190320082103.33faecc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CvF6ijSEHOPcIWeUBaffbQU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CvF6ijSEHOPcIWeUBaffbQU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e6f8bd59c28f ("media: gspca: do not resubmit URBs when streaming has stop=
ped")

Fixes tag

  Fixes: 6992effe5344 ("gspca: Kill all URBs before releasing any of them")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

In commit

  904371f90b2c ("media: imx: csi: Allow unknown nearest upstream entities")

Fixes tag

  Fixes: bf3cfaa712e5c ("media: staging/imx: get CSI bus type from nearest

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not wrap Fixes tags onto more that one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/CvF6ijSEHOPcIWeUBaffbQU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRXT8ACgkQAVBC80lX
0GxVOQf6AlwmkMC9S5hkHasfSbyvpZN5Xj9+m/NXEU1SL0eRK9yGBzv2EpxVsQ6o
faeg+LTxJaJ0wOhZsgPNbMwX+APSylZepn+jG1JrEYAGOSgrrR9oJFaNj0ln+hew
d/cqEnmjsMVI4F6xHV53vfrJgfFO6SS/KRjL4VGKHLEKRw3Xs5rVPSs8J8Z7h1h9
iYv1h40F16sAji9d3Ci+i1nhP+YcXhzYwHkcLQGZm1Nz/mWEvhJ72tcG3vmJujJs
r0URmYqe1D1jif89+PNlvgGoNfgbr1lfOiQ7hSZJc0fSUCFjUSTHtNLa7kXBOJ7v
pA5FSMHyEBD822pv03pjmBxyjCB2yQ==
=UTpX
-----END PGP SIGNATURE-----

--Sig_/CvF6ijSEHOPcIWeUBaffbQU--
