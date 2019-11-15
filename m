Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F057206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p6D2DUoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKOEgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:36:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOEga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:36:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Dlt46Xdsz9sPK;
        Fri, 15 Nov 2019 15:36:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573792589;
        bh=oGJG6CibNn1LIfFqvAz8jRajFEACP07geZMp2/GkYqs=;
        h=Date:From:To:Cc:Subject:From;
        b=p6D2DUojurHcCjaCI+NAN1rb3KTod1JkNMfDwEezxlfAycM/Cz1Li6/ZaMuq5LTYO
         R63uVh2MTznv0CLrNNDRwEU0UgccPeBesehevzcfOrw9ABfEjx0ZCaTh60yuDgqUoM
         ZVjOdoeeF7PQQsUvzbxfcsXee1dD5Idy7+CCGW+85ZCqI0KQ9qpsYxjFOChI+z+2OZ
         gNuql/GdINJJG/98yz+pucFOhFX4VKqjdji+sMNv/eybzwnhjXd9oHh0FkgjdXQA+m
         ZafnBU1j/8bNYX7+0iCyna/TBm+OHmfIOywe0NsnoX4ObSSuKXmJs8HSdXJQo4rHjE
         /2eai5pwQCrag==
Date:   Fri, 15 Nov 2019 15:36:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20191115153628.62214e42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GTepAnVWKI5MsEM2dZKk+uo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GTepAnVWKI5MsEM2dZKk+uo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/vhost/vhost.c: In function 'fetch_buf_packed':
drivers/vhost/vhost.c:2568:1: warning: no return statement in function retu=
rning non-void [-Wreturn-type]
 2568 | }
      | ^

Introduced by commit

  b65f969494e9 ("vhost: partial infrastructure for vhost")

--=20
Cheers,
Stephen Rothwell

--Sig_/GTepAnVWKI5MsEM2dZKk+uo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3OK0wACgkQAVBC80lX
0Gy5uwf+IDnPpdhyUifv74A6j76Kmvya00rB4AjeIanhmSDNpev++UgK8R822VO2
FNuYebln74PgZ1Wi3fjN6IP1ngS/SsL/rcwE+aUUUGYvJ3PY5ED/U9Ll4HaTALbO
mJOhPp22bt6F05ak7GbDnXSYvUq/0dLHNOOGirZWlhI2xizRM53esdKV5NkVar6p
3fMkV6skzPQM+lKWx1Z/j7yhabVOQP9IslgfeXqzozD7QnAv74aEY9dEG1973Et5
+wjrvF6KZOQsIoCV7ZiNTCtWPhtrE6U41zjzMwySe01iV11CAWdgal13f85Oa1GA
cSbA6y31qmPY92/eScy3sscUy/wc6w==
=5ZGK
-----END PGP SIGNATURE-----

--Sig_/GTepAnVWKI5MsEM2dZKk+uo--
