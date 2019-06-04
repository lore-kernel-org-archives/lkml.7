Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04392070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NMXueQNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFDVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:53:43 -0400
Received: from ozlabs.org ([203.11.71.1]:41523 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfFDVxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:53:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45JQfV4RwXz9sNl;
        Wed,  5 Jun 2019 07:53:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559685219;
        bh=cHNqCa+2DKAV6M0vMR9bkHDYjtCKwtQoZhwxJ+54gVI=;
        h=Date:From:To:Cc:Subject:From;
        b=NMXueQNnTEcIDQt5X450JA3xwHhFoOXBn4Buv4VarPzSbw1U7RY8/uFkNlOAjMNx9
         XnOibpQFQrCnnfH4JV6YC/AwqIR/0E21n3x/J1KZtDo6vK3glguw/IP+Jich2tF89s
         rnB8uEPXsAJeT1r9IzY8dRoX5F6eY5+4ovSeqAXy5ACxFg3yyeH2NQ9NUenQOmJbTZ
         46GjhyFA4k90W/W/E7VR0v57MxE0VXHKWgFHz7GI9RFCu5jMY+9zhxRhSLzV8HMp3a
         AUbtC+RN8okV9Un8bFt+glmqRL3hnKl1YxzqU9azJnVGlxeLBY7S2VSNN3ROjR3iwl
         WyHbMiCslZlTQ==
Date:   Wed, 5 Jun 2019 07:53:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the chrome-platform
 tree
Message-ID: <20190605075330.79a4725d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/un..cX/b10_C=VlA+JHf84O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/un..cX/b10_C=VlA+JHf84O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4c1bd8b0e181 ("platform/chrome: wilco_ec: Add telemetry char device inter=
face")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/un..cX/b10_C=VlA+JHf84O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz26FoACgkQAVBC80lX
0GyYRQgAjUyXj7QxTT/MRJDPEt2YlXkC9JAXiSGE/tkj/mzpB1FUpu990OmwCd9c
lKU1B0omKGxnKC84cvnt1N4YSu6WQNDaaOkOCB3qIu/mb8Zn8b5WcocYQUq/yafp
5+gD+Tl+ZZV0myVGRN1eDxtSNw2TMev9kcnwGJRAhdGwNss1nwUI9iyYb0f0igFC
l98oov21u6QGO2MvUhNW9cRyeqrY+7a1Y6z415RJyAV6HJdh+MqKYyvlkoedRtd/
fUO2543RDNhEzW+3Eu4oVgYXr2Dgl1V9YhK3g7Efw108yZM6+qMwQcJCYccw1b8C
VF5U/dE+BZrbQV3l8m+4/r93aODTAQ==
=19ng
-----END PGP SIGNATURE-----

--Sig_/un..cX/b10_C=VlA+JHf84O--
