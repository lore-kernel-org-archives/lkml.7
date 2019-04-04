Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B6720651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554355948;
	bh=m2O0idEz7qzLnuts5p7+xeJ2BXq92ygBST9FJiGUuOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5J/N6C3idYrfotT5hBbQBg+zqZLmcbD+pXEAZxeV7TQFHbwH198LaJnU8CYJE0NS
	 oh8g0FFpP66zrDSD500zp9LoZyVkdamMpt39/UmwlG5znSACstyaGBPlfcaxwmDiOB
	 mEP2P8/VceQ9V53U86QJ2J1XtlWgMWXjqDa9MHMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDDFc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:32:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1GddzkAupY5SqXV8ojWTvt6lZGSazWMwnmp47hzTNr4=; b=ivBGbHsr67IB3TawJ/uw152LS
        6kvOP3TAfjJEkZiXafAXAVLB28WATMkXsFL2lvfFFmTQbXkOlZBiHqhnlrU5sZEr/mXGVqwS+ebPP
        HgQp1Iy5Otgl/mNmxesoRmd80TPt/qXu9wmoFdSQOkDJ/b8WrwnWole1r5WfwtkqQVlLM=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBuyq-00045U-7M; Thu, 04 Apr 2019 05:32:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D6FEC441D3C; Thu,  4 Apr 2019 12:32:00 +0700 (+07)
Date:   Thu, 4 Apr 2019 12:32:00 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
Message-ID: <20190404053200.GL5748@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190402050236.GV2059@sirena.org.uk>
 <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jl+DbTnyraiZ/loT"
Content-Disposition: inline
In-Reply-To: <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jl+DbTnyraiZ/loT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 03:32:04PM -0600, Fletcher Woodruff wrote:
> On Mon, Apr 1, 2019 at 11:02 PM Mark Brown <broonie@kernel.org> wrote:

> > This looks unrelated to the polarity of the interupt?

> Yes this is separate. If a plug/unplug happens after regmap_read and
> before regmap_write, it will not be registered, so we loop to make
> sure that it's caught in a later iteration. I can clarify this in the
> patch notes.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do.

--Jl+DbTnyraiZ/loT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylltAACgkQJNaLcl1U
h9AcpQgAhQoDgeHNiUlHeU0PJoxiogKu9AGs2BjWc1nxPz7wc8b+m1nXie49QDIW
4I146o6NR3lHRK/wYNKMAVYegAx2Zl6aq2jlzcOagg0DQW7AxYnZ2QZqv9q6iOZ7
LkjqeEKTE9xoncKyjYRyJQ52KAyeEh8c61AXzMUUWbKN4pOfXWYb7oX7DEI7Nk04
yt63rjdiDv+R9hNw4vyFt/gV/LyGWcHcHlfhQV0LCKVPwFX4328aZ/XA1lpFlX+6
9B/sj3megqEG2lRajQeUsEitb4M7RU8BpR0TYJfQPW9mW13+AD7FmLD0PeHgS0oh
ZuAmSf0Kmxp/zymL4h2dANsiAHE2DA==
=PlIW
-----END PGP SIGNATURE-----

--Jl+DbTnyraiZ/loT--
