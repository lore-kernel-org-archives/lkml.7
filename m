Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC83ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571069465;
	bh=LhyxX5ncwWMkRp8vxryZGyvmWf4LnTI5tug7GizY/50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ueO+wRZmSrABQMFOIfn2Xi4orgKJyIWzaLBgQFdTWw+gZbhbcizYbo60C/eINan2M
	 dN2hyCWvd5RT+6MxhLSJ/DJ0Y63tsyXh7JxKwqn8c205nsruk5PNkXYHIkmmo8RdW+
	 QAEGralU3VdrtN6kxG5Ztfgn5wKVBYaTFUO7Bv90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbfJNQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:11:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52190 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LhyxX5ncwWMkRp8vxryZGyvmWf4LnTI5tug7GizY/50=; b=gCSqGd0X/lKA22S45zRpWVRww
        Yqlyvdl4tbX4tq+o/FF58x/P67M/w0rSKsXkCXNEaYmeaLVkK8qEBcP1PuAaF7xu/m6tzf50CKHaB
        6kcY1DDhrBy8BKb6psQGhsnoOppsyZQFuoP6I/19mS9I69/n82QxnIpVlUDHmf65I7NXU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iK2vv-0007yQ-Vm; Mon, 14 Oct 2019 16:10:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DDA3B2741EF2; Mon, 14 Oct 2019 17:10:54 +0100 (BST)
Date:   Mon, 14 Oct 2019 17:10:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Guido Roncarolo <guido.roncarolo@nxp.com>,
        Jerome Laclavere <jerome.laclavere@nxp.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: simple-card: Add
 documentation for force-dpcm property
Message-ID: <20191014161054.GD4826@sirena.co.uk>
References: <20191013190014.32138-1-daniel.baluta@nxp.com>
 <20191013190014.32138-3-daniel.baluta@nxp.com>
 <20191014115635.GB4826@sirena.co.uk>
 <CAEnQRZDbXZUhix_aR_DCUzFn1NYz1Zh7MxW5uwnuycps9PNohw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <CAEnQRZDbXZUhix_aR_DCUzFn1NYz1Zh7MxW5uwnuycps9PNohw@mail.gmail.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2019 at 04:17:31PM +0300, Daniel Baluta wrote:
> On Mon, Oct 14, 2019 at 2:57 PM Mark Brown <broonie@kernel.org> wrote:

> > DPCM is an implementation detail of Linux (and one that we want to phase
> > out going forwards too), we shouldn't be putting it in the DT bindings
> > where it becomes an ABI.

> I see your point. This is way I marked the patch series as RFC. I need to find
> another way to reuse simple-card as machine driver for SOF.

Have a look at the way the Renesas systems are using this and the audio
graph card - they have DPCM.

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2kng4ACgkQJNaLcl1U
h9AY3Qf+KqjpJbSFjgUExOknWKmIQsHL8qO28Dh8CbziYGq/2T/5n/myzuBq77rJ
Jsf5asU3PTubpf1TQOytAog3UDtT69cqu4JIgAu2GCv7HrX7aZ7keiAlw5rlH8OC
wh5SxpbIgE959u5iOlD3l5e+koSPk+nnpiZAXfq8faWGDcbsA4OlzNqxq5kEX3j6
wQxJwGKHX73MatU5AF2IEBdZQeyg1eygBqNLvAyLp8//NdN/TijgVQbpxK2ZVeCL
RRtZDUu+j2yIvXE6ugzHd/6RQD0VnCZmAXfA/R5hgKIaNVJeyJ6hXZJ3sW7Go4Iu
1DzGwQiDN5A8JadoizM4L/L9L7MAKA==
=ZL3b
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
