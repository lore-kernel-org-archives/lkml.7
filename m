Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D761C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2B6214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306269;
	bh=Xj7N6mDNL85rnZGjlCiHaaNhULhLAZxI2KNaCi8kYIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eoe2tp+LwtvDvUFmR+t+JOk0hRLf57ErRGu6OQON68f/VOGDA49jxqwA047M4V3ri
	 1xbNsJo//OufCFdH7dH8N+v3hnYXnfK9TV5HQcx9y8vvWEcPbCCL3DgoMJ0WjBIQvQ
	 O2OtylQaWKRqZ6p2VSnumPtYyhI7MbgKus0ZY5HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEHJE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:04:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49518 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfEHJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SLaCDPhxMMikTFAxLcu81CNC9LBPAJdG+62+3Qu31NA=; b=FQeEtDtIcZI9ZQMa/x0LAQ2ZC
        Rnt8PX8I2lrNjW5u2IoCgI3gJ74gce8ps6jeYXvH2RfU0kglDYAqZyMnbNpdUAGOcHnlLmNPOYEs5
        tHQO1Itm5msJT070ncRBpnC4rePdXjci8sEPJBTo1X50hKVSshtcqp/PPrtIA4MRV3rug=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIUm-0007fG-5K; Wed, 08 May 2019 09:04:12 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D81CB44000C; Wed,  8 May 2019 10:04:06 +0100 (BST)
Date:   Wed, 8 May 2019 18:04:06 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 3/3] ASoC: rt5677: fall back to DT prop names on error
Message-ID: <20190508090406.GG14916@sirena.org.uk>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-4-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+if5tLMzDwmTCkiQ"
Content-Disposition: inline
In-Reply-To: <20190507220115.90395-4-fletcherw@chromium.org>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+if5tLMzDwmTCkiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 04:01:15PM -0600, Fletcher Woodruff wrote:
> The rt5677 driver uses ACPI-style property names to read from the
> device API. However, these do not match the property names in _DSD
> used on the Chromebook Pixel 2015, which are closer to the Device Tree
> style.  Unify the two functions for reading from the device API so that
> they try ACPI-style names first and fall back to the DT names on error.

This is OK and should probably be the first patch in the series since
it's much simpler than the other ones but depends on them.

--+if5tLMzDwmTCkiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSm4UACgkQJNaLcl1U
h9BXYgf9HL6kgqhLX5BgKf3C1D9thjRYiOmKbp5R2x6lp5KlyJkhLSBNUFaJVciZ
6cshYtsU42VNjyT9ICN7OD3CoROo+HDvy5PaPfylSaNSUq180OQV6t4KE2SNrGZ8
5O1GpwPLUJ2Q+0biQMPOp4eic90mz3usZtSIFgg9K8i0ZsYtmV2t75OeSETJY1au
nxnYwLttQ1R73oRfaB7/uvYETekume/zHZ5BNi6xFPRgKY2cPoK+qUvWKH6CaaLa
WOufUF3Os1nB7azLSxLfZvhRleqVmpv95d/jHtdYOH4920YbHqsImkyInJc8Uh0z
tkxlqDjblH4PgakMTEmJ+T0M7JEAKA==
=gN76
-----END PGP SIGNATURE-----

--+if5tLMzDwmTCkiQ--
