Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72887C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA6E2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567767510;
	bh=QIZ/lvR68SHwOxPp4CN5/Sclk2gZXPxKjkqj2HP0b0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cOhIJ30uSGsohGqzLk75/7RD8XiXETKeUqSM75w0zGTBoFMlM5V8fD+EiiZGQkz8Z
	 eG6fgJfDgZLp8tMpujf8BveX2MpqEU0pByYwm+YEDRZZGn9Nlh3EFGqAZEdfgCJifb
	 HFUSDzWxIJdGPhcISdaXDqoMQhx+Rp1Uhk5UeA24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392126AbfIFK63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:58:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfIFK63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mcX83Y9Kq0yA6QRv6Fibk6PXx3R1UGTbAn3Ar0AmJvE=; b=qkBjUJn1L/rFSmBsMnSkPtPYW
        onA5t9yb+tDp6mFg8kgz39QP0oPc6ELkvluO7iVN51FSE+StpTrrEdNCXvZPiFYoHtNBIxWkAVIXL
        XX7VbCTDRcGwktFZvFLwzKs7IIpzFW4l+dYvqlK5iN+uFUsrfevqGzxkSyG0mxtikYofs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i6Bwf-0001Si-3K; Fri, 06 Sep 2019 10:58:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9E704D02CE7; Fri,  6 Sep 2019 11:58:24 +0100 (BST)
Date:   Fri, 6 Sep 2019 11:58:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc:     stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: revert: ASoC: Fail card instantiation if DAI format setup fails
Message-ID: <20190906105824.GS23391@sirena.co.uk>
References: <20190814021047.14828-1-sashal@kernel.org>
 <20190814021047.14828-40-sashal@kernel.org>
 <20190814092213.GC4640@sirena.co.uk>
 <20190826013515.GG5281@sasha-vm>
 <20190827110014.GD23391@sirena.co.uk>
 <20190828021311.GV5281@sasha-vm>
 <alpine.DEB.2.20.1908280859060.5799@lnxricardw1.se.axis.com>
 <alpine.DEB.2.20.1909061031200.3985@lnxricardw1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Mhf1+ydQLhYCbMZ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1909061031200.3985@lnxricardw1.se.axis.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Mhf1+ydQLhYCbMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 10:40:01AM +0200, Ricard Wanderlof wrote:

> But is this being dropped from the master branch as well? To me it makes=
=20
> the kernel behave in an inconsistent way, first reporting a failure to=20
> instantiate a specific sound card in the kernel log, but then seemingly=
=20
> bringing it up anyway.

No, this is absolutely a good and positive change to have in
master and I'm not suggesting that we should drop it there -
sorry if I sounded like that.  I just want to be conservative for
stable so that we don't have anyone updating their stable kernel
and having their audio blow up on them, we don't want to do
anything that'd discourage people from taking stable updates and
hence missing out on security or critical stability updates.

--2Mhf1+ydQLhYCbMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1yO88ACgkQJNaLcl1U
h9DvwQf+IM6JY/Trl9vVLVCQHCEmdvkc3aVmcX5esHzpAQrTBQ8AfvqO0oHqSm4B
faMo0KbjDOVLwPqNxa3b5doG14+sCTlL3mjVJ+yTN+vvf0/0ARQeMUSrHQUaYGmE
1bv/j6rH//7HgmvmQHKm7eluPzyPff/pJc6qwCqkA/ihMcGlxcspgJFRbfq+cPSm
LYj53w08LvXoTAN6I7DHgWDQ2VoSOK8mJCoCYArx4Cf6SPfKeshT/DlWVZIZUtyD
pMaryvgVKY2gnyFRNIWmzautrsqKDyWdT1jil7ODyGkb/KmV2m6k/hZVbek5Yxlg
yb83bhC9qWVbhN09ohoG8ipAjNXMpw==
=M9Ja
-----END PGP SIGNATURE-----

--2Mhf1+ydQLhYCbMZ--
