Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E36C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C973E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U4rtQaWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfKHCUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:20:45 -0500
Received: from ozlabs.org ([203.11.71.1]:40749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKHCUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:20:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 478PBS3PfSz9sPV;
        Fri,  8 Nov 2019 13:20:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573179640;
        bh=S6Hvp/X50jZ7EFZZYb6XjoD8DIp7pBL6EOxbI/Y+OmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4rtQaWysYr5ul3hUzj3tXyGWA+dGyTSnc3y2qfDAh4w887T0Hzfb8DdEqQP21j78
         bLKePda8G55isteH/DTvpPd03ZK9+vFIP2iUGpxiv+3xIK9OuZtjmN/RAIpP15dfdj
         0Ld5faxNX3hXehfbb36CbglNc4LqiXGpHLudhhFf9471GTQ/nh4M9Ia5iSSIjnNJxu
         63CUKpyBsz0dhmHgaL3lh9b0hx4Rx9HV9YWgOC91UBjeJRdrNX18Qn75Ld9VMLlUVV
         mTc9cTLqYFj2lbrszxLu+sBzbYPOLWb8hL6IZrY3G9dxk9CJ02Ie/8JWe6/omQo4Sy
         vyjmwU0AmsEPQ==
Date:   Fri, 8 Nov 2019 13:20:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-mtd@lists.infradead.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: generic-iomap tree for linux-next
Message-ID: <20191108132000.3e7bd5b8@canb.auug.org.au>
In-Reply-To: <20191107204743.GA22863@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
        <20191107204743.GA22863@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cPVZY9JpGW.gARWJr=rYvJb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cPVZY9JpGW.gARWJr=rYvJb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, 7 Nov 2019 21:47:43 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> can you add the generic-ioremap tree:
>=20
>    git://git.infradead.org/users/hch/ioremap.git
>=20
> to linux-next?=20

I assume you mean the for-next branch?
--=20
Cheers,
Stephen Rothwell

--Sig_/cPVZY9JpGW.gARWJr=rYvJb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3E0NAACgkQAVBC80lX
0GwJFAgAgWvXVOBZdx5Do4eCmZ0ZSFyBsTuUtYHPbtNtwQy/iB3LV9BkCAPS767N
fkEYwRYkqSzUXOA/WIHUXJad89wLVEs1LjxmjeEqJQ2TvsUFGO8vjnTPyXDrfB3W
VTmeqX0QVqJIwGn29lL9S3UqJ1r1FZVLCcSFLOZQzyRCWmgT+sF9Hofg/5Lwv6xV
2c+V3LdCr0cTLB+ZHFOz0toYCQMeXlRJM82WAUPhV+jYc53MqEM2VxmJ2G51xIJm
YEIGyjw5cgDkdJhgj0f+iXPoG7BZ7OM6KPpEVZHEv6pdVP2bcuz37swC+XmbpMAX
PVoofTbgfmgGmqZ8GiRY+i/KHc43fg==
=dI/j
-----END PGP SIGNATURE-----

--Sig_/cPVZY9JpGW.gARWJr=rYvJb--
