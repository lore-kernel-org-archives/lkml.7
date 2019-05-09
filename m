Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9875EC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50495214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q2KDh9sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEICoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 22:44:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfEICoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:44:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zyN90Q8Gz9s9y;
        Thu,  9 May 2019 12:44:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557369850;
        bh=Ris6p2U08743Lgu1XwRbSn3bwRJh4+X1N84kkH6Z+Ec=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2KDh9sgXzLYw7e3go4jtJ+CZJM7psLdM5UPeO/FKpqhgufHsTSDzr+K8j5Qw3B+C
         wVkMSK5UcR9kIBRZLJjd3fe+4iLLOog1Cu3MTRxPRnguEY+PcfyDO+/tpYQjHm4pYS
         9HvXBgkmPt2TPLCulkEVSxcgHg1i7jyjeHQViQ/DOwpR9Q2hedBn9b+kq5DD6z7/x5
         AMiTXCXS0Rjh2bUCvEMLuiA6BIPBnz1PlYARHl+4JU4jd+PUfXkKSqSDsFPJz6dA//
         II+WqVQTpkWsGS0GmiSE0sHUl7HQP97yo9Np/Ca17dDoXa4Nkcu7kW7jmsIp5cUd9A
         NDA488VR53unA==
Date:   Thu, 9 May 2019 12:44:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20190509124407.4b31b6aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fszQBE56aDaBwDDCYhv84vH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fszQBE56aDaBwDDCYhv84vH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  MAINTAINERS

between commit:

  10b5d3d10759 ("MAINTAINERS: add maintainer for maxbotix ultrasonic driver=
")

from Linus' tree and commit:

  796fad0101d3 ("MAINTAINERS: Add an entry for MAX77650 PMIC driver")

from the mfd tree.

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
index 77471dd6cb46,1effe9789023..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9521,13 -9414,20 +9527,27 @@@ S:	Maintaine
  F:	Documentation/devicetree/bindings/sound/max9860.txt
  F:	sound/soc/codecs/max9860.*
 =20
 +MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 +M:	Andreas Klinger <ak@it-klinger.de>
 +L:	linux-iio@vger.kernel.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
 +F:	drivers/iio/proximity/mb1232.c
 +
+ MAXIM MAX77650 PMIC MFD DRIVER
+ M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ L:	linux-kernel@vger.kernel.org
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/*/*max77650.txt
+ F:	Documentation/devicetree/bindings/*/max77650*.txt
+ F:	include/linux/mfd/max77650.h
+ F:	drivers/mfd/max77650.c
+ F:	drivers/regulator/max77650-regulator.c
+ F:	drivers/power/supply/max77650-charger.c
+ F:	drivers/input/misc/max77650-onkey.c
+ F:	drivers/leds/leds-max77650.c
+ F:	drivers/gpio/gpio-max77650.c
+=20
  MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
  M:	Javier Martinez Canillas <javier@dowhile0.org>
  L:	linux-kernel@vger.kernel.org

--Sig_/fszQBE56aDaBwDDCYhv84vH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTk/cACgkQAVBC80lX
0GwNUAf5AU2lczOnNLji+pu93/BboZyAZaJq3JImXCd6/G94L5hpIqTTAu+pKM3a
bV0XHGB1iqRN8KNmCdBnT51tE83eIyROjKO3oon2/90uuAQDGzuiH0oyIGAHTXlM
V1XhNE2bWvGspZxna7HMmT8F9fB0HmDr0VtLia+KNCVPTh9TX/5MxPDqzm5wNJu9
nqF85hZq42KsFu/tLtJdDxw+nACAtM9HHOsoRXxrdy3Ys7etw004IN+WfSNuGkcj
YyjhthNQtTudJEELajvyVXf2k2ha1gc2VuBVkQftS/pEEVb6WiEv6x1C3E5mruaJ
enPrrrYyfogxkmkqq512rB/sbBHuMg==
=UJ2L
-----END PGP SIGNATURE-----

--Sig_/fszQBE56aDaBwDDCYhv84vH--
