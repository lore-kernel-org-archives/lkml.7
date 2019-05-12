Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BCC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4951D2183F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="clNGRZ6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfELBGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:06:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfELBGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:06:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 451m3n6Vntz9s6w;
        Sun, 12 May 2019 11:06:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557623174;
        bh=Xtjyvso89laWXm6NCNbkiV0He2EaomzL1+sXkM99k6I=;
        h=Date:From:To:Cc:Subject:From;
        b=clNGRZ6mq9YLH3CsZNatRQ7Krrmft8bqQjMn7IxrziorrWPca+NTcOTsI534gjKJ+
         ft+D24B82NiGJHFusbEcaN+xtl098ZPkEcocii3Ap2URsOU+JBUM2jI6HsQ8TLyn2O
         Iexp+DD/w9QUxkSeuiy4yW5t5VZoKy3P2x9/AkY2Lp/Tv0TySah42k9sAxI+XNkCR1
         4wMdQLuliEhX69VZqhoegDrfLS6o2Sq4aHHHOXMARWQ7gQ8ff/0HdTk96uKIMh1A3o
         6sZSK310s+g2z1AXOxtlr33skd3oZm+76ypwz0AOdfyVp/5LXdj9dU5hXO76GjjSTO
         CC4mZDUon4Ugw==
Date:   Sun, 12 May 2019 11:06:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
Subject: linux-next: Fixes tag needs some work in the thermal-soc tree
Message-ID: <20190512110603.767286b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/URt6mAOff+2C4Lc0Y_moRZ6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/URt6mAOff+2C4Lc0Y_moRZ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

In commit

  201f0534b335 ("thermal: rcar_gen3_thermal: fix interrupt type")

Fixes tag

  Fixes: 7d4b269776ec6 ("enable hardware interrupts for trip points")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/URt6mAOff+2C4Lc0Y_moRZ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzXcXsACgkQAVBC80lX
0GyEJggAoHu7bgeOYAMmFkS17O/82MTuiOP9Mx1tspbvJ0SGLshJ56fkGc1zFoIN
dMuw4vZXcV917W2daahGgcYXNGwQ1aATTPU6lOwzuyDZOB6tXUz52FpEWhv7bIxx
DuOdxIC3Vm1r2Jlcs4rlfStE2uhsYlog7WN/hvpb0GZ7xgNuwQFvxCkybWripA6R
MNEdFGtmDNkKVYHXYPpGxxmOVb5GggDVOP37m/FQQ48ADmObFnc4r/vY2VqmC0Zi
DQie1zS10lDEY0W00IgBowhtDARXKNrocHVoRubi8PI0v6EPPrzwLZ4uqawH71SD
E+hAH+JPgmmG19ZAY5/6pMuo3MOeIQ==
=rny1
-----END PGP SIGNATURE-----

--Sig_/URt6mAOff+2C4Lc0Y_moRZ6--
