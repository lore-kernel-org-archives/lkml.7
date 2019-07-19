Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D420C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABAC20665
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SoJAOSLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfGSIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:41:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:41:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45qkxS29Drz9s3l;
        Fri, 19 Jul 2019 18:41:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563525678;
        bh=AfUDJOPkyWvFlrjo9LOtQTi3KuQ2jyPwaXYtid1vbUA=;
        h=Date:From:To:Cc:Subject:From;
        b=SoJAOSLvodpm3XsS0DYUx4yRIOBTR/CfEYkJCpmFjpVrHwpoPpzz0d5Jlw9J5+kg5
         ZfrULMMvxaOXD1qs1g/Si+NVk+TRuWa/RpnnZ5XT9oXp2mcBNXhLvUcORDooJKwYHb
         EA7hGHWEWGLL++vy+pFJnDiknZHU9JAvQTvVFZoj4yMsWaWioZPUgvpqgxIuzaGSf+
         pE3nt0V2YpzvmlNOmNyKV8cU69LlZ6w+2/GQmnTO5zmyQF4ZFXNeGJVKD9f/JFFzli
         hi/ZxUy/5M15dobvhqZFKBa7LoT7fV9picb3x50dm5nXwypFbv2nXaOHOvYX2SIGsi
         EQIV7A1I8k8sA==
Date:   Fri, 19 Jul 2019 18:41:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20190719184112.6bae9eb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G9MxQIo.QHoane_qfAxQ+/p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G9MxQIo.QHoane_qfAxQ+/p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b7019ac550eb ("drm/nouveau: fix bogus GPL-2 license header")

Fixes tag

  Fixes: b24413180f5 (License cleanup: add SPDX GPL-2.0 license identifier =
to files with no license)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/G9MxQIo.QHoane_qfAxQ+/p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0xgigACgkQAVBC80lX
0GzKoAgAh+uW21gJ4l2i2YQ2jCrg6wg09OmYZVZ94eOrBiO4mTaArQaQlWxijWKQ
9UIGzkGuWuoAy9PbfmYC/TJ4xkQO8gvzaS5paJjnXnsWzUrtJDRsyby7pHSq0536
PzQXXcgCo4ZNQXyJZBlxgNm2YhtO/4u8SVQ9042JvBAaD7zXItdpqwZF+oC2+0nY
7IPzOOs3QkpEPZ8XEgQJx2eg4DlbVDU+BhSezlttp25yAZsEIUo5Rtpe+ZyIzxAd
8xh/3IGgZaoLsCjWT+AaazKmEK9FwWbBjV1IGIg1xUosj8WqrCnOeen8qeO48T35
HAJu5h6cV9xHli2JsKcj78X1z9qEuQ==
=TSzi
-----END PGP SIGNATURE-----

--Sig_/G9MxQIo.QHoane_qfAxQ+/p--
