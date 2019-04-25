Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B806C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE022077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mnkRIXNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfDYNoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:44:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfDYNoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:44:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qdhG49xnz9s7T;
        Thu, 25 Apr 2019 23:44:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556199855;
        bh=WVoazcyfpfOaufJuimR0JPrqfOqP6mSSsVI02WTMYfo=;
        h=Date:From:To:Cc:Subject:From;
        b=mnkRIXNM6iyinVv3VCtFmelSvAP1YOg5/JzpTr7xDJxfyrT6s7fTcx2/HUP3Mj/VH
         IjFGAk0qjod22ZIdQMkdVibIl3lljOokHG8AJxSmZzNDa92g9fj0j4+qnmX6ipY9OA
         Ax40UTHCBhwugV6K/roDaYqMvjr9URfrCw+yx9q2eCfOWwx3lOenN57r2aPoAVngq9
         LzmCUX7Cz6j3SPfc8w1cuSP6++nsWwC8zyy7sCX7M7OTVqR6yDuzFTYi/fjAB80Fyj
         vq26NoPBz6kcuj1KM7FpxzGKzaxHH603V5wSiwIAHZDkdLO26rNDFearciC2C6dEP8
         wKblTTBqcJvbg==
Date:   Thu, 25 Apr 2019 23:44:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>
Subject: linux-next: Fixes tag needs some work in the xen-tip tree
Message-ID: <20190425234412.5725f6ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yTS9kI8Gluz2kwcJOhaw92Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yTS9kI8Gluz2kwcJOhaw92Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8a46b39f3aff ("xenbus: drop useless LIST_HEAD in xenbus_write_watch() and=
 xenbus_file_write()")

Fixes tag

  Fixes: 1107ba885e469("xen: add xenfs to allow usermode <-> Xen interactio=
n")

has these problem(s):

  - missing space between the SHA1 and the subject

--=20
Cheers,
Stephen Rothwell

--Sig_/yTS9kI8Gluz2kwcJOhaw92Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzBuawACgkQAVBC80lX
0GysZQf/XHecL4TEvcykV8YYeoQmha6sT5PZ73Ue8Cn5LoL9F3e5+wqrzlr6oZUE
DPZvpR+rmC3TlSTJy99hzerkLJvYuk6YJklTdysL293h4hIK+Zv5luCKaJQiJBvH
YO7le5b/2qVJFy7AVK4XQFd+dHKr4WJgiOVS/kqudFpfFPLrFVA04bZLmhwe0tN+
l6qoYzhDWZtisW3717k8jYiCmiozZruQwK/M9T3BMSvrL8Q1Y1RuhE1lfEkDv75y
1rS1ukKgi9ndiH90Q1UtT99hH5XbEdaEbVafZpvrY6nFOzFxJ5CJSJcQU+p2Yc+g
4MMXpsPVFOGa30f+oQ2yUjslhblaxw==
=evb/
-----END PGP SIGNATURE-----

--Sig_/yTS9kI8Gluz2kwcJOhaw92Q--
