Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF176218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCOLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:00:17 -0400
Received: from sauhun.de ([88.99.104.3]:36776 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfCOLAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:00:17 -0400
Received: from localhost (unknown [81.92.17.130])
        by pokefinder.org (Postfix) with ESMTPSA id 076D32C3637;
        Fri, 15 Mar 2019 12:00:14 +0100 (CET)
Date:   Fri, 15 Mar 2019 12:00:14 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.1
Message-ID: <20190315110010.GA2084@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a set of driver bugfixes and an improvement for a core helper which
would be nice to have in your tree before rc1.

Please pull.

Thanks,

   Wolfram


The following changes since commit ea295481b6e313b4ea3ca2720ffcafd6005b5643:

  Merge tag 'xarray-5.1-rc1' of git://git.infradead.org/users/willy/linux-dax (2019-03-11 20:06:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to cd86d1403bb4c80e443d736b2a692cbf68a9f471:

  i2c: i2c-designware-platdrv: Always use a dynamic adapter number (2019-03-13 18:07:10 +0100)

----------------------------------------------------------------
Hans de Goede (2):
      i2c: i2c-designware-platdrv: Cleanup setting of the adapter number
      i2c: i2c-designware-platdrv: Always use a dynamic adapter number

Hiromitsu Yamasaki (1):
      i2c: rcar: fix concurrency issue related to ICDMAER

Hsin-Yi Wang (1):
      i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()

Louis Taylor (1):
      i2c: sis630: correct format strings

Nicolas Le Bayon (1):
      i2c: i2c-stm32f7: Fix SDADEL minimum formula

Wolfram Sang (2):
      i2c: rcar: explain the lockless design
      i2c: add extra check to safe DMA buffer helper


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: i2c-designware-platdrv: Cleanup setting of the adapter number

Hsin-Yi Wang (1):
      (Rev.) i2c: add extra check to safe DMA buffer helper

Jean Delvare (1):
      (Rev.) i2c: sis630: correct format strings

Nick Desaulniers (1):
      (Rev.) i2c: sis630: correct format strings

Pierre-Yves MORDRET (1):
      (Rev.) i2c: i2c-stm32f7: Fix SDADEL minimum formula

Simon Horman (2):
      (Rev.) i2c: rcar: explain the lockless design
      (Rev.) i2c: rcar: fix concurrency issue related to ICDMAER

 drivers/i2c/busses/i2c-designware-platdrv.c |  7 +++----
 drivers/i2c/busses/i2c-mt65xx.c             |  8 ++++----
 drivers/i2c/busses/i2c-rcar.c               | 15 ++++++++++++---
 drivers/i2c/busses/i2c-sis630.c             |  4 ++--
 drivers/i2c/busses/i2c-stm32f7.c            |  2 +-
 drivers/i2c/i2c-core-base.c                 |  9 +++++++--
 6 files changed, 29 insertions(+), 16 deletions(-)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyLhbUACgkQFA3kzBSg
KbYF4Q//VLbxU5YTETiRpZ8Kt0TkhbrtJv5axJDSziQxCU7vEqr/hr7zbsE9HIQ1
CcNb389VFRcMeCMWi+PGfUkEsAqdNsCBiNjjuZ3oGLeITxx5xvUmoapdON+nVAKd
+LaM3+NFZPW4D1GoNFnj3Hsn5f3Uoqc7mUzOhICTgKIRv3NdUtjheMnsJTmOCw67
ay/5eNtd10gh2I1U1BXYlJcGfyEJBVkrWKPCJa7y+Tz/4dv2RPCpmmuIeRcO4zE7
ILJGNqmuhhnxwN4rL7aex3g7STl1+IjFv6CsuFRxfwEhb72j6Q+YgAZoQH065SFC
R3Jik9Uot/r+LkzBCF0lW1Klis4ldWutkLUmwm1C+YmZOONB9v2thPf93OBuRLKV
qQHV8NfxZQld3LjNaHVN3XxtRdInwrwPvG7iSMdCMBrTRAoUOJmYZjd9UArgqxfa
Ec9s9gKx7jAYb1jKPwPk3FteMKi2+POiMj4PKTdSAhM6tk8xy1Y5gdTI75Vu7g3Z
Uo6pEgm8Wt6HZvWr4LDDcHjIuPAxa8b1hx/XlxIGOtLrdERvgKKWOdCwvF+KWCVY
BeaDmGZJi6Zim4rbjqdA+ANWeeJMLvXNb52JgwhvM9RiDsNSM9pLxZbB9xGF85WI
iE3Ido4ZCoJyLn3vtdJE7NKKcvUnZYhxp2LFQlB1kmkuRzZkwFg=
=VfU/
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
