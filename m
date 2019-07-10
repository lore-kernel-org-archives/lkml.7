Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75818C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E6208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aKycbOiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfGJQNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:13:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfGJQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:13:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kPPk0n6Lz9sML;
        Thu, 11 Jul 2019 02:13:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562775226;
        bh=PsD1DLu1T8iuP/rPQye66pKS7166/esUt5eFkZEB8FM=;
        h=Date:From:To:Cc:Subject:From;
        b=aKycbOiHmernc+t/1qoWBfwLA8etOawAF1lUe5mj9q4ojV4Onn9sCyA3RigHAYR+b
         F/FNaJtAd3WGWt9iUeAAnIkyyKgWAa9q+djxZlZzOFW4HCcggmXdlNrV6Ckuh12Irx
         igr/tCosr+OPEdSBHgEW/ITrKS5BgiYUxKC8TkYF/4SjhNWDI5ewSuAgAOo+Jf3J1O
         i5hvJ1yqgZtoQ64iyMXdQEI1fxUcGllS3haFGx8HzPid0+bDrZBN5W32u+QqMlEtzy
         YLJ7xJiY/0O961tSTMUVMWcg7oz7uFsAvfTcc1DNfOqlQ54OGv4PnrZ7reSiJ4OhHl
         WaAV8xRRHyINQ==
Date:   Thu, 11 Jul 2019 02:13:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190711021344.774c81e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7cSDTpb8CphHmk0N=2oPlmk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7cSDTpb8CphHmk0N=2oPlmk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  52db6685932e ("ASoC: simple_card_utils.h: care NULL dai at asoc_simple_de=
bug_dai()")

Fixes tag

  Fixes: commit 0580dde59438 ("ASoC: simple-card-utils: add asoc_simple_deb=
ug_info()")

has these problem(s):

  - leading word 'commit' unexpected

In commit

  6cd249cfad68 ("ASoC: max98357a: use mdelay for sdmode-delay")

Fixes tag

  Fixes: cec5b01f8f1c ("ASoC: max98357a: avoid speaker pop when playback

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line. Also, don't
include blank lines among the tags.

--=20
Cheers,
Stephen Rothwell

--Sig_/7cSDTpb8CphHmk0N=2oPlmk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0mDrgACgkQAVBC80lX
0GxFbwgAil/dpYkGrh8n6L2pPsmARP+yOz9E7xaJoeXKFMzlwfIQr3tlPcDADS5w
9l4HxcRdchmVcNHf1VKoHdjH33owwOYDyOVM9G3MW9Z9NwTGKQoJjGqanaHWgXvo
0ytp5VqR9xQpxtQlZJSFlpDI25BFrtwsUcJa4DKMbu8rdqm5wSkidvtSu3johZX0
BV/90WFsmBwXY/8RoAE9DrjwVIE+ycHcsiRQLHDLdLuAPWhNToP6z2o3xqgRhSKD
ClQ3e/xdjuZRU2eD6ATy9mf/ZTt+MNMNKsKVB/+jIXto6V067KmwjeoTJ3sVqjW9
GTSEHC/MhaQFh7liqblRB/oaLoXZdg==
=/nmE
-----END PGP SIGNATURE-----

--Sig_/7cSDTpb8CphHmk0N=2oPlmk--
