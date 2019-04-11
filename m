Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F269C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D97D2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="naQoW4S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDKVUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:20:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDKVUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:20:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gDTb3s6Nz9s47;
        Fri, 12 Apr 2019 07:20:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555017651;
        bh=be9AsbfawJj2H/6pXLvHMoriL7mP9/AFeO9OlWPym2M=;
        h=Date:From:To:Cc:Subject:From;
        b=naQoW4S2h8JntHhb1I49uOteqYxvuXHyG+ENYaL3qX4RbbZnfFCpgjfuqj48/wdAN
         b5X7LnALYzO0iY2Mhco+mHOfqbhTrrBJ4hHZnFYL+XXJqXQDrodVtTA7P+Jt6jVBE0
         O8Qm4s4wiBmwTO1W2c2d5CPchMl5KPtukAItwP9Zxw9tya1Ske2cY9Y/chGBYy/NFO
         GxeaIRoE2BITfN+3xuEew3r0vSm97f3qpohPK2dYxi10fNwuRSfpC9LLTCXSVQBK5l
         eSy9SzAzjgx8aH5T0qOz7xsUMZsA2aowQ2AvJaE/3/itq4+3yuRACi9eFlDxAIrWU0
         KP9rItkGVob+w==
Date:   Fri, 12 Apr 2019 07:20:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: linux-next: Fixes tag needs some work in the mmc-fixes tree
Message-ID: <20190412072049.08b5eeb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rkIH=yXnYYacT/rKsFybRYs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rkIH=yXnYYacT/rKsFybRYs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5c41ea6d5200 ("mmc: sdhci-omap: Don't finish_mrq() on a command error dur=
ing tuning")

Fixes tag

  Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/rkIH=yXnYYacT/rKsFybRYs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyvr7EACgkQAVBC80lX
0GyELgf/UHblpwwqE1ZuCeiPBFhG8c1q868YBFpJzBv766hUCaa97L5mWu0Jc/7q
Gv19k8lNyNEBGNC+C9YyjyapARB9MuMGVHq3/FHUsLqa0gJ+7NR7tGo+SgDB97sO
z+b90XAukclD8q+AQlIEuVQ3F5a9M4sUq2yC8NNlCyoyt1AWEl/IIV+J80yA2+zu
wogKm2ur6xI/T1iUBgEDwzaZCEgWwh3dXsChZGE2X8XIUTqSD6hRjXcJF+jMqypl
9TbWJ97t9r7s40WpqvtKZGBVPnXfmhVxDvUBPKYd7J9tvQ5lxGJUFQaWUI1sPpR2
2RCI5Xm3QPXk+wi6dLWBCVUcozRGRQ==
=71oc
-----END PGP SIGNATURE-----

--Sig_/rkIH=yXnYYacT/rKsFybRYs--
