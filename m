Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F60C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9931206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KWfxRLwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfG2MUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:20:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfG2MUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:20:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xzL76qMgz9s7T;
        Mon, 29 Jul 2019 22:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564402848;
        bh=3ZkE3Wh5jiD52ViBI3ydmbVsv7nbSViohUmvTLpbK70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KWfxRLwMNOziGpWS6BoNYIOFdG/0wx8TN+5p2DFAZJ0yBReJYDTgOYdDgW3P82Qcc
         MC8cQo+h4DZJ/EsAc3f/6m39bl881hwKgkervD4W41jonANn+rQUaNKI2SuhCmHAWn
         NqXGuM8tBdJntI3LQ+CSEYkpDQMTHXbLwT1Pusgs16ovgQ0iV/jOCNBQt/Gw7uzu05
         kHvBIoRAs4E09TbJODyukwcBd3vXrgpP/5s8U0MbwWutQUj9zbTSU3RygqIeDtvlbd
         JgQEZr1H3odoftAwmqgfw2unfVC5U59siY9i1uZ+mRT4uXX5hJ7nogLy7fI4Tz48R2
         kySap4hjMXHnw==
Date:   Mon, 29 Jul 2019 22:20:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Denis Efremov <efremov@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] modpost: check for static EXPORT_SYMBOL* functions
Message-ID: <20190729222045.4b491ffb@canb.auug.org.au>
In-Reply-To: <20190729092250.32670-1-efremov@linux.com>
References: <20190714152817.24693-1-efremov@linux.com>
        <20190729092250.32670-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ak=QLX=2NJUyzZgETBpXpbk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ak=QLX=2NJUyzZgETBpXpbk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Just a small note (nit? :-)):

On Mon, 29 Jul 2019 12:22:50 +0300 Denis Efremov <efremov@linux.com> wrote:
>
> +			if (s->is_static)
> +				warn("\"%s\" [%s] is the static %s\n",

This read a little wrong to me, maybe "is a static"?

--=20
Cheers,
Stephen Rothwell

--Sig_/Ak=QLX=2NJUyzZgETBpXpbk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+5J0ACgkQAVBC80lX
0GxG5wgApfJ4ZYIP4/nrvt1ZpHnsVu8rZOSuHQBxLepKCgo2wcYPrgDfSyyhrsYR
qK3mVW9IjuHCqRbbjoPQMzrHREdO11fIOvrGQyDNHE2FkUdkd1tr2SnBQmNov6LO
VtsyfEl6Iubq0Fv4RCALpas0lkdww7oz5fFIi10E51wX24p3q0OWLNJo3/6bsATi
XRuaH5VJ94fbWODxfQQeLpab+20pQABFUZQPM81pWG1jDHhod4IkCz1sJM/TC4IP
oOPhA9mBh/Pd8B9i88Mxcy1Jk62bkM7f1VG/lUHyY7hV8yTRHPlcGaHUgw2ye2XF
GiYlOFlRCmQKIpL1dt1JBY5kC286rw==
=Axup
-----END PGP SIGNATURE-----

--Sig_/Ak=QLX=2NJUyzZgETBpXpbk--
