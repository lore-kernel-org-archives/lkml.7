Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5714A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aze9tn+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393589AbfJXUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:07:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfJXUHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:07:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46zdZD6WVhz9sPc;
        Fri, 25 Oct 2019 07:07:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571947637;
        bh=abcaayidn+3toY5zYpXOQ0+ia5DvFmIc7L6o/CHBKIY=;
        h=Date:From:To:Cc:Subject:From;
        b=Aze9tn+qq0ipY0jxRykO0MkfAcpLaZ3d/RE6HdZ0msK5pbVQ/PeJP9JUlAq2AaJgD
         UcNv0S4i5Nqu75oqUSYoxk0/z9NMRZvzd6YYFOjSFwpj5QJSk7/PYNgx2x7m5Jrlq/
         HpC3HmEfcr61FiG2vlYhRg/qkorI/IS4BOrToAnHiyXmntj++kDNUgykuJuPEesJD9
         hgJly2ce17YC/Oice7bov/3tsxJUnF0Wzeqgz5YerkjAsvmpa0KlFeKb/ArNSnZAD/
         zCh33w+DJb3n+3rW3jhrmfxVoIN+TmYcvmv+lxkfqeAS6+BWctjn/+RfPHjBzU3a4h
         8hu6dshjM+aFw==
Date:   Fri, 25 Oct 2019 07:07:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@st.com>
Subject: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20191025070715.10f79307@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IvknfjqaUKHnHRXU+H_Sbg7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IvknfjqaUKHnHRXU+H_Sbg7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  969f95fc9007 ("i2c: i2c-stm32f7: rework slave_id allocation")

Fixes tag

  Fixes: 60d609f3 ("i2c: i2c-stm32f7: Add slave support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/IvknfjqaUKHnHRXU+H_Sbg7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2yBHMACgkQAVBC80lX
0GzjlQgAjJ2S93P64NIpiRvCNJhB/k+XH5WfRUq8hFP+UjJb6ZfbCl8HQwZoyBs0
1fnmXfM/eeYEeSnPOoZ4zsI5rbhO8+PZ8ERiSmI2BitoxgYgkFhxjd1PupqmDRu6
YAgeSrtCTASoQDKznH+ZKkOwiDAVD5FmawfVRyFQrAE0y4owBq0Nbvxdodjq4BHK
UXeprJ9TJoF94eqTMOsyyClpTb5H9AyoQaYTFbU/enZUryp/ay/EquRhHJIo99Oe
ckw6ZBIqlaMKayz/EHPY6GVQNst1OxJh2WDYnhSN3WkJZ27RX3BI46Ft5fMy0Z/j
OzXD9IqAn6rep+XaB39V+gA5Dt1zsA==
=1z2M
-----END PGP SIGNATURE-----

--Sig_/IvknfjqaUKHnHRXU+H_Sbg7--
