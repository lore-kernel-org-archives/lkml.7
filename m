Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68598C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A00217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555554919;
	bh=l1oVrBI3MYalFYrCgdOqcs+vkGCjNTZ+i+vzrI+mfyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXUOyC+IqpYUrWL4Di4fT5SDRSu0Py5zcm/ED+E7XjRdsOw+76tyfnzOpE9I7zpmN
	 2v0TBieonA0U1erJMkSu1jWRcuPI1KaMtDj3b+0GRoVZ4iufEQT8HPTNhZkwy9lNQ1
	 y7/TTwpTSoFXq8F9cOMOHnSbEM9IasMdb2RiGjiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfDRCfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387442AbfDRCfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:15 -0400
Received: from earth.universe (dyndsl-037-138-087-229.ewe-ip-backbone.de [37.138.87.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC3B2186A;
        Thu, 18 Apr 2019 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555554915;
        bh=l1oVrBI3MYalFYrCgdOqcs+vkGCjNTZ+i+vzrI+mfyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1vHaW/6hGW8TMbG2L9X235NB7PopilNsLC0BTXO16ZMyxY36Z5jLjELbPTPhmClCG
         fK2m2/j3LXg3yDY7oE/p7XJGOkKfdd1i1vilG3ZCcRmNbj1c8zmxlNr6WGFj9xDAFE
         zVLv59GVapamA+KtI3jAq61hV2EfoIfnd9ioShgo=
Received: by earth.universe (Postfix, from userid 1000)
        id E0EF43C08D8; Wed, 17 Apr 2019 23:27:03 +0200 (CEST)
Date:   Wed, 17 Apr 2019 23:27:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 0/7] ARM: sun8i: a83t: Enable USB OTG
Message-ID: <20190417212703.7qq3nzjdvnceaim2@earth.universe>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igqa3fbpnirkgubc"
Content-Disposition: inline
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igqa3fbpnirkgubc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Apr 16, 2019 at 02:40:17PM +0800, Chen-Yu Tsai wrote:
> This is v4 of my A83T USB power supply / OTG series. Hopefully this is
> the last revision even though it's kind of late in the -rc cycle for
> the patches to make the next release. Fingers crossed.

Patches 1-5 (i.e. all except DTS) queued to power-supply subsystem.

-- Sebastian

--igqa3fbpnirkgubc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3miQACgkQ2O7X88g7
+prqWw/+J4SyipXVg9AfuDS5gIqA+BsALd4XP08mMK21RNXCtwsFBvdE7tVt14c9
8wP8QK0MJwET85erwMutvCQzhGs86xrSJQvRMliu0urFZquMhfOCNCwT4h8Riboa
1ZjFBJdbM930Y6uQCbnKbbI3+0+kjALT3eVAqWrEVjDZ0AZEKRKssBTRKxzGfKpJ
YHuh986celDxfRGv8diGBH41cVFJfkkZl53Pla0Bl0ZMfsQ4No88k6W1Zzukma7z
uTY22Ds8PZt/vVxiGpCUsOHdZdzhBBc26TXNRS//whNAW33amSC/XqUL4zBULwIe
jZg7iZW1HA250CWHIfzVc+E1tMbHLDHti7wvHvhmOmDPysvqKeBQKfJC+DrlaVHf
rUC1xFGDfSmi4dkYCaTGgLv8eT0UsgQrFPv/g20MQt7Xv/iH2eyDQgnPcyBkOamx
hRbqCo4LhANxHcinDy5W60OByKsdNAhpAJLBj2PLvFQb44yJBoJsLvvKaf3T28sO
YYBjg2+Ukwbph8tpFS75BSy4oT6ovi3WuIDj3edehCJA/4Z6k9FiZyJ+mKEQ0GXE
0BnckOAbypMUZXXJLUA8oa+IehClPC4ENGf3sE+TaSbmU+RB8qs20fJrrU7TvsFj
t65pmglJPm0Yz3UzCr4LZ3hEXBSCjwJ4n70rEB21Xsfvi5gpXs8=
=QGzf
-----END PGP SIGNATURE-----

--igqa3fbpnirkgubc--
