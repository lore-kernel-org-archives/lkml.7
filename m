Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68440CA0EB6
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F4621A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XDq75Z9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441674AbfJQWaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:30:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbfJQWaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:30:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46vP4x0vf9z9sP7;
        Fri, 18 Oct 2019 09:30:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571351443;
        bh=gWZ6IJlpHLTmWC+BDW+fZ7us47aq7v9k8WFDYopRuNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XDq75Z9Ucr/gdbUn5yctbuy4IZ+1ccQWlDGVLRMJJ1tOLvnP8Ev8yAqYLSo6HAJih
         aLjnDKYiSro1nbOCTmSB7YuyszJstQWU6VMkXwgD+jvCCGXHF6eo3UASHytqhKyseW
         Xla4hb5Gt/VqXztOFi2pUsQeXpuZLXSUXkADawu/lYT/SGa1COBrezI4prkM1uw36A
         PI35LVNiqaVegh7B8u2+XMTKqcLOIFDfe4r81I7s2FwN2kC/TKqhmKLrU5cZNSE2JC
         NSDH45cAe+v4C+mGegi6w+pVfyXy6hzYOkgcOMY54cIq/kYOa545apdPFYc/KL7Q83
         evBG9YNOsonPw==
Date:   Fri, 18 Oct 2019 09:30:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        xlpang@linux.alibaba.com, zhiche.yy@alibaba-inc.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: add checks for fixes tags
Message-ID: <20191018093039.7da88088@canb.auug.org.au>
In-Reply-To: <20191017123701.45562-1-wenyang@linux.alibaba.com>
References: <20191017123701.45562-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rlUNz3Rw3CnN14kkOXxP8_e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rlUNz3Rw3CnN14kkOXxP8_e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Wen,

On Thu, 17 Oct 2019 20:37:01 +0800 Wen Yang <wenyang@linux.alibaba.com> wro=
te:
>
> SHA1 should be at least 12 digits long, as suggested
> by Stephen:
> Https://lkml.org/lkml/2019/9/10/626
> Https://lkml.org/lkml/2019/7/10/304

This should apply to any reference to a commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/rlUNz3Rw3CnN14kkOXxP8_e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2o648ACgkQAVBC80lX
0GwOpwf9FcrL2YI/N8hyN/mQi/WpZ0RdUma9NEUitglrET1EEhYU+uPdbsqByOGZ
nBV9hXyQMgzbXKRo/+TzzoEE0wSzh01WP6VRi0MlChVSRKlxUeQq4DYogXPnoPp8
+WZOmshlq6wBlOi+kYl2oFUq6y7kMdaWDUojzWJ0BIASgPBLLBgwgOHNuyVui+t5
eysIHy5rFvUZpBePfoD7hqSp8jIf0/JuMpwkn9igXKUarM/r5z1p6jsVlxAJX7Oo
1cWIr9iSypeWeE+cOX4EvRE6PEGkysO1BcLGPLEzT5MOjqUN+KuGUPiZ9ea6COAp
3WETTtA05Vx416fVYpE9UGjibdBCGQ==
=Q2nO
-----END PGP SIGNATURE-----

--Sig_/rlUNz3Rw3CnN14kkOXxP8_e--
