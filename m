Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D7C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E222314
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H6d1b6QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLSAuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:50:40 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:50:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dYFm4W5Fz9sPh;
        Thu, 19 Dec 2019 11:50:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576716637;
        bh=LiWs2P61sq1shFi13EV55p92N+g4EB+CQsziU1YUEqg=;
        h=Date:From:To:Cc:Subject:From;
        b=H6d1b6QYdDjoQcgmT2NP7LosK1H1vc+G6CWo9ufQtDXXPOWnM5G0S7xlMg/NlvhKH
         ciccw+AfBJGSa5q+obIomp1LqitotWQhHTY13yfqMPKWMEXtOvZbmlM1eZx0ColbqO
         TOfPZrxZ4FVqBLon1KEQfVaQ2XhFMWNxvglq1uthB44Cnoh5jO7hfa+GA4sL/1IAdi
         ARY1f93LZn3Mtn8xgh0eP9Gbgm7xg7MwguxwGaG96JLV2MYqir3mU8DoPA/aVvHJkT
         mUjOvbv4294L6IKfm2GAwVjrJ7jo1+M1oPprPw4dEMI+mhVXOOBgBkSGmeyDSyoZ8A
         zrNnoRD4C+PCQ==
Date:   Thu, 19 Dec 2019 11:50:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20191219115036.4699721c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hoyOk7tUIKmoE0FIRDq0+Ne";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hoyOk7tUIKmoE0FIRDq0+Ne
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  kernel/cpu.c

between commit:

  45178ac0cea8 ("cpu/hotplug, stop_machine: Fix stop_machine vs hotplug ord=
er")

from the tip tree and commit:

  d62c673f4cfc ("cpu/hotplug, stop_machine: Fix stop_machine vs hotplug ord=
er")

from the rcu tree.

I fixed it up (I just used the tip tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/hoyOk7tUIKmoE0FIRDq0+Ne
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl36yVwACgkQAVBC80lX
0GyP0QgAi6Hh7BKQdxXSvalXiYH6/eh0KGlY6l+T9/WodwCFbhoHobzHxdICHmJ4
btKDDak5+gyaXyDrqP7iJyYE1Beku8qAVMm8Lv59dnNzAR1U9ju97xtzkaOexo9j
mGj0K1i4jRJPOXvfoVxldrAumlRMrIudPwLQ9wAHH5RLzC96pmDExTTL9hIYctTP
z/HEsKhY6Hf12AWwuPxxLzClz1Rb/++cqdkBU3H/MuOnXNeUVWESU2uvPlGixf/d
ktDxSAEE3BuD6bC3xtNHavpG+gHG9EyY0lfoaJ+G0EnGlk3Zi/cViYmeCY8igo8E
kP2xo19zetHBHF3rQSkL5jIT0z/oQA==
=aRB3
-----END PGP SIGNATURE-----

--Sig_/hoyOk7tUIKmoE0FIRDq0+Ne--
