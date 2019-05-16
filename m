Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD1C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8529D206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558000320;
	bh=TmIV7ffW2M/XkGR/Ok9XbAWdclyndxfsLeCSVkHBAO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDvodPPWouUDeS9PEOgYSVy8+lP/jjBO8wrynu1dtqYa/+p3I3xvj/UlIfwkSu9e8
	 d+RCRv1veCSP635H7aeczq1Ig9iIF9jkah6sZI0FVr82uKtH9PIhkD0ABtQwMlK59K
	 CVA9neqwsDOR9ZOpZji3OoA6XrKVVDswfRHiTUGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfEPJv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:51:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c/NBuWWZd4GyOvb7I7QglGhxqPLW/siTEQ2OiVvxGgc=; b=o/E7kp80rtZdglpp+KyVcjjmd
        5Wz3qP8eDNxCIUlcBvuyWcFYqOds6ruU7a3BH+ijBlOLUQzIunOBYqJS7TdO9vCS8w0gDcJ4Olj0A
        Ptql52sVsabI9E+mpApT1nwl0LJsqAzLSwTKSNNtB9LHEjFLoG5USz2rW39OhloNGVoQs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRD3H-0005zn-Vq; Thu, 16 May 2019 09:51:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C1221126D3F; Thu, 16 May 2019 10:51:48 +0100 (BST)
Date:   Thu, 16 May 2019 10:51:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     axel.lin@ingics.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, albeu@free.fr,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
Message-ID: <20190516095148.GA5598@sirena.org.uk>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 03:56:56PM +0800, YueHaibing wrote:

> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0xa9/0x10e
>  ? __list_del_entry_valid+0x45/0xd0
>  ? __list_del_entry_valid+0x45/0xd0
>  __kasan_report+0x171/0x18d
>  ? __list_del_entry_valid+0x45/0xd0
>  kasan_report+0xe/0x20

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdMrEACgkQJNaLcl1U
h9Doewf+K76sAzp7td0Y2CoC7hSukwmSOre0w2Wt2EXD6tsKKYSDOVdYgV8I/xEY
hNSGzI1Z/lZd4czcoBu4WlQrmLvd1vO/uw8XdAza+8HmuHmDrm71RWKgKkhTzEev
Fz0TwZv2QM4GsFXE42n8ho3HN50etes/tfDNTckilFDzHH/op40t6xC8s15aI3Fx
CXX/sVet6R3DFfe0vIl14uVPvc9jCghKiYl3I0Ot5Al5AsbCARstc5Luoh+Z7BgJ
o1kytR5QrZU16e2MW9DF6rYOCvwcbMA7tTFyjB82syRu3O6H2MN2U5h9dK2iPKiQ
3KFKnJq5BgFlau9haZKJK4/Fc5/4Cw==
=D/EK
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
