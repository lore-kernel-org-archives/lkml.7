Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD36C606D6
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423B21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZFIIPPZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGIGxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:53:53 -0400
Received: from ozlabs.org ([203.11.71.1]:33353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfGIGxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:53:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jY264Mbhz9s3l;
        Tue,  9 Jul 2019 16:53:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562655230;
        bh=DI4bCwHHkfCO/hXbU+RDgdPwAqtIvDPn9+w3+ut5BG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFIIPPZZfpiYiUdsT0JJWMkPihOi3e/q2VBtsL12fZwszeRNRdiOMredry7mNdb3W
         6is2HuSoRuatL0VgERiH56uX0SmuTA5u0OdYytPyTb6dRXxSkAN8a05qutOW0e0Z79
         2ZYsbNGcN31ZHn4e8j2uR16mCPm7rmp7URLRsQ22AEM+cFLowDvCedkB5OljlVaKfc
         qQ41pAD4CaAQArf09uJnPS1jTq2lv2il8WmkyMTANy46c06+dkIg7blaa7ggt2TWFk
         wK8EOFA02HJKzgB7uLe74ePbsJrJkTKRX8DEOzohJYkUNAWZmy65g3VGjAfNOO8ox+
         O2iQHtSVreLDQ==
Date:   Tue, 9 Jul 2019 16:53:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190709165350.05a3ada5@canb.auug.org.au>
In-Reply-To: <20190709063510.GB10587@kroah.com>
References: <20190624171229.6415ca4f@canb.auug.org.au>
        <20190624073443.GA13830@kroah.com>
        <20190624174729.327f2edf@canb.auug.org.au>
        <20190709095833.727ac5e8@canb.auug.org.au>
        <20190709063510.GB10587@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R=e2cnqPPLnbYVVBNTfMvaZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R=e2cnqPPLnbYVVBNTfMvaZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 9 Jul 2019 08:35:10 +0200 Greg KH <greg@kroah.com> wrote:
>
> For a merge issue like this, I think he can handle it :)

Yeah, I nearly didn't send the reminder at all, but I was on a
roll ... ;-)
--=20
Cheers,
Stephen Rothwell

--Sig_/R=e2cnqPPLnbYVVBNTfMvaZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kOf4ACgkQAVBC80lX
0GwwNAf/a8dsPtn1/PCUWwfampzIJ3Z/Zmzg7Lpp8HrC68IWdTVE/05kZKfxbS7v
q7nV3vVOxi410XC69mmRqu3SAiy+89dodeLjyiSPR5T00HcNY58RJ40sYb2BQ2pj
dBB2U7v+sJ5lFzvfrTiRUe94eLCEcZ+gHiHM69P/ZjCQ4ZmaGQ2YtMIO+mdTpxoN
ZThEsYWt+E387wunHMaXJDbcMe4/h0/PjL6uJFbVm3OvXdiHbmHYtHVnYyWX0fx+
GAz398GI1etXSyAHYoIAFcsh0eGSA2W4vDqH/UK73KgHpTOVMYIUg+emxzT3Dftj
2I79ilwUJtX4iwH3VnIgTFBc8CtKEg==
=pO0M
-----END PGP SIGNATURE-----

--Sig_/R=e2cnqPPLnbYVVBNTfMvaZ--
