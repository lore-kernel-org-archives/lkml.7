Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4A8263A1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O4q6coGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfEaDzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:55:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59293 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfEaDzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:55:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FVwR5Q9hz9sMM;
        Fri, 31 May 2019 13:55:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559274936;
        bh=WnJUe+4OzIfxQ+ASOkfghdjn8sCpv3/mIHffHIDJsQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4q6coGNwvuJX5mCdM6xpXznZhr089KKtaYqvROaO7VNhAejR8PvT1VjYOYRO0kPq
         2Nl+6Ykywh8zN1j/nLRYI6EwPMGeEpMJFPwUzZulGzWbA3bZ13XsleXoJrvRcg53KQ
         z0ZGJKKEYHahTxxofdIKEKisgEkl+6F1p51smHN8aWUE0rSS5wNVAzYOFkI/wsja3e
         ky5DVqhxMkMdzwGxZ1AqhwVHeiQTCT7to4jPRofmtZcYq+C3+8ZAj6TmApvVpd9bYS
         xQPFU7Bub6JiAizc9YtxZQqGTIXBAWeRECiFUjtuLKPTvXaZQ2F38pNZO7c3VwOhqw
         nQJjIwKBaVMSw==
Date:   Fri, 31 May 2019 13:55:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: linux-next: manual merge of the userns tree with the
 arc-current tree
Message-ID: <20190531135534.350dbf57@canb.auug.org.au>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2520902@us01wembx1.internal.synopsys.com>
References: <20190530131721.0af603a4@canb.auug.org.au>
        <C2D7FE5348E1B147BCA15975FBA2307501A2520902@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Iel2uKWbKzZVD/3RL+cnIU/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

On Thu, 30 May 2019 17:11:33 +0000 Vineet Gupta <Vineet.Gupta1@synopsys.com=
> wrote:
>
> Thx for this. Unfortunately I had to force push my for-next due to broken=
 #7 and
> #8 above. So you may have to do this once again.

Thanks for the heads up, but "git rerere" seems to have still coped, so
its all good.

--=20
Cheers,
Stephen Rothwell

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwpbYACgkQAVBC80lX
0GzYwwf+K7OLwYYZVhBTOJsBx7ulEkvkKcyEg/2GlTiYix6EC+dLiy7gXUbOH9UN
zWX2sWWGjgNCnRmXMWhEU72M0b8joL6Md5YNnDN2aSg7qK3Go5m1xIUQRQMPgM2M
BHEeDHDUrYQ3CUF3ILKZvC7pL7xt657ouKy+WyF0ynlT32EQHMPSR+bwvdsIQX/m
fWJRe3OnyD00buchCeNwo4kyL6vEt8aH08+t+p3nUkGwZ323lyWeUo9pwmCq683e
K4KDYVlWd7mg3N7bvkBhU0bgGSH+rpzePYvk1+QHEoCSAnvDw9sovFl714yMjanV
/8f+dMBd/3iGGrjsrqc3KQwUjYqfWw==
=fIvj
-----END PGP SIGNATURE-----

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/--
