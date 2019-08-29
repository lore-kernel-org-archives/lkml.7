Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42318C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C2C206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PVWEtMoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfH2FbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:31:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2FbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:31:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46JrnK2FNpz9s5b;
        Thu, 29 Aug 2019 15:31:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567056677;
        bh=oIlRLyhh4VOnhrYht75HP9ne8cBfRj+H1ZHmre3phC4=;
        h=Date:From:To:Cc:Subject:From;
        b=PVWEtMoiYpRQCBEYImU73R8EgLboolgWeDq10zLt+uLqBCl63LFjZb5HgX8276IaW
         ufGGeDzmidjP8LjQdffrA3OVYMVroFBBY9oTDsgHdcb2A7U9xvGeLg+gPXJz1duFvr
         jkDzGID3Fh412Z6UO+CGihdSUnVeQ1gUMOLyo/pkewkkT1FAh1+8bBdA9Q2Xo2J7Y2
         m0U2phENrvcGwO3XVo+CmKchAGTSwi6BnfwJi5ph6cwyyXO3tp7E1brJLVjqYJnieZ
         dARkqkNdAzKF4bmcuXDUBj4FonlWHv4eGTwRrKUnON0/4tGkRLCpi5gWsQDtm/MEsc
         1XNB9j2al+LwA==
Date:   Thu, 29 Aug 2019 15:31:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: linux-next: build failure after merge of the keys tree
Message-ID: <20190829153116.7ffc7470@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V5YeR+sV2NR8/x92S3Bf/y3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V5YeR+sV2NR8/x92S3Bf/y3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the keys tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:


Caused by commit

  ef9cc255c953 ("usb: Add USB subsystem notifications")

# CONFIG_USB_NOTIFICATIONS is not set

I have used the keys tree from next-20190828 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/V5YeR+sV2NR8/x92S3Bf/y3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1nYyQACgkQAVBC80lX
0Gz4ZQf/XyUpDRlhsTMmyxhyfdA3UdK1jSikR9e/Plx+ODcR/oU/ZsEXXDc6X6qN
SlOH7cRLs35YsIwgs+2BXrLxkcEtpJQQmFEr9SjiaW0aBNy8yNabtszzrtLZ1z7L
L12nXZnRnl2tKt2FbbGIV6lUpE+j/TW4eWrdEw+vSiXblv/UNIBHAvOSVKFHElXT
Dn1kYoRNWFc7jMokcZozCgI+6VqgBd94ez9s/4MB+kSE3EXFfCrnXjeTOTD3Bmr5
OEBFPAy/oE0P9S8XTN1ksrl9ORGc0gJhBS6fuy9fsjSw5etE3Ms7n6pYfHsy+KIT
zFcqdhLsuoorlziSEEIC+8WPyQ0d4Q==
=kkoD
-----END PGP SIGNATURE-----

--Sig_/V5YeR+sV2NR8/x92S3Bf/y3--
