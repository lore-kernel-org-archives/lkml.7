Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782872075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516243;
	bh=3qfTe4VP4h1MLgciTiwb7L6CI04Mb4qYlA66eA8h90I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGE/um8XaCyxSXbDYni9/zqKTJJbuUR7EZSAWzKBpraMYA1YitUUTRnYgC/uAlF1h
	 lI8G42cXNd5JRqvCKhqdFsj0BBlcG+TTduQYWU7dzb8ckornlMFG2NFuzORrhJPMUx
	 /LX/3SW3xxFECXxvtqkTzZ7sYvRPFaOaYKilTVec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfCYMRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:17:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfCYMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3qfTe4VP4h1MLgciTiwb7L6CI04Mb4qYlA66eA8h90I=; b=xYIng4c1FAtJoy2/99xDHAbBb
        WGS4I4Y6XV065KnR+TCZ+6Nl35yANvVuHYC6Py+9x9SaaFFZ6Weq7pDJO3oG+Hgeq6yZePMl3T0qS
        Q/ZdIvw5QmbHQenpCh6ny+Mn51RYYmNyjOn3WRALUqT+5UL044k06AharQooh8MmhRkQs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OWt-00022J-2s; Mon, 25 Mar 2019 12:16:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 876C211288F1; Mon, 25 Mar 2019 12:16:38 +0000 (GMT)
Date:   Mon, 25 Mar 2019 12:16:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Message-ID: <20190325121638.GA14893@sirena.org.uk>
References: <20190325063759.28300-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20190325063759.28300-1-akshu.agrawal@amd.com>
X-Cookie: He who laughs, lasts.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 06:38:27AM +0000, Agrawal, Akshu wrote:
> With CCF support in da7219, we can now set the correct rate of
> wclk and bclk.
> Setting bclk at lower rate at 1.53Mhz from its earlier default
> rate of 3Mhz, also fixes noise issue observed on some dmics.

This doesn't seem to apply against current code, please check and
resend.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxqUACgkQJNaLcl1U
h9AE0wf+LXwOaH1w+xCs6SCg8diunJ4u7GEznVhKGP1N7MznNlyFDd3andGgCGt3
nw82fXJX9sccYdOeXit/jS2bONhXrcKiU6Bj/Y5DfB4WyFtnhx6uI2rrFiiKm7jS
fPSr8ZMOvQSQJyKeb04e7dzYt7oJGCJfqL69IzwHem2Xx7USG41HPfI36xo9ZjRl
SxOy1FAn4ZNxdK9S9Rm40utNUSgvTO9CGa9jagDu+AoDhfP6nOYa9YmTH9c+HYQ2
oaMGpYV07ZS/oaFv0sBtc0ysa1/5rpzg/rZbVEEwwDMmloBXQKqrrhYpnZNsKqiJ
gUBMyhuYtwpytp5znagNZkeoki7n5w==
=ZPfW
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
