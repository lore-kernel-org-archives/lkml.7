Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7887C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F220870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tI+7pvLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfCaWzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:55:10 -0400
Received: from ozlabs.org ([203.11.71.1]:55141 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbfCaWzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:55:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44XW5R3QKmz9sSc;
        Mon,  1 Apr 2019 09:55:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554072907;
        bh=yEgiEqzZZP9E96pZsPjlLDgz/a1/uXHHlQR/XsqDXVA=;
        h=Date:From:To:Cc:Subject:From;
        b=tI+7pvLGdSHLJ3mcx6VRkBWFkOD6VvpfB4DbA8EYzK34XEeqyatTlXDmHqZXG9LkH
         cCv8MR9dev5aBhlso/S6PlGrgPUuWFN8vR4893x4pLqEU4Se4QJtVcyiXlUpKU4PGX
         +M51QrdXVSEMEL8lS8aKaR9hVE5fa30/Gn7ohaf3jj76QqsUZcC6zrzIl8S3U274Mz
         fJoI4EvMkZkyTu0s8ldYoeMeNzzAtRAoqczC1QlQWc4edPGfez1WEn8kCKA183o6mA
         behwMzlnPe5QS7TRQN1HOaTg/ZBBQrVKiTvbDz5idHiAqFFsJeonGWKFX/fErFBwx0
         nHVchsbbcoMkw==
Date:   Mon, 1 Apr 2019 09:55:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: linux-next: manual merge of the sound-asoc tree with the
 hwmon-staging tree
Message-ID: <20190401095506.39bf18eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D1nDx4sTVRp2m=0iVF2hqso"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1nDx4sTVRp2m=0iVF2hqso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  MAINTAINERS

between commit:

  d1ce5addbaa0 ("hwmon: lochnagar: Add Lochnagar 2 hardware monitoring driv=
er")

from the hwmon-staging tree and commit:

  16123412a628 ("ASoC: lochnagar: Add driver to support Lochnagar 2 sound c=
ard")

from the sound-asoc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index e254d42e0f2c,84b9d7557ca3..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3815,10 -3805,9 +3816,11 @@@ F:	include/dt-bindings/pinctrl/lochnaga
  F:	include/linux/mfd/lochnagar*
  F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
  F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 +F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
  F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
  F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
+ F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
 +F:	Documentation/hwmon/lochnagar
 =20
  CISCO FCOE HBA DRIVER
  M:	Satish Kharat <satishkh@cisco.com>

--Sig_/D1nDx4sTVRp2m=0iVF2hqso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyhRUoACgkQAVBC80lX
0Gz8rQf8CpV/+ep/MsLMLf+QOc78n/7VqaLtqGqYRbK1ZOx4WwsNivRo3fI/ueh6
islVMBZkrskN5KWKPd2sYpoR6D6qOBGig5v0WoI7wHslPQPlHNM5DIQsF8MASrpd
UiSczbVPKsaE+W11lFo/jtv2Ok8qzbJe9A/lJwRqEftl44rJHTEeMA79B/UTnjIS
zzjgkDV7F7bLm+MclY2ABpIKsfetGli8lbfVu7ahe4/oY6jBXCG1qnwUa0iebJYn
y7UQ8I42j4kQ3cldIrRAqhC3BLPxmrL0WPMzOpVcpuqWZnZ+Z9dR6TBSbYkYGgev
uuB+CU6HkdM7m8TCzufF/DPxuwKpyw==
=kEsC
-----END PGP SIGNATURE-----

--Sig_/D1nDx4sTVRp2m=0iVF2hqso--
