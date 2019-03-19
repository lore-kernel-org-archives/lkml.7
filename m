Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A6E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NQ26o3jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCSBP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:15:56 -0400
Received: from ozlabs.org ([203.11.71.1]:36327 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfCSBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:15:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NZqr6njkz9s71;
        Tue, 19 Mar 2019 12:15:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552958153;
        bh=0PRGN0yENS398sV2O1LXUiB7eHinZ7TJ6yO6KqhZ+qQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NQ26o3jop3LHzrjFgI8sF7KoHdhpPLZt0J2nNduxsdGiKZG/Sz2Y7YDXIYM+ajVUK
         EjejN6ZG0QaZ20ibsDpAqkI2oS6m4rt5z3334yGQ4TWNYOP8y8xtCWDyZ01Yz4/BJh
         zy2NP4FFymdJpwAxNlIXMytMGB/Hlrt0OtrUackGVMauRwRlfRJEYDYaFQUcbaFOOI
         zRqTPQBcWNncwijksfZaovcdbFReHdNf186/os8wfW6YFcqU+vDTeSo0kXVXcKOUHb
         jUC0gNcKjCsE7GqcbEbfGzMc/8SkNri74fkEa9W6431CBasgdLhotma7hU3TiOS/Hh
         WH3nVplaGicWQ==
Date:   Tue, 19 Mar 2019 12:15:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: linux-next: build warning after merge of the mmc tree
Message-ID: <20190319121551.14cbea26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RmII10Z40D161utywWTc15="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RmII10Z40D161utywWTc15=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mmc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/mmc/host/dw_mmc.c: In function 'dw_mci_wait_hw_unbusy':
drivers/mmc/host/dw_mmc.c:239:16: warning: unused variable 'irqflags' [-Wun=
used-variable]
  unsigned long irqflags;
                ^~~~~~~~

Introduced by commit

  705a0f288113 ("mmc: dw_mmc: Add hardware unbusy interrupt support")

--=20
Cheers,
Stephen Rothwell

--Sig_/RmII10Z40D161utywWTc15=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQQscACgkQAVBC80lX
0GzqDwf/T9CQ7of/d/SVo8uI5ZyIY0C1wvKQpXSVq0dPX9zFDdNX2WEfLlKMME0p
DBfihbPlBCXMumrlaEAVcYU2cDQwVqzrcJaydXWfk8F4G8foP1Jl31Ocau4TIsnz
wWP7nje6CI/u94lpCQ0nL7sbITj+DFD9SAwoyXPe5/T3RgrrbOhHE8bJZICbA5KV
zcGaAW0EmQq/FDoNTgkfDP9ceVX6MSsDyZuc//3QwthEBislgwjnlN6az6LYTrH1
5uyT9Mapn9fFkIYiyylqBU/cNcBg1adwMKm16+C0WOeDknyG90a3fZ1crpZUmffm
KgGn80+tVC/3D05dIkzymwYh+7sIuQ==
=wbSG
-----END PGP SIGNATURE-----

--Sig_/RmII10Z40D161utywWTc15=--
