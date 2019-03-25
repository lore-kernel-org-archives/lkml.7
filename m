Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D0C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553526168;
	bh=QIV7t6MRC7H4KowHjLhhnC/rHbJ+qu3XGRjYJ7MqFC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWnnepRPgWupAv8mDzXTNwlVwBYXq5AX5Md8oI5zFhJd9ghYl8ixQBsPjtqvyZIpD
	 JPFREut1WCLuapHDOfWkdQs3vraQLMInIUs24zUjXUgNt/xq07Bc6WMqK2QwVsGNFO
	 XLoZxInJ2FDyxQRP0nxFjxIqans9QY8PFtDkl360=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfCYPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:02:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7t6D2uHJ7BFTb1OR5kVn/CtubTfMzFwNXlPIeVzoILY=; b=DFpywZZW+znK3KELrl8hU7NHZ
        brPxQX/1te1C20oKCuYrBNhTG3bvn6Aq+fyUoKSaTm+Fx9+h8hmcxnjhTGP8sujyv7LtxtUOBY6Id
        ilrDIHwKoCqN1zBXKt/NRAYXCSYiSMmObGYOgM9uNo0+KUpjO0bMvTBVFe7cj/UjlbCgg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8R7W-0002UC-Cz; Mon, 25 Mar 2019 15:02:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6B62F11288F1; Mon, 25 Mar 2019 15:02:37 +0000 (GMT)
Date:   Mon, 25 Mar 2019 15:02:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Message-ID: <20190325150237.GH7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
 <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 09:18:04AM -0400, Pierre-Louis Bossart wrote:
> On 3/25/19 8:12 AM, Mark Brown wrote:

> > These are driver specific issues not device model issues as far as I can
> > see?  The issue fixed by this as is that you're storing a pointer in the
> > ASoC level (not device model level) probe that you don't free when the
> > component is unbound, causing you to dereference it later during
> > suspend.  There is absolutely no problem with the machine driver not
> > being guaranteed to bind at the time it's initially registered, that's
> > perfectly normal and should cause no problems.

> Agree, what I was referring is that if the machine probe and card
> registration fails (not just deferred), the parent acpi/pci driver isn't
> notified - there is just no means to provide that information and that leads
> to all kinds of configuration issues.

If there are issues here they could happen via means other than a probe
failing so there's a problem whatever is going on - someone manually
unbinding a device for example.

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY7YwACgkQJNaLcl1U
h9Clbwf/eSfum4OA4Z/gu9wTzkAEv/8I/lNUyM1bpru9/4lYtkZjjRh0V2P+Sms+
le3NjV1zK5HG777qhUGAX3iMbkFqbL0xBspUl6fjacleVYnXcUILPYmO4ppy9qia
fvvLZlHoP6WyMVcS2tTI9AlYvrJ84F+Y1b3dvtF7blfH9l08NyS/21l6VXNfu5Ss
YrOXb6ITRdJ392WPd+ASShXVlJoTQLpcMLlCJo9n9TaABaFBxVeeNFgptb4iN4aB
2rHX+Vgr5D9uKoESwPFV2HQZ7vkTO9Jnmc0M3uMr5KeCg+/YEl8BAOjvyB5Cwlr1
hOa3m6t6Dxdpzyna8cvXBdWkYexLfA==
=UHdW
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
