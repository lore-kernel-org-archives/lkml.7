Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E641C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BA12168B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QIc649EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEPDce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 23:32:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36211 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEPDce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:32:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 454H6l0x2gz9sD4;
        Thu, 16 May 2019 13:32:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557977551;
        bh=eXMkfz/CLjFGvFTaRIFOOX1mVuffZ5U7dhSjW2XmU+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIc649EZnPUDpoWccRMZ7kSw9dcYb16VzpRfUh2t59C/C1GGLIoOPF6OhUTAcuFfG
         fa6cpFAgqxedhmyNY1GtvBMwn1Wp3O8bUGv2ExMXHR/fsBruP3E4XScdnCnuDGZVNa
         idpA2sNIkxZMzkjDwkA5SAAIEzQNfV6M/JU5cuCbn1NvQb1rBnbbRc44yiv+TZ2HMz
         wP2e5aq7+iqG+5YKCawGBc20aMOR/DYmLrBYVE1N2sAlp9V6xwPsk8FUJkw9yh6DAF
         xGdkT2u87McvcU6GS6oDQ2jJ4q1wDSgxtN9rqw7G9z6y24kCd9W0L+mvK8l4UZwLHZ
         6ciULfzP8yDPA==
Date:   Thu, 16 May 2019 13:32:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20190516133230.0c894ebf@canb.auug.org.au>
In-Reply-To: <20190515215305.78e8ef4c@oasis.local.home>
References: <20190516110548.0d22d048@canb.auug.org.au>
        <20190515215305.78e8ef4c@oasis.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WGhoO1LbIMcdcEdyFWibU2."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WGhoO1LbIMcdcEdyFWibU2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Wed, 15 May 2019 21:53:05 -0400 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> I mentioned this conflict and the entry_64.S one to Linus when
> submitting my pull request. I fixed it up too in my ftrace/conflicts
> branch.

And he has merged your branch now, so all good.

--=20
Cheers,
Stephen Rothwell

--Sig_/WGhoO1LbIMcdcEdyFWibU2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzc2c4ACgkQAVBC80lX
0Gw8IwgAiRDBQhYFblBSXJd1CdE7An9kwugAGX+Ni1zoYKIkx0rMzleh0jTPJzRO
Clwbu+b/yu72fG445AcwUh/re+3coQl9jXuzt8mv9H8WaTSfDA+1lJwQQIESi6Tc
f23tmpby0/lNQot2e803/chuvbH9v+MkZziMVVJjjvIxARYYJeiVIEPuGyhHlFbM
u//B1OZINLtROYAad3f4OvDmrJ1CwHPXojvCR55uBpQj6Fry18V7tpdOILo4Uw1D
h8sC9RL+k8/9pOwiEtclshEBxRRVP3Puv0TE4EvzUa+qVPT7hYm9lqKY5AAiGsAg
hRNNvHdK7ytEHMzheHKprjUaPegTnA==
=UAnV
-----END PGP SIGNATURE-----

--Sig_/WGhoO1LbIMcdcEdyFWibU2.--
