Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F620815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfKYHrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:47:22 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:41452 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:47:21 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1B3A1200A95;
        Mon, 25 Nov 2019 07:47:20 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D74F1205E5; Mon, 25 Nov 2019 08:07:45 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:07:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia odd fixes for v5.5
Message-ID: <20191125070745.GA589513@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull the following changes since commit
c74386d50fbaf4a54fd3fe560f1abc709c0cff4b:

  afs: Fix missing timeout reset (2019-11-19 14:36:38 -0800)

which are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

up to bd9d6e0371d147b710f549b55d7b44008264aa06:

  pcmcia: remove unused dprintk definition (2019-11-22 07:03:45 +0100)


These are just a few odd fixes and improvements to the PCMCIA core.


Thanks,
	Dominik

----------------------------------------------------------------
Ben Dooks (Codethink) (2):
      pcmcia: include cs_internal.h for missing declarations
      pcmcia: include <pcmcia/ds.h> for pcmcia_parse_tuple

Chuhong Yuan (1):
      pcmcia: Use dev_get_drvdata where possible

Colin Ian King (1):
      pcmcia: clean an indentation issues, remove extraneous spaces

Dominik Brodowski (1):
      pcmcia: remove unused dprintk definition

 drivers/pcmcia/cardbus.c      |  2 ++
 drivers/pcmcia/cistpl.c       |  1 +
 drivers/pcmcia/i82092.c       | 34 ++++++++++++++++------------------
 drivers/pcmcia/i82092aa.h     |  2 --
 drivers/pcmcia/yenta_socket.c |  3 +--
 5 files changed, 20 insertions(+), 22 deletions(-)

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAl3bfb0ACgkQmpdgiUyN
ow2ytw//QBH+b6HTSAXWzACGOWuDbVgQd302ZInlGMMf+TjLS2ig4BMSx0azMXQa
n4QYQpgI9nWVHQCtZ16E7C2NA64FpKy1EkXsPX6dZVqeqKFKrtpknoooLDNKjhmp
PhETg3EIbaFQt12iWhRmXXRlKkdTErXbK6Fu01iw4/ZOTDcxvu1OL14qrSQEjL6a
9MueKHeMGAtvjttK05/3L4ylR8XpbRSE64YeBDTxAL3FIilKOG8wvy7BxvY8d+py
rpjslrHZGkj4ZScJ/VYpzm+Ctdkl01TxBUNe/niViKLD1wr8XXyL5JkQcNuNTyvh
Wy1cID26tUFD8LAlUer/Q22los+Ri1e1iWSi1+PkrkuaZC6U+cOWRUwZzMXQsoUn
qMvRE5MisGBnj0rpwx5bpT13JfcSXfxmQtoqK1GqoojYhUvK8kdFUlYOgtkbJqf+
LXjLVedOLPrvL3XTehTEt4+FpplEhf8xmoxJ9yz9V3PRue1gJjOugVRW0fdNF7uG
LrBkV8gzbivv9kBdqL/s7/RQ76t/eEib47R6SRGYdc4o0riN1USu87TDAyV4xm49
ej41kWbwjlAX2J7uj/UVsjCU0+0DdEsMbSEckROgK5JKNO3mkC0WfmV9S0b5ySpZ
xbsf/tJWBhjCXQQmW9LlUNV/OwN1A2lpsi2P8tQTC/cswTbLCc8=
=JJDM
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
