Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE142077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566997758;
	bh=U3FZYhMcq/k1KSsuXFiZMT2uabIYtqGZpMhTCs/Urek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L0E9512zmW7s4QV8xehUpncLIxQu9ABS7pjuCcfc45u3CQ9ZtX5ulrDbjfTZiZlzH
	 qP8W7zXYuDuJ+xU2jOSstMo8LEfp2JzLZ7B2cpCKlYSGL/8uluG8OZOWv3oD8FGJfs
	 Xmj4YeypwzcBtt2VBWLihmQlvrs9bmtMhGyg/Tbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfH1NJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:09:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1NJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WSWbS6ihzqaiPHwyoaBqyBgPm/auLcr1DVrpKWTKdbU=; b=IXEh7FFZEguEpku6GjnPND5zw
        Fkkgg/y7e7HuxV8YO5ZsB9ZIlDwjxiMNUHJs6lA6ZEQL69p0qHmOWx4guWLQCa/3XAspchiUDQmYy
        SW9YUnm1Y0gwkPz/OtRL22amt+MHddAsr5fX/W5/IIQ9BKWzaymxgjeS6TAaxzSqxSJpg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2xhJ-0004FK-Q9; Wed, 28 Aug 2019 13:09:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3438D2742B61; Wed, 28 Aug 2019 14:09:13 +0100 (BST)
Date:   Wed, 28 Aug 2019 14:09:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: bcm-qspi: Make BSPI default mode
Message-ID: <20190828130913.GI4298@sirena.co.uk>
References: <1565086474-4461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190806121612.GB4527@sirena.org.uk>
 <CAC=U0a2VsdrjypcLQCJTROmbF9ojuJ2rA4Og7XXeR48LAjrArA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <CAC=U0a2VsdrjypcLQCJTROmbF9ojuJ2rA4Og7XXeR48LAjrArA@mail.gmail.com>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 09:01:42AM -0400, Kamal Dasu wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The spi-nor controller defaults to BSPI mode. So its being put to its
> default mode.

The changelog should explain this.

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mfPgACgkQJNaLcl1U
h9DT8Af/W9xLRIZrZOMJ7/axJAM6NO/K2kioTvE+M5sZVU6WqHQf8PxU2bIEMUk4
Thq6SBNkopZrxLYPuEVvztrBImWJhpvG7cxd5xb6+3XWDxU+gfRNGdBoOn1J+k7u
cCs1Fl8eCkUWcu09MPuQ/iL7kbZcXxOdyvN3xP4T+q4TpLudWae7dTOUc7CxltqL
dNWj8/UEAjr/Qa7uyzYZ+zUe6rjamJ0NafvgFzOdlbQjB+rWzmvXVE4JjeLoj/yT
X1ApML5M/o0Ii2LHvsTVFWQiW0bXhwjQhrV+yZu7afFBlocXHSqacP+txTrWhRBX
wPMTLMcjgcFYeyZGIg5NxZWZ+D0xkg==
=l/ec
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--
