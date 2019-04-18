Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF8C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F1721479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tmK+mPCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfDRF35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:29:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfDRF35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:29:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44l7372H58z9s00;
        Thu, 18 Apr 2019 15:29:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555565395;
        bh=e1Y6GVGXJBd2haO6rBNPAFAGu5rR5obwCooCuYL9VCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tmK+mPCaR5SfgMt8YtTV9cSX92uSOq5VeKc0dl6UhTEXkYtUA3awdwfXM8IAyjGOC
         1W3vRtfvhjflvWTZvxBmsFDUKXLE2sneHKrBH/Zxft+krZmgavtjKVgYVb2ZOqYF08
         MAd9DDs3Hv46ab+OYm2/9wfU0fWJ7SsoTZXV/fLqFkiOr1BmBw2g4RcjGLql0J5JKe
         K19VZ76y+Bt9W5MIvQWRMY2pew/lSKReQUua1t8aU4cblGapJADmdsRRnibUPtIjTK
         woNnvZex89psBSIe+WpDmOU6nuH26XYTeaHtV2L3EvhxYL2WuiwUglXzXR344OYDUd
         KAau01yW9HKNQ==
Date:   Thu, 18 Apr 2019 15:29:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: linux-next: manual merge of the phy-next tree with the qcom tree
Message-ID: <20190418152954.255015e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S2ux4pHhYr8mbIa=z2S4lT."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S2ux4pHhYr8mbIa=z2S4lT.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt

between commit:

  369b89366a3d ("dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy")

from the qcom tree and commit:

  2815588ea64b ("dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-pcie-phy")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index d882e40c3bd9,5fca57b12534..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@@ -69,8 -73,9 +73,10 @@@ Required properties
  			"phy", "common".
  		For "qcom,msm8998-qmp-usb3-phy" must contain
  			"phy", "common".
 -		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
 +		For "qcom,msm8998-qmp-ufs-phy": must contain:
 +			"ufsphy".
+ 		For "qcom,msm8998-qmp-pcie-phy" must contain:
+ 			"phy", "common".
  		For "qcom,sdm845-qmp-usb3-phy" must contain:
  			"phy", "common".
  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:

--Sig_/S2ux4pHhYr8mbIa=z2S4lT.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly4C1IACgkQAVBC80lX
0GzEfQf/bzGGfC1oMJs1GmG7eFhgx7+oPWs1YbJXrjPoW+6oKceUcTntVG+0KclN
7M6r5BSsa5TtiZKzVy1BCyt4jGDPCzyvlRE6BMhE5BRHKU0GnrJNyeAyryueKry+
CP6rzdE+dvkLV/XzfFLiFfShnnCCVgmmIuluRh9ayEmVn7Z5fUNPfAsin7PLpeqp
EzZ/5aGv6HbZkxi8zcF5Zi6BEMGpYYUG/lJwlI0J8gcF4gO8frdSEZ8UY3ZjWtvd
XguluF3UVuXT24VWvPfsHGCMBdPIKfynepr7H00KgYKDMWTFjYaoCKghopDomaAz
ksyA2Z5MafMgGDYbppqlN3AxPF+07g==
=kj61
-----END PGP SIGNATURE-----

--Sig_/S2ux4pHhYr8mbIa=z2S4lT.--
