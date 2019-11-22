Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA13C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156520714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TRYqz3wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVDuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:50:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfKVDuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:50:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47K2WZ5L4tz9sPc;
        Fri, 22 Nov 2019 14:50:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574394619;
        bh=2AW5dIptEKr3oKfVoVT5nQiD8l09V84ep4w+jwikWYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=TRYqz3wuZwmtaGtcxdT0c+5/QSoirHs6NpZxi2FvM3meNyI7+KxKtxiltR6HHjskt
         m0oRg0Gj3ahTY3kZCx6r7b9lzXBNp4QN1CucMSxk3hCzQZC5EXHUJITeuSaGWCj7j7
         qKQfgv0k9ygqEkq5KHzkrABZzpBhQ8z9uIel828UqdiSgWNpylATwNQ9syV/qNTGnM
         wSAHc8xJGJkFlzduCjn9kfLSoSPFi+pZoCT0lsYDbSWJPn7l9L0nQo//rhq1CfdMhO
         VeBHZA4zBa0HFx6pzKt8VxLftrLkYhGAsoSf0SCMhOyCDXaHWg1HV28LKma8rzpmdV
         JHmi1yNijc2wA==
Date:   Fri, 22 Nov 2019 14:50:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: linux-next: manual merge of the rpmsg tree with the devicetree tree
Message-ID: <20191122145018.5f8a3187@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8SzoS3lxrnRaCQRI=qQTa5l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8SzoS3lxrnRaCQRI=qQTa5l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rpmsg tree got a conflict in:

  Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt

between commit:

  34376eb1b084 ("dt-bindings: remoteproc: convert stm32-rproc to json-schem=
a")

from the devicetree tree and commit:

  14ea1d04ed0f ("dt-bindings: remoteproc: stm32: add wakeup-source")

from the rpmsg tree.

I fixed it up (I just deleted the file - more updates may be required)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8SzoS3lxrnRaCQRI=qQTa5l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3XWvoACgkQAVBC80lX
0GxYfAf/aJc5dhpYKSGf6lUXgArU9SBbp2CaxntSD93aunBwyflePrqjE4o4n1Oz
d6Ymu7vFEycv4BQbAjihSi9TxZqPf0KKXM18IXed/xzoxctt98PZxvL6M/apertL
uDFq87WbqcJqPe3cPh++Z1EeJ/tadA8Qnv7r0uvTRksbJpe4ub0C1fuEs1Hnhzr5
dmWLuD9vbU1806t02Icsy3W4eX/ElfsbIKNCc7ajqrTvZ4Vd8SRS77VsflCeWnYu
KXxebiKrqpo0yBoP4Q5pJenKEt87OCVfAr1OdfhgI0XQuNatHdG/0TFu4XPFV8cG
qP+/qdymnWSIRMO0Msr2mVNV17Pkzg==
=NLH0
-----END PGP SIGNATURE-----

--Sig_/8SzoS3lxrnRaCQRI=qQTa5l--
