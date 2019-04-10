Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59FCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F372054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554897282;
	bh=7CS7hxBo+3qBo8pjnPUYeymnFGd//psSAPhMZNrArOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iFdRY/V1s2g0MFdpMmiCkb0tuUcWtCD1MIp6UpxGrw8Zii22FlflP/eiQrQyRKuck
	 hYRGffEnJyqdNtiDRr1U3u+5z0jC50Fu9957SQQjxnXRVPksK53gv7ZLinfnFTmplb
	 YovCdZnfsJfvVwVoq5DxlpN8kyVS1wc9GueM8SUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfDJLyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:54:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37768 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfDJLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mKgJPzcG9B1p6WaSu4PfmZ6QERurEdmFkN9aB2wm1JY=; b=F72eV0/oUP9Wq8tMbJJa98rQA
        pXmQq4XeQy7SQfH3kFSElAYET1ZG2J5gR2W6eyShP/xfSF2kgbhufKKho6mlAJCx531ZyXLpSJkGu
        C+5gWz5ucZ5RAATSep7zE+tyXTBw3+MMs4Gcca2I+9ZkLSROxq9FkDXzCihUKhYU6uDp8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEBoG-0008I2-F9; Wed, 10 Apr 2019 11:54:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 861871128ED3; Wed, 10 Apr 2019 12:54:31 +0100 (BST)
Date:   Wed, 10 Apr 2019 12:54:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Message-ID: <20190410115431.GO6106@sirena.org.uk>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <20190410103250.GF6106@sirena.org.uk>
 <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <a7237e949bb643d5b49ccc5ae241bbb9@asem.it>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 11:47:43AM +0000, Flavio Suligoi wrote:

> You have right about to avoid too many boot messages,
> but in this case, using an x86 machine and with
> the spi-pxa2xx in DMA mode, so without the message:=20

> "no DMA channels available, using PIO",

> there is absolutely no indication about the existence
> of the SPI master controller.

It's totally fine to not have a boot print for the device, the best way
to find devices if you need them is to look in sysfs anyway.

> The second reason is about the DMA/PIO mode indication.=20
> With the board I'm using, sometimes the spi-pxa2xx driver can't allocate
> a DMA channel and works in PIO mode.

> So, with the advice of Jarkko, I think that a valid solution could be:

> 1) remove the "no DMA channels available, using PIO" message
> 2) add a new message with the indications of:
> 	- controller mode (slave or master)
> 	- transfer mode (DMA or PIO)

> What do you think about this?

If the system is randomly failing to assign a DMA channel when it should
then shouldn't we just fix that?  A print which is presumably intended
to prompt the user to reboot to try to get things working doesn't seem
like a good solution.

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt2XYACgkQJNaLcl1U
h9D4swf9FQN1Ra4YLunh8c9Ja8dvSdcqUjDUKfRd3Ja7N+6V7epHSWIHnYAOirf6
UCPHczZoUJc8o5kNvW2191qGCCT6lmD4imvWsWVaO/LbpwJAgW7XEezV7nFQVSKV
IEshtWiWDpUS1AMxBQAdmMFv4iKaeNddlJqn2bIhb0K2AXOsw8xy1DOyma/zP6XT
T4hP/VO3Y5Jwn2hmGTz8hJaixRawaJ4R1ny2WC6xP+Mq20E7adpSe/R/ubRNP7A9
TKajLyvFz1E8QTAud0BtBQusL+0E9rVqbE/l3YV2S0s6Ilo+hWxglmU4jjmdUVxh
w+HyRCfALV2XF9KG06PyfzEONSoleg==
=32Ct
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
