Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F99C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376320717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c7XURf05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfDYNeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:34:36 -0400
Received: from ozlabs.org ([203.11.71.1]:41081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfDYNee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:34:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qdT41JL8z9s70;
        Thu, 25 Apr 2019 23:34:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556199272;
        bh=sez8CORGmaH7tE4amMn0SHA9ibFD2ShLmcRmhLWvY2g=;
        h=Date:From:To:Cc:Subject:From;
        b=c7XURf05V3ba0BdoY89SA1thxUvj9Tzcg/AZqGXTNKHbX/VEvmoyAKadh3ztqG5qG
         t8A2ll0+Hylryikfv+Pl6TgCEzz7dS151R8dUsf4RJCfJ2xntEb5rvOsd0oT7MzWry
         lFw7OWzGaOHqcX0+YINEEIrZ0A6CwctzYswBChRX6L8T7N4r8WiQztDjNIPzVoB0J4
         jjh7NzA+BMzsisBRIz0DZbvxbNzP3yed7u1h80I4uilKZnL8qyDjOcz1u/9s4c1S2R
         zSZZAvmdAZlE2mowUhFECUojQxds0SbWRmOC8fYqhyEpxu+K0Hd08t4fMC/QeXL70N
         YFwHTv+A96w3g==
Date:   Thu, 25 Apr 2019 23:34:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the hid tree
Message-ID: <20190425233430.14bdb102@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VptbqHJTGaAO0_23zbBy+FA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VptbqHJTGaAO0_23zbBy+FA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  39b3c3a5fbc5 ("HID: input: fix assignment of .value")

Fixes tag

  Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

In commit

  d43c17ead879 ("HID: input: make sure the wheel high resolution multiplier=
 is set")

Fixes tag

  Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not aplit Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/VptbqHJTGaAO0_23zbBy+FA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzBt2YACgkQAVBC80lX
0Gyi6wf/U880bovOfKFESGLQK8IsFPz3Y8utCcnHmkG3aUrMybPnWGfelwe30bhi
0yO9wqgxdsnssyt3atDPF0pKpWOdOHGXXkKalWRA/Lua4VTC01wjQ6fYnCI5xf0T
O1zP4xpnoECg6krPxidVfs9Jkmjn2RgZxSfLb9BoDNqmDpLq0w2BbxCkvDJzCLSU
lON5oeBH1VTSz7Nr1/RWIL+3+uUC9vjXS8asyYudsyHmiEnPEPu46jjM5TfakCdI
loKMKNL9yR/0Bb6ZEkRGOhceSKJZZ/Y6Gf3DIsFuFCWz7PndB/anA+bUNIe3OqOp
FW8cVLGSWEo3h2QRzLsNSdbAxLoIRA==
=+Ln4
-----END PGP SIGNATURE-----

--Sig_/VptbqHJTGaAO0_23zbBy+FA--
