Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDDAC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B323020855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F9juOnaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKTUXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:23:00 -0500
Received: from ozlabs.org ([203.11.71.1]:48891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfKTUXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:23:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47JDdr5C4fz9sPL;
        Thu, 21 Nov 2019 07:22:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574281377;
        bh=pnv2YLiKiI94p3fuN9ODivZcg5XDECfbd07TsDL/Vw8=;
        h=Date:From:To:Cc:Subject:From;
        b=F9juOnaKBEAevXEMoHdmk5Wea95DRkpDCjRjAcA14WrBUN61V0oHn1mbLy0QyxJoD
         lIhBtLOnej3TygfTABnQuQqTIG2JtO/3rAGxEWGM4OyVKgUZ80Aua6cpLibRmcCyNv
         2YzU+wz934FbZGPNGmUK6H+fLkkBYsd7fGsbDFmwxVd5F3voOGOOyk0KzzF9fCfNrE
         sHmr6UboHIB02FV/qpjAfiouacItoVk9wtU53JSUxcBjPzlzsU/7pF5k8m3D0g9/VL
         MqH+mXWmYK/b8fcz/uB/7D39x62XPIvQFxRPzihS0836laigwRhUe4j78b35qsRLHG
         3RtGyxVmpBc6Q==
Date:   Thu, 21 Nov 2019 07:22:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: linux-next: Fixes tag needs some work in the omap tree
Message-ID: <20191121072254.79e13f56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9wo/LBqFlePA2XNZRgQZFV3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9wo/LBqFlePA2XNZRgQZFV3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e130d53f2599 ("ARM: dts: dra7: fix cpsw mdio fck clock")

Fixes tag

  Fixes: commit 1faa415c9c6e ("ARM: dts: Add fck for cpsw mdio for omap var=
iants")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/9wo/LBqFlePA2XNZRgQZFV3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3VoJ4ACgkQAVBC80lX
0GxWdQf/U6wuhsNsmqp+9tTCyLLNQ4JABmjC9OEC3fzrFYK6sV318F6c3N58WNM5
q6/MDWekD4ym/Sw/0V1QYuD8SW0lywImBGpSbxaya2Yb4fWpteK4hJBvBf8cLWlN
r8Wtclrv1mjngkaTE2skEaXdb+708G0hZDtJ+2HUeMLy+xFBn6+ePetGmnl1+/U7
ZA3PomRnfQt/guI85O84/w4+HuGczBVmDcEM3By5yqjcBzybK1aJDP+8EDgtNm7i
YbyJSjpnIlMZYrHPVcs+qMrtd+C8kwKW1ZU/kowtLS4G+rAiDmz2vlCMm0rKNn/c
wjre88RD6FscCrEyOCXGI2utVnH2hw==
=Eekv
-----END PGP SIGNATURE-----

--Sig_/9wo/LBqFlePA2XNZRgQZFV3--
