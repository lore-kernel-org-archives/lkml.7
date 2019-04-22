Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85943C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B4C2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KSjmc9Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfDVVWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:22:41 -0400
Received: from ozlabs.org ([203.11.71.1]:48399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfDVVWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:22:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p00X6wr0z9s5c;
        Tue, 23 Apr 2019 07:22:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555968157;
        bh=PJeKf7xGmED762gbYGWlVqrwgiXCFDvXx/Es1Bu5P6k=;
        h=Date:From:To:Cc:Subject:From;
        b=KSjmc9ZwJ0QqUF5YpFcWRMHRIHMcQyCAGyfwnW1KkDevk0nqzg+5pB8UTKSUxCqo3
         JfRLGWy7YMFLElZnk/VtgGIHtEMsmUb1+cS+dAEf11XcfIpxjA1r4bgU9uZTOlXJms
         UJy44KzLFgjRhw3LgrolwqFMwNgF3rKTF4lQ10G0KOSCi2c0WsUOhe5mjeDhOquBJC
         vZFhAIIJ8wRqq4wHXQJdDjJFXroAWkM3KpnKR4TfMr0rlLRkApFAvPi4NsOb5Bjlgz
         aeeWus/js0lOI3lWrgzSlmhRoLf+gv4ib8t/tW1KcQZ9Yxs6gOcXs1UWye6gwPb0Bg
         F7ct2aDD5WlGg==
Date:   Tue, 23 Apr 2019 07:22:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190423072235.254434f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xutuPEP+=kfBtEDtddQ.6lV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xutuPEP+=kfBtEDtddQ.6lV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

In commit

  dad7e270ba71 ("media: vivid: use vfree() instead of kfree() for dev->bitm=
ap_cap")

Fixes tag

  Fixes: ef834f7836ec0 ("[media] vivid: add the video capture and output

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags across more than one line.  Also, keep
all the tags on one group.

--=20
Cheers,
Stephen Rothwell

--Sig_/xutuPEP+=kfBtEDtddQ.6lV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+MJsACgkQAVBC80lX
0Gz3sggAokEEQEbskUc6XRjgfq5/rr0Q7mQK0/3Q+OlKjLMjPApQretWRU7QJSku
zMHTck02nK0zwxIyByZEjhfRZFZBZODg7EKuj1CjtZwoc8gWBEchZma/zHFfLRmM
3I4/Ei8ioGu5y7nSwSEg/AQjhB+IItjy4F34C4os7KtWcm13+uC/GGrGxKslXhjC
FncPe+zICgLUfWxunon0DAm5lzHoNF8xHL4zyO305MPdPUclCpDGQYX3QsaWtO3Q
ulagWHC9lJtGK2du4C3vE+dNpow/stEM3XTCkFwnJy2SAszznA5KjF5VLo56zIOO
tM5vaTzihyAOyuJf9qwws1pqFNJB/w==
=Qd0J
-----END PGP SIGNATURE-----

--Sig_/xutuPEP+=kfBtEDtddQ.6lV--
