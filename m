Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6448C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FAD21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oXxo2CNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfDWXZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:25:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWXZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:25:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pfgw2rlNz9s55;
        Wed, 24 Apr 2019 09:25:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556061932;
        bh=/Me6Qh0fsYmS3NA+hGpSqFd/3x8whwiMfkiRQbeC7kU=;
        h=Date:From:To:Cc:Subject:From;
        b=oXxo2CNETAk1pMPhWoFQGRO1HwR1uvmE+y7czc73PnBl2+b1m7pC+gMUGCCuXm4cu
         5ny88Ty7Akti/5g8YjGkLNDbBe6VNdMnhYCGxS6c7Xims/p9PydPOM7w3NRSGnQwCe
         w2Y3Xv4ymi8+tGQedUhyaJQLVX+ZHCiTE05ourq6z05wSX6j3Qw0MG2CljW7zxOJE7
         qxunNNeKv2C4fCYV2h1RSblXR2oo2YW+eLY9wiCg0frW6fmgvfqCxA9IonY8ORzNS8
         cDQcVGRyNAJYKzCV5DIdznnb7jP1xMeTQKK0umsIiwr48CpMNOSprslumBWIfgp6cA
         Eb3LnyQypacQg==
Date:   Wed, 24 Apr 2019 09:25:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: linux-next: build failure after merge of the qcom tree
Message-ID: <20190424092531.3988850d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MdrnBC5ykLaNcA9m6R7BzHc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MdrnBC5ykLaNcA9m6R7BzHc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/qcom-apq8064.dtsi:1297.29-1309.5: ERROR (phandle_referenc=
es): /soc/dsi-phy@4700200: Reference to non-existent node or label "xo_boar=
d"

Caused by commit

  3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the=
 DSI PHY")

I have used the version of the qcom tree from next-20190423 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MdrnBC5ykLaNcA9m6R7BzHc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/nusACgkQAVBC80lX
0GyOhggAjtHMOWN14OpkY33HFFHGlnXt2JzrszGAisrqemEBqnhfJ0AhY9Ez0Elc
De8ThAyuJORxb1mcRatYHDspGKFs9jc2/jot9F1E4rqnyqlAR+hAJNiRPqQMkJuL
3KkKfEy74BNMImuF6YGet3be1nZGMekezpxAu33U/kBGsGqmaMLcTo+/zxfuPfVn
YN2PjeAuyWB02Ur2JQ3P/hz7eTGaBh6/xMLQtBlLo5soZeQt40uezQh/zKq66qRa
U78VjHAubuATRvZzuPQ3IyCjXKNatzNNx8+xGDwIWCEjymX7TVlsr1K+fLDqob4a
oPiKsGXVhnhtcgPBbGgK9OW+ptQ0qQ==
=qdUn
-----END PGP SIGNATURE-----

--Sig_/MdrnBC5ykLaNcA9m6R7BzHc--
