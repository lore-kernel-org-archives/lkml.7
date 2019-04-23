Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE94C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DA120674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Mgk9wypS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfDWXJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:09:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfDWXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:09:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pfKH5DXmz9sNC;
        Wed, 24 Apr 2019 09:09:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556060964;
        bh=N/Q7J83n4938J+ogqYdyJcnCuGVywdVIHRpZtpaXXtw=;
        h=Date:From:To:Cc:Subject:From;
        b=Mgk9wypSjOWCSPqnt+fA2xUhaPCbKwpk9nruGpl2YZXHQ+7J1Fs9Ltzi7bdgPdDT9
         oEra3WIcsgnsI3Sq+iT/FOPLReNaR1awDIZswaqFyq8+7ppHnF1NfO4fILZkpDeBrS
         Xm5XV5su4N4GfH3mKkXZt9y7HTF9DKNY+Ggo9vZzB7beEay8UEy+nFvbgUvV4PWLkD
         z1sQF1mp4NbdLedcTjbzU5WFa/62cM9/rK6gNgC3gBO73euzz0h8ILSXSW+8o+HQqR
         x6gGBTieSu3A8c9wFXcg0kPGNUq1vkDBcpjb4/KpIHZKA04lKMzkRYTfZvF8r0ZKzc
         bxiN30VoBCcwQ==
Date:   Wed, 24 Apr 2019 09:09:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabien Parent <fparent@baylibre.com>
Subject: linux-next: manual merge of the mediatek tree with Linus' tree
Message-ID: <20190424090907.4221e701@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I7hSmkFkp/1rA4Ou4IxaiMY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I7hSmkFkp/1rA4Ou4IxaiMY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mediatek tree got a conflict in:

  Documentation/devicetree/bindings/serial/mtk-uart.txt

between commit:

  898a737c8a43 ("dt-bindings: serial: Add compatible for Mediatek MT8183")

from Linus' tree and commit:

  61a640143f68 ("dt-bindings: serial: mtk-uart: add support for MT8516")

from the mediatek tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/serial/mtk-uart.txt
index bcfb13194f16,ca7e9dc83087..000000000000
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@@ -16,7 -17,7 +17,8 @@@ Required properties
    * "mediatek,mt8127-uart" for MT8127 compatible UARTS
    * "mediatek,mt8135-uart" for MT8135 compatible UARTS
    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
 +  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible =
UARTS
+   * "mediatek,mt8516-uart" for MT8516 compatible UARTS
    * "mediatek,mt6577-uart" for MT6577 and all of the above
 =20
  - reg: The base address of the UART register bank.

--Sig_/I7hSmkFkp/1rA4Ou4IxaiMY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/mxMACgkQAVBC80lX
0GxRjgf/Y2cCmcpfixc9SDG1DVUNeDtLOm9wRvXAcXb2RpuDfV1Wj+TcM76fMnrK
1DedmtBb3OQ9STbPahjG5zbAocNiUSNBidhqjK5hbirSXIO6vFO8Q7CbdOsdGBtj
wAGhM99DJ+uwNqMMbPeHVLX3EWEO9LgVYF5YFJkJShsDmsbDPggWoYahWowiDRFg
KIl+ZgZgRmX4l7RGeTAMCuzFE1Ck6c/0lEn2zxsgUrXAT7nfx0rmkzK8cXHTufuN
xRx+D//0THDXEgQUXNGpKCYit8n876OT1BWot6IuqzHIgwrKJbf7OFSGI1++FTXM
beJTNp283i7ZCRalwyj+CngRnANrMg==
=3rE4
-----END PGP SIGNATURE-----

--Sig_/I7hSmkFkp/1rA4Ou4IxaiMY--
