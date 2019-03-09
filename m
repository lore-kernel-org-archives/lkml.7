Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6ABC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80973207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCIJmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:42:39 -0500
Received: from sauhun.de ([88.99.104.3]:39958 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfCIJmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:42:39 -0500
Received: from localhost (p5486CD1C.dip0.t-ipconnect.de [84.134.205.28])
        by pokefinder.org (Postfix) with ESMTPSA id 55DB12E3551;
        Sat,  9 Mar 2019 10:42:37 +0100 (CET)
Date:   Sat, 9 Mar 2019 10:42:36 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190309094236.GA1340@kunai>
References: <20190215090202.157100-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20190215090202.157100-1-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshol=
d is
> 0 and msg->len is also 0, function makes zero-length allocation, which re=
turns
> a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause la=
ter
> code to fail. Modify the threshold to > 0 so the function returns NULL po=
inter.
>=20
> Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transac=
tions")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reworded commit message to "HW doesn't support 0 length" and applied to
for-current, thanks!


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDioMACgkQFA3kzBSg
KbZAhw//VvjmWX2V1D7BqMoYtsWT9g6U9UWiy4+ovG8ttogdHVOKkDfaHp2IT58Y
sQced8n/GBZv4x9a7tK4zXazCOI0zNbUqXWfv4WPqqXCp15wNdG6MzokU1hnTGE8
WuTbXkgS5f/l+r18+bqwsuuk/0kMZ0NH+226y5BJQo9/f3mWefXNX5lgMumsN9P0
ple/6Oy6GS3bL7QyncE9aiMBJoJnjvpNnQBjVfvUt12yGtrDZvdQR5zQxwvDJMXw
oCtZtioGZndbsnBKqozPm5XtlKPrsCPeiHorrIZiOreccerL3ORkmMZgGJo1urRs
Uic7hyPiQ68SE5mbpzRer8GTZ19EhDNOyMEaoscYOQvlCiU3hcMijUJs/eKx0R04
SbU0Cwr1Bg1XD8pYvWOrf5rDeig1MEpknyZFguvcwJr14nB6d1ul05djL3K3ywJt
xUdrQgScWddJ8Rvj8MSNmxg52FzQHpXeSU1qXPsug7PIB3BCAXHS1gRpU66CZw9q
zlYsAIEAXCaeGuIPBvUvnHZyWUL+V/zgOfDvcIIQjdIueGMkTwnT/y2lSHzQRZI2
m0qabT7TEBC8QFAdwxoECWzOB7ImM6DS3xEh2h79lGVtvSU49Su23rU1pT18fUfb
Ca9kQqVfssz+3iD5SpkbD33LBBYedi9hV+665sC+DZeHmiXe3/8=
=KWi3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
