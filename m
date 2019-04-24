Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44043C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189D2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HNx8m+hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDXAW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:22:26 -0400
Received: from ozlabs.org ([203.11.71.1]:59889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfDXAWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:22:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pgxV1N2yz9sMQ;
        Wed, 24 Apr 2019 10:22:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556065343;
        bh=FYUxV9LLa82IDHDXai28iy34GpB20HFOrlNcpWqR7Gs=;
        h=Date:From:To:Cc:Subject:From;
        b=HNx8m+hRFHDhjizE4LX7CvLXghzP4Z/Wa8HeZ8Uo/dQioanuhD9xQb7S5p+wFfWq5
         YGAZHKq57paP+isbd/swTX90Nb9itola3gxz+9499xe3aP0bSudtP+oU1bQRV3k1Gn
         okEHlQxziRcOFqFTg5LtFWOqAmdPvUQZ1jw4qSI5XEXHa2MclvnF8gs9lKdVrLDAkF
         E8pg5NkC9uWJyuBjVmv8CUQ9DjLMXR+bp/Hkoy5iglOIVPL827CUSSxbYr3RKIdLdI
         sC89hnsaQpOnFpnvlVPVTdTOCpDDkDreO9Va4AOS9WTztc7yb2zFStxww/gOPQhzhg
         UCuPRsQE551bA==
Date:   Wed, 24 Apr 2019 10:22:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepak Rawat <drawat@vmware.com>
Subject: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20190424102219.48cfdfe2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g3GEeX/qXqHGhYmsJqu=kcG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g3GEeX/qXqHGhYmsJqu=kcG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a9f58c456e9d ("drm/vmwgfx: Be more restrictive when dirtying resources")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/g3GEeX/qXqHGhYmsJqu=kcG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/rDsACgkQAVBC80lX
0GzuPwf/WGX6T5ueRjKbZwlz5mla7w6r7UgwAaZKnzJQvnLU4mud4CCMg3cL2txY
e3uPutpytd6xUGe9Id+dyJ9H4MwgNqLuttpdXenK/dfhIi4ng4PfJKQstXD9Vvtu
EL0ZeKTA+M+oddlg3X2Fme3ul9aAYAU7KI1LST332HK8fqYfvC2dNRNa3CxjQclI
hwnRFVxeawpOQj2beGCDZTdKTSTTqMOkrWEUUkAkORlorf8ONcDcPjNhh8W63kmn
hWei6mVQXUinemmtInq7k1hY2s6Ve0Vhq5Qekm55vuUQXMKyrv71fB/cOx73ipkY
pBkZatOAkFuQ9U5qCCARznPONU/btA==
=swKr
-----END PGP SIGNATURE-----

--Sig_/g3GEeX/qXqHGhYmsJqu=kcG--
