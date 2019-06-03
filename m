Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D94B2671F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559590978;
	bh=tIfrvoNIspI5CbqTkEV2gEODTfE7BNawMwUOeLc4PO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vsD2Vrs06K2YkCjgMyA+gYgXj7l2v1GAHkO3264szR5L/elMjnQpJB3XnfTlYpHTn
	 q13vCAufXTpo/0mPL5DtoLYZKQyhcRDZO9Ok2QSMHOBNQtpNZchCuCf5MCT/vsOGjS
	 vQgfM99YZerAdbxN24cwxuQmTR8JewPP1yDCOcv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFCTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:42:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tIfrvoNIspI5CbqTkEV2gEODTfE7BNawMwUOeLc4PO8=; b=a98VLgOiYRjz72k0y9ipB08y2
        KdXOhsLbCb0GZQg4tl0ds165u9gRRWFROIotblTXX0AEJn5RtZHCZs2dAcP4ZwKmYVjhpawu89Pm+
        3sOdQYEY4CunR2NMqRtosxVuKNt6Bg18bETIqs1WLcb0a10csvKVzg6QMGGxEGxS6spY0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXsr4-0003pk-1l; Mon, 03 Jun 2019 19:42:50 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 57C1A440046; Mon,  3 Jun 2019 20:42:49 +0100 (BST)
Date:   Mon, 3 Jun 2019 20:42:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190603194249.GD2456@sirena.org.uk>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/w6WUUxYkubDgwa5"
Content-Disposition: inline
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/w6WUUxYkubDgwa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 11:33:31AM -0700, Gwendal Grignou wrote:
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.

I'm not clear why I keep getting copied on this series or why it's being
resent?

--/w6WUUxYkubDgwa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1eDgACgkQJNaLcl1U
h9CUdAf+P7DPQoMLbmeun5gNLN/SYRZqIpBVijDS49/Z+3iKziqHNPbU20RonvSz
T4tnB1L5i1kpNoERu8p4Gi1EZZxci83XbMhdY3lFpB9g8hG1Rzbkr/hDNmW9gNRt
c8j7vHmPfUDkSFqW8q0xVFaUqKjA6bY/9fcnPQxjPO8JSI79pEEbWDW2Zl3rCjJU
HG9J9bJyyb1oi6aYeNaqW1yxlO0NGFMGOptkjnsMiFiezIyTXJvjyJkCRbDRvKO2
GONx71tvF+Yu5xgtjvHI4BvGRvTc7ACZHFzU1QddoviXcN5W8yQYRzUA22m0tQWk
/OZapcFla0zR1p4UibW4OXdzmbrOJA==
=MFOE
-----END PGP SIGNATURE-----

--/w6WUUxYkubDgwa5--
