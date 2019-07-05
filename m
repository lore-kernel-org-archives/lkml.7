Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FEC4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749F2089C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PLSNupLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfGEKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:18:45 -0400
Received: from ozlabs.org ([203.11.71.1]:54275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGEKSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:18:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g9mK4qxCz9sP7;
        Fri,  5 Jul 2019 20:18:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562321922;
        bh=yKxB6uT5X93JIEddRU7+mwI4BC3Qt2b5R7HLoCn+R3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLSNupLJQxnniWEaMgxcMZsE3lkp4jzWcnqCWWq0C4vWu4MufAiqVPFwIVp31SDP+
         OrePJMXlokdXMpcCCdO0vCk6mIl/Nx5kDTZa/CC0dJnvJMbY6KOhavdBdMLNZwIJuY
         rbAbxAMbqKh4qoBgo42SZwJfbWKhKlm5syFPghhly8PBjy0reUXjG855jlr49x2cVX
         imr12Iqa4oYS+CmjjjSlhhUD5k9ZHgnkoQYODbMMiqBjxghRbQWQq2nqwinOGNQRIZ
         +UJgnGiWjIpu9GOtN08+bLWdHrYH89Pl4ycQDTHvzRdwIConfk6jGdkNy575r+JZVg
         vLQzchKzsHFDg==
Date:   Fri, 5 Jul 2019 20:18:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190705201839.16001905@canb.auug.org.au>
In-Reply-To: <CANpmjNN-BYeiKk+S3sK6joknC1dnxUUgCqUPFCJuiYd2xVHWPg@mail.gmail.com>
References: <20190705184949.13cdd021@canb.auug.org.au>
        <CANpmjNN-BYeiKk+S3sK6joknC1dnxUUgCqUPFCJuiYd2xVHWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ApwHSZZKl8L5b=H1VGvZKpJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ApwHSZZKl8L5b=H1VGvZKpJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, 5 Jul 2019 11:27:58 +0200 Marco Elver <elver@google.com> wrote:
>
> Apologies for the breakage -- thanks for the fix! Shall I send a v+1
> or will your patch persist?

I assume Andrew will grab it and squash it into the original patch
before sending it to Linus.

--=20
Cheers,
Stephen Rothwell

--Sig_/ApwHSZZKl8L5b=H1VGvZKpJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fI/8ACgkQAVBC80lX
0Gw6SQf/bpuEgoxGldMVFMYH/XdJSyDKOtxdZYdY8BPRxKXXCALhU36xt9+VN5AK
/YV9378TdkkPV7MX3Uq05bDqqxBCKJrr3WfpLEr0dus4X5dbTJ9pNNlk6D7f2bD4
6FNERszdCg8i/g3hkL97TsPxsWfYUfXDAjeYNq1pcM+4sY89n3mcCQix0I7dHzlv
TCVn6w6LTK8fdhu1eJg/mU2GB5nE4vyWWsvSO1vKUt1nGJSt0jQ0GFuFZwBNSiCf
+MPvKGNbqkxTT46JIBIBk+0Bk9lyY2VpnC91L2ALa6Tpgtcqo7Z2dPvjLM/6ExP9
uYVYEGhQLAdIk9ic8mK8c7/ogYBEQQ==
=CpLo
-----END PGP SIGNATURE-----

--Sig_/ApwHSZZKl8L5b=H1VGvZKpJ--
