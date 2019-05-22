Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B6C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662BD217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nI2nqIhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfEVHsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:48:45 -0400
Received: from ozlabs.org ([203.11.71.1]:34805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfEVHsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:48:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4584WY4Rrnz9s6w;
        Wed, 22 May 2019 17:48:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558511322;
        bh=TuZ9NVlBYOOA0MoB3qMJofvJa3RIuTnzGFA8ICtVWVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nI2nqIhThg2UHDDsoFD2x7fy7OET3ebPz4yL7Uo5LKh2zL49FxQVmq5Pbg9r1Xz58
         PNoBQL4LVAoc81bQ6YzSAf18VCrt90fqY9yoi4Vdk0IZR1OvqcNgzGezdNX2uAKifN
         xZWdYj42nmhtAGRdNgp7fl4IxZFYkgqg5Amo/Dal039JmUt/D4mcCu74Kp3e9XkENn
         iPFw38GXY3KQejdx4io0BmVC3MJ1PPkctK3GgWm2WPXjAgv9cuc4ZYlb7hmk1h3iUh
         z0CEIadD6kO54z9WAOok+nIZwf3KQD2ynzjw6Es30QxjljuxT7DY8fIvIAJVk2Q1nd
         Iv3BVwyZw/IIA==
Date:   Wed, 22 May 2019 17:48:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190522174725.6bfd51bd@canb.auug.org.au>
In-Reply-To: <20190522055235.GC13702@kroah.com>
References: <20190522110115.7350be3e@canb.auug.org.au>
        <20190522055235.GC13702@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lvAN8G0u2K3BD/3rFho2.e2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lvAN8G0u2K3BD/3rFho2.e2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 22 May 2019 07:52:35 +0200 Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
>
> Sorry, you are going to get a number of these types of minor conflicts
> now.  That's the problem of touching thousands of files :(

Yeah, I expected that one I saw the commits.  At least is is just after
-rc1, hopefully most maintainers will start their -next branches after
today :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/lvAN8G0u2K3BD/3rFho2.e2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzk/tEACgkQAVBC80lX
0Gytgwf/bM3rn1I53Z1gozufwkAcj4PNOkJZ+4AxQXyFSR5FeznDmcWBByYIjOmW
7KgoP5dudN5bYcOfhgugtORTjJu54x3P3iSgdDYzoZRvK0Sk8irR/SlfoBd8Brsc
iiqBXBicqQQGrus+zTLdtHvr7bXbX0weTxCUV4Xj91jUSa6oD9f+JskwuvGCV1zt
fxmo+N8BTmPFZ79PjTKkZR+nAZacDm34fEKBlIIJvrpjpG5BYKlFNwf6c5Q89vb7
lq3DAnLISW/gZ6QfEWMMdczQ24qvrLxZm6LApOLZ1KxMy+SNzTT/i9ejIqvITJxD
dm7z1TtvrBzveZnAGVWiXDpbDTJk/w==
=MWyJ
-----END PGP SIGNATURE-----

--Sig_/lvAN8G0u2K3BD/3rFho2.e2--
