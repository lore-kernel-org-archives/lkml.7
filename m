Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0A42184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfC2PQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:16:53 -0400
Received: from sauhun.de ([88.99.104.3]:54936 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2PQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:16:53 -0400
Received: from localhost (p5486CEF3.dip0.t-ipconnect.de [84.134.206.243])
        by pokefinder.org (Postfix) with ESMTPSA id 02AF92C2817;
        Fri, 29 Mar 2019 16:16:50 +0100 (CET)
Date:   Fri, 29 Mar 2019 16:16:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.1
Message-ID: <20190329151647.GA4556@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you:

A new ID for the i801 driver and some Documentation fixes to make it
easier for people to find the bindings (which is also a basis for
further improvements in that area).

Please pull.

Thanks,

   Wolfram


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 080a910414659dfd18ffaf60a1e95b96c3f50eab:

  i2c: wmt: make bindings file name match the driver (2019-03-27 14:20:20 +0100)

----------------------------------------------------------------
Jarkko Nikula (1):
      i2c: i801: Add support for Intel Comet Lake

Wolfram Sang (5):
      i2c: iop3xx: make bindings file name match the driver
      i2c: mt65xx: make bindings file name match the driver
      i2c: stu300: make bindings file name match the driver
      i2c: sun6i-p2wi: make bindings file name match the driver
      i2c: wmt: make bindings file name match the driver


with much appreciated quality assurance from
----------------------------------------------------------------
Jean Delvare (1):
      (Rev.) i2c: i801: Add support for Intel Comet Lake

 .../devicetree/bindings/i2c/{i2c-xscale.txt => i2c-iop3xx.txt}        | 0
 Documentation/devicetree/bindings/i2c/{i2c-mtk.txt => i2c-mt65xx.txt} | 0
 .../devicetree/bindings/i2c/{i2c-st-ddci2c.txt => i2c-stu300.txt}     | 0
 .../bindings/i2c/{i2c-sunxi-p2wi.txt => i2c-sun6i-p2wi.txt}           | 0
 Documentation/devicetree/bindings/i2c/{i2c-vt8500.txt => i2c-wmt.txt} | 0
 Documentation/i2c/busses/i2c-i801                                     | 1 +
 drivers/i2c/busses/Kconfig                                            | 1 +
 drivers/i2c/busses/i2c-i801.c                                         | 4 ++++
 8 files changed, 6 insertions(+)
 rename Documentation/devicetree/bindings/i2c/{i2c-xscale.txt => i2c-iop3xx.txt} (100%)
 rename Documentation/devicetree/bindings/i2c/{i2c-mtk.txt => i2c-mt65xx.txt} (100%)
 rename Documentation/devicetree/bindings/i2c/{i2c-st-ddci2c.txt => i2c-stu300.txt} (100%)
 rename Documentation/devicetree/bindings/i2c/{i2c-sunxi-p2wi.txt => i2c-sun6i-p2wi.txt} (100%)
 rename Documentation/devicetree/bindings/i2c/{i2c-vt8500.txt => i2c-wmt.txt} (100%)

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyeNtoACgkQFA3kzBSg
KbYfUw/7Bla1RkZJgY0E60hvNY4i6Tc4cddZ+xpy679fIMnNVJYaNoXAlYqtOzsl
5cBseXDrhePxsiGw9IzZgMFZ4g2PiIK/tMITkeulFQiDoEKlKxXHQ4MMvXSmQ5CI
h5wbCRyOC1mIa5PXpRbpc+3dnHlzc/b5vzhXhbt4Teld+hIOhXO0Bhu6fAUJ/ucd
eUw2dpEdDpMUphx99nb20ojjn4JmupXNyFdhNS9BMRrycd5N3Mb2MGl1Hs5XBRiP
kv5J7QoqoFgrbfz/L1U8KFl+WRq9nBfMGfc1ufjbYcNDeUvIo7r+Q7NnfnLWHlSd
QaEM92f3ceH5SSuHNvDS/kVa+AJ9vPU/wV2YI2s5/LzRl7DwtizNnQ2uKG/B9dC3
KTCenG6MWGbilK/2i3zssHBzKAnvEBjJAao8w8wWXH8EESyP2CK2Le5pWV0PCa8s
12sS2jw9TsyDeAlbDFRuLhjs0BSWriYB5+nXjscgfBa2u++shc96vXu9l2kX6Q/b
d05F3lFu/a3inGpZa4WnrRdCYsEJ/wnEQ3q3DRTu6Sgb2t8fZISfv+DcFur/u8Pq
rKjU1rolK0FZd7T1FLf77hs/FWKxrtGh2WONiAhP44EIkrVNlGa1XM/xGWwR9Wfr
f+/nAza0ZERaYogYAZU2r0/0/UtQjVHethQQdSl2NMTdPQWs/cU=
=1ET9
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
