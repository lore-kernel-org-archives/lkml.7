Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A020820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554900986;
	bh=0qcpQ2GGG9kn3wYUVYvjk/0EKVBvavKaRKoEcrHoHjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LrJ98qSD720FqZtbCTZGWv6Yxjigqvdw+GtV8MAYvZ6rGb30dlTEIyBUUNSvHANuM
	 RQXwIAl1uSd1GGa6k9Q8hIalTHP43Jr2iTscnKlF6L7xYFvuL5uJkSugNyX4aafpLi
	 nvvAz/ohzKw73HAHw3EyvIGNHSD/y2U4iC6bR3/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfDJM4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:56:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56788 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfDJM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0qcpQ2GGG9kn3wYUVYvjk/0EKVBvavKaRKoEcrHoHjo=; b=wISZ7igI6K78l4KTnUrntsxeX
        6l5mqdpgjfSYmuoymshDjPTzUqCA/MkBU4T6jRAgo9MtdcDBbpmcunM/AhkPqN8N6sk6E1Q8AJh8w
        LRPEmCBMuovEwkQbM+/+J7e89IA/LBP26dX5t329xbs6Dxb4LBSO+a/ONqnmFiNZkBLog=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEClx-0000QK-G5; Wed, 10 Apr 2019 12:56:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 467801128ED3; Wed, 10 Apr 2019 13:56:12 +0100 (BST)
Date:   Wed, 10 Apr 2019 13:56:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Message-ID: <20190410125612.GR6106@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Content-Disposition: inline
In-Reply-To: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PPxI8paQBs33t8dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 02:51:36PM +0200, Flavio Suligoi wrote:
> With dw_dmac, sometimes the request of a DMA channel fails because
> the DMA driver is not ready, so an explicit dependency request
> is necessary.

While this isn't going to hurt anything and might actually help so it's
fine doesn't this also suggest that there's an issue with deferred probe
going on as well?

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt5+sACgkQJNaLcl1U
h9BN8Qf+M8pv+qvn+ML2aGV0KTB3Eifgjqx1GoYtmxwT6D/Qph4QE8YjFoBeIBBQ
gS73KJSjgLkRmqDTe7WHqxcqDAJIkry4MeeSPAAzfxInkaMih10aGTCNRsLZu7YT
1rysutG7WmictAhA2oxCrDOOayQgUM8dTTCpEsBAXyIGcavHVnjLgNJp4DEHSsZC
HaIOgTnzdbFdXYv/nBDp32uhVsYEmCiYJ+PEx6RY5HKpHauu+1S3qsZ5ccWuNKxp
I9jdvvjxTHA/IfR9fBZQZnj5uW8qxN7QHRAdEkV0P55KUrISQlHMdKqTT6nWXg2n
1HdFhz+hDYAVg3xb5DhsHPUIR+1Wog==
=LXu7
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--
