Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88304C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD6820678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gnoajj4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDYMyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:54:31 -0400
Received: from ozlabs.org ([203.11.71.1]:37393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDYMya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:54:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qcZr1h77z9s9G;
        Thu, 25 Apr 2019 22:54:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556196868;
        bh=zYVd9YlqNGsgj6EtdrPeh8kmXnYggzlboJgRMmrOPNs=;
        h=Date:From:To:Cc:Subject:From;
        b=gnoajj4WgtlSzEAectszM4w/VsyvXHXc0ZHBhB1jRz3ArekdYmYubW7copgJ0RLgw
         eZPOXUj+YRqHQebcFehc6SzBR1nIb4EicWUlhrd8Qp+DWHZF36t4Y8yIH10ZBr1BQf
         WGvzhDe2HaDV59ecVCYeva2dNCjKok1JydXIVlX9lGpWdnfJQxqqvJyTUHQf7rcH6J
         93zlkNgu0Qsfq6AxQcruJPMtYgtuz21Y2qR98sa5X0+LKKtwJP8pXJuK0nDasIS9bs
         aOuVbeFkaz1QxVHKyNj5KcDZF1VSmPF3dyw6Sp1SLrVXYOBli/nqXt7ZgECFR9Ha86
         zCLVNywQNsSSA==
Date:   Thu, 25 Apr 2019 22:54:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20190425225426.24bcdeb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/omtWhIbuQlUWr_pBJz8oLQ3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/omtWhIbuQlUWr_pBJz8oLQ3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4c26c9eaa465 ("Revert "ARM: dts: qcom-apq8064: Set 'xo_board' as ref cloc=
k of the DSI PHY"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/omtWhIbuQlUWr_pBJz8oLQ3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzBrgIACgkQAVBC80lX
0GzenggAojQ67NPFc35iZ7zJ2L/kb8E4PDGPirBKiVP+6rWN8+M5RRIHc7e6ykv8
s7rNmdqe4f7DPdv7RUVGsyqtnZ1NGy9EcFBleNqplZOaSV+p01K+Ifjra8/Hq/lf
20EA28Q6GUyvs464Hj++w1Ulj6xXqDPmStQ92fl/ggipZsCdqXYQ3jf+oryynOgp
kzipsWWL8bZfj+PPLwUdLvJmo1vbVcWk57j0tIphN+rJxeqXePzhcaJenNkZoMzK
367f7T9Vu/36dyd58B8ziX6qNeCgUxfrTFNzqEdrqALrHhyMMiDGUbBULlL7yprA
YKd4Cs1MlV6Byh1dxRhAJqvsoObUQg==
=xeP+
-----END PGP SIGNATURE-----

--Sig_/omtWhIbuQlUWr_pBJz8oLQ3--
