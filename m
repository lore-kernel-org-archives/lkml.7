Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA3FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64652214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561464342;
	bh=WdiIoMF8T+Em7Br1TDG3/jptDwOHxqVX9dK/rUu8oWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yYunRUFxZVKqYYrCWqC7gr9UD7qbQPBEvxrRxyLyvoUU0dfUWK+9c3RiBajaiDNa6
	 ox5KpnE6Ui1p42uHzTwJnG4AFFsSh7WNZMfNbB6Bg1ob8vDNT4BNnWjDgXJNn4NI+o
	 a0fhdJ7XAjCSEiV4ubEUD6Q8yMcOQxqBa2OV9MCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfFYMFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:05:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFYMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DWICQ0zpYKRYMlBGBW8GJ1QjmjM3KJwVVYOSzyrALl0=; b=YL9CFYhoDEySP6EpxF75BmGLG
        mkb0s15KBJDC1IA08M14Xy4TViWorkCjLWg+9zCkblSFG00RZcaQw9zWKLUKYw3P3ba0zsEHE+oNu
        RLqXUbmsDmilnpZWPe0Qja5G+WABPM3FzMvD/FKfbizP3n2HoC/cZwCPKTtvHbEzT3q7M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfkBv-0005EI-1f; Tue, 25 Jun 2019 12:04:51 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7CFA5440046; Tue, 25 Jun 2019 13:04:50 +0100 (BST)
Date:   Tue, 25 Jun 2019 13:04:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Fix driver reload issues
Message-ID: <20190625120450.GR5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eCam2inYEBLywDwW"
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eCam2inYEBLywDwW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:33PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Hi,
>=20
> This series of patches introduces fixes to various issues found while
> trying to unload all snd* modules and then loading them again. This
> allows for modules to be really _modules_ and be unloaded and loaded on
> demand, making it easier to develop and test them without constant
> system reboots.

Pierre?  You did comment on the general concept in one of the patches
but not on any of the patches directly.

--eCam2inYEBLywDwW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0SDeEACgkQJNaLcl1U
h9Aszgf/ZJcrZYUqHzmeb3usoo7uoPZKU3yDTW95/KnXa232hRqc+j9GhPGFxXh5
gZjfJzHgyW/51JU+fGwPfMUP4EF/QgSzBBleqChmxPxmnmuD8MPi81bcSLHAtj0e
O2xQ4PJ0FM/FjaZaCWVjSxq0WQf22K4gfZjcRa6GmbYtourQgMPPQVbz3nXREqQc
PCgSV8UyoLC8xR72b0eUIks0UFuR7NVhKJSirPAmdspgdDdPT9WI3pFRmWUeZjno
gVLToJw2hJ9oNp0HIk2fHH/LuAyF6HRWJHQFCJypSWuz3btq/G9b5zgaQYKNxNaT
2XJRfIR7ang8lYLECK/8CnCxS6ZVgA==
=j2NT
-----END PGP SIGNATURE-----

--eCam2inYEBLywDwW--
