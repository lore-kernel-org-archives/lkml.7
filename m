Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76193204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HnxhJAi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfEGVgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:36:11 -0400
Received: from ozlabs.org ([203.11.71.1]:39271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfEGVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:36:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zCbD28fWz9s3q;
        Wed,  8 May 2019 07:36:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557264968;
        bh=tb9GjKBefLC68buu0ZP3CkcNEN6eSxLqcZt9NFsVeAU=;
        h=Date:From:To:Cc:Subject:From;
        b=HnxhJAi/iCwIx/uD7GjkvbaqEee+aDCmIgKo1m5lRodIgMKs+ghkP28kDrmdADFaJ
         MeQ2oo+F5I/EKe9J8T+l+zGQu65ELxUnZZfP7Zf3q1q+f9/RZljbwHB3E4K5g3pGNt
         9jU9VErGvL0ph4pxjeeQ0j8OD8dByZa9QVpDnYUXxQhsxfZrSI/hkBpIZ2t5MGGm7U
         i4B0EzPqU2+epaNFe7ZNJAuZB2h0Lqc9yRNRbK5APVSZ0p4tVxg8ZZAjC4rbdT2sb7
         WqnNNuBml6kdZO4MYEnjr1CkRaemgsGdKtnTTcuVXWO96t7tiqri4AShOsp18qnhSs
         Ae3bqQgmjL5dw==
Date:   Wed, 8 May 2019 07:36:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20190508073607.2bb5c870@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fOFzKGWSl6cCw7n/_36h_Tq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fOFzKGWSl6cCw7n/_36h_Tq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  467c82b82836 ("gfs2: clean_journal improperly set sd_log_flush_head")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/fOFzKGWSl6cCw7n/_36h_Tq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzR+kcACgkQAVBC80lX
0GzfUwf+L7xTgNvDSsSIg/wO+aMYwx0+jBs3e9QNOnlT9Dn2H7qWYqpFVftgFVBN
c3TpZIe+vy4PRBzNv06P8V8cCeOP3cLhFEw+46WzgKy8eqJyOhyMwdlV+bMWdli9
UyB8mySsFfyh/3MEjX1j8XGhFMqb9jO+FPfKZDWgp0QZ2FYE+NDWjpFMRrwEXfXf
6hugGY8t/NRIMCr0lBnpMwZQYDoaTMOXvYaGkQmTAkhYW4429nMrFV8QB6nlsIOZ
H4pSU+Pwa9xu/l2oEZXH661qwnOkQzkUrtBilMYDCZ+bujzYVZvQYZ4hjEXt+8Aq
CfMWxGe3F0nZ/bCAHbVps9iX3DSb9Q==
=TIuO
-----END PGP SIGNATURE-----

--Sig_/fOFzKGWSl6cCw7n/_36h_Tq--
