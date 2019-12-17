Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AF32064B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576582680;
	bh=7O8w0+AKMs4OORHcvglZwwgxdWqvpUMPSVE3/enKA4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IkH3mTOKa2qMN5QqTkz6tn3XNNh1LOyBFmLmrIoMaMh17EwtX/lJkS+u6ARNjnAzB
	 BLPwwluztm74RHIpKGSHf/LjzDGfeA5neK4fs5bd5D3GNB2KvmKWsy+8SFVWW/rsaN
	 QJ0EqQi2DB2nSf/gMG1u0wEn/KR6fi4hUQWa+9nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfLQLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:37:59 -0500
Received: from foss.arm.com ([217.140.110.172]:33914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:37:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C2631B;
        Tue, 17 Dec 2019 03:37:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDB83F6CF;
        Tue, 17 Dec 2019 03:37:57 -0800 (PST)
Date:   Tue, 17 Dec 2019 11:37:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] spi: bcm2835: no dev_err() on clk_get()
 -EPROBE_DEFER
Message-ID: <20191217113756.GA4755@sirena.org.uk>
References: <20191216230802.45715-1-jquinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20191216230802.45715-1-jquinlan@broadcom.com>
X-Cookie: Thufir's a Harkonnen now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 06:08:01PM -0500, Jim Quinlan wrote:
> Changes in v2:
> - use dev_dbg() for -EPROBE_DEFER, dev_err() for other errors.


Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl34vhAACgkQJNaLcl1U
h9DCKgf/YoplvcJ+ZiZKO2wNQyrsGbxzLwXcrNuR0JNdf93xNNeuOwmXU7pl6aNy
QnA+W+ezVelzur13szkX/XNF1/l7r2plXRjxKGk8h9pZgcgeevaoBVXvBwckDb8l
GmGbvUHgrUUcS3u62tX6swaWq7qr5EXAmJu2yRjJBV33QCcLsMJM+XBavhHPLMLD
I5JaTqeSomiHfsMOngOSpP+TmbYc93g2q/nLW3ljwGHW8ke0N+AqPvVtnQGCOAvP
YfxqsNQZQFsApVh+jh/80CqF+sqSKtGQXBPs/a9BQ6dFVZTbTyJlUsX1YONwKzrk
7UPnQt9K4d905TxNkxjkXhPVqWkNiA==
=nV6Y
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
