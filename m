Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78004C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F65206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578398946;
	bh=12B+EDHifIu+OMywiepf6vWJEbqmlJwnAX/Mm37z0J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OOeHsBWV5GSdireiIs25sbLd27TnEmqlrypN1d9Ox4rtuhN4H8I8Y2i0bXkxs0mjw
	 gufNKnbD+Wt5CbUSoEYJuDlHZ7H61gLS+CtnRhUH8gBZLnZecVSoEdWjT5XneQCV2K
	 0oj6fga7UUnHHeXlfZ1q9v5Uxs+x8q3CIcJLsjas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgAGMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:09:05 -0500
Received: from foss.arm.com ([217.140.110.172]:56798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:09:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA3231B;
        Tue,  7 Jan 2020 04:09:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9BA3F534;
        Tue,  7 Jan 2020 04:09:03 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:09:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regmap: add iopoll-like atomic polling macro
Message-ID: <20200107120902.GC4877@sirena.org.uk>
References: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
X-Cookie: Will Rogers never met you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2020 at 03:58:09PM +0530, Sameer Pujar wrote:
> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
> is atomic version of already available 'regmap_read_poll_timeout' macro.

In general regmap really can't be used in atomic contexts - we do have
options to configure a regmap so it can be used there but they're not
the default.  It'd be better if the comment mentioned this and warned
against use with normal regmaps so people are less likely to try to use
this in an atomic context when the regmap doesn't support that.

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4UdN0ACgkQJNaLcl1U
h9DYeAf9GaS7jI51qX2g+IBgjs6DjJVcyUu7LnhBIzIIAb9aY3ggw4kxK5cXwz2Z
TcbCCMz8vy4xdiW4DMTF/FZH7m1poO6cHqImuFDBDm21Jiutn4UOgXZyERRuGe0W
QTGNOPukvUCjynzfuW9cYh9TxV+SbICDzAhOw/35cLoakSme8PfMdjCB2BjPzcvt
nmiqo9aQu7MIvTM9ln1P8CDGykJhZpFr30i/Ney0gYKs+/OrOEqmMiIazWDFlSrK
ZVlPTOWDPECaB3zznmiy+Amn9c33tQjtwGtwSUP5NEhslzLzCJ12/xgufXtyz6DA
72ABc7At57aP58stNmyes0JFsrd4hQ==
=gQir
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
