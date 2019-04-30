Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E345C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86CF20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ubxln9Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfD3WK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:10:59 -0400
Received: from ozlabs.org ([203.11.71.1]:54593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:10:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44twhc40XGz9s9y;
        Wed,  1 May 2019 08:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556662256;
        bh=JVSi/0QAeAy1mh+/x23zjs8K7C915sL09yAKKHVvmUo=;
        h=Date:From:To:Cc:Subject:From;
        b=ubxln9Z3X5z8qsy8SfwhfEBLlQyGh5qtlj33oqlBRnUZCP1SgMwI8ssWxVzweM8vU
         KTcaas0Ip2bxI75sCHAqu/ArY0dyC0eFaFvUMcrJoklKkOmVrLdEpFDNNGk3eNT+bc
         ojLgGyXtH8ivM+p/2LXL87Sw4EsNmmvcyPeDMBFEbScNiOgbLUpaDw9pKWE2ySigk0
         OE5lNcsa43H6cWTvob2qgNlNkoKioqkiIUyOZIWY4vKUtWbLNt7dMaHT/aYyl0RhMt
         GPVcUN9sr0zqASh3JMysVII6IqcquXWvrmsU0OQzVpT6lRPFnE01yRcQl5Mgok5VPf
         GOuPXV7dSABwA==
Date:   Wed, 1 May 2019 08:10:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <20190501081054.387820b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q=rOSKQXD5Xm/TG7tZop55S"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q=rOSKQXD5Xm/TG7tZop55S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7e470ea99bcd ("kernel/module: Reschedule while waiting for modules to fin=
ish loading")

Fixes tag

  Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for =
modules that have finished loading")

has these problem(s):

  - the "linux-next commit" is unexpected (and not really meaningful
    once this is merged into Linus' tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/Q=rOSKQXD5Xm/TG7tZop55S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzIx+4ACgkQAVBC80lX
0GwXIwgAoZ1nAGUCkVKR7DlCwgC3a0AI0gysq9HFiSmMTfjuMP/IsZrmh16vQ98j
U8klRm/O2eF8evd98zkV3cuwt84Ug2B5nJ195hgTsKOShtgprx/0kqdTHmAD8/Yj
fwg37JlUUFKTRQ0XUuUrjs0a4zwKCEIVhxWoa4YR3qOVP/vK8oM3iUI3E2SALSRZ
Y06LDZB/7PWq4ZE9su7TqRelsXD9C+8pTXVTaDywmK6MniHDCOlrp/Csb/KQ2yrJ
WNgzqv3gJlz62MwFqK1zdc9MLcG/tSPDlgFfkqSryrqO5FPEeXn8o9AzL7p2kFGA
8dMHoi2YAu+rQ+xZansvdVbh5PmgVQ==
=9xru
-----END PGP SIGNATURE-----

--Sig_/Q=rOSKQXD5Xm/TG7tZop55S--
