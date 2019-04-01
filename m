Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E877C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD474206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104353;
	bh=kawR6APwKWaBEDYLBTsgaG6+vxQfZ81k4C9Wh68fCTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9e+vKFB9E6q0PQaDJAGp5TXc0GRnAIdyzGMrc4HYrcHl3IOqvqwvIx+wXaGVCWKt
	 zewow0aIxcff3IQnTx0Zk5CZMtbtwDQnt3KJYg+FOTIxWEsBnxPVh+gXtHSfcm+Gvu
	 otFc02yYm7wvp/BhQB8c2XwrocnhcZxT0uA7YcKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfDAHjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:39:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfDAHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kawR6APwKWaBEDYLBTsgaG6+vxQfZ81k4C9Wh68fCTE=; b=iMEX1+NcIdmACWIkPmKdrb4FU
        LDxkU9maQomPsDNpqD9lw+GLI24L9Qkq87XreZDK8WweA7LbbPzIX1mdB0DVZP1XrTEL6adeoQMz1
        vAhl/AUmK29rjNU31jk5Hplsiqk6MuV+dcHF1GT6bH8oF0t2AKQS10RYTjyIlurCgxOJc=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArX8-00087c-Lb; Mon, 01 Apr 2019 07:39:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 77209440082; Mon,  1 Apr 2019 08:39:03 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:39:03 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per
 word
Message-ID: <20190401073903.GI2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:25PM -0700, Sowjanya Komatineni wrote:
> Fixes: Use packed mode for 32 bits per word transfers to increase
> performance as each packet is a full 32-bit word.

This is an optimization rather than a bug fix, ideally it should be
later in the series to make things easier to apply as fixes for Linus.

Also the way you're writing your commit logs with "Fixes: " at the start
is really weird and conflicts a bit with the Fixes: tag that the kernel
uses to reference the commit that introduces bugs.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwBYACgkQJNaLcl1U
h9DaaQf+NXROFWr5AFvVPLbpW7f/J6KJiM76ul1XdboF3IaYgAkH4A6MEfuajBp4
bCF7dZOF/CiH2b1LrwCUHBaSGTLCtHhUbdUSfUbxQgTjAaHCmygE0cAivGQ6wpzd
dpGvcKo9UGv6Ag0v9DUovyKBIl38glZeLCPylhBcaWFgDIRa1yp3Kn2NjBcaAIW6
ot8ckX9369F9gholM95+ebQo9z0nAUXpFh/0XhCzzxq2ciYKgrOJhZO96fRkss34
4oPMnJdAZu6fA1nwxqtOGvYkOejTqYBjQVF1NqKKW85PWNWvm891HjK/0ZfykZvR
B8XQySffhao0UMVkUuwYHI8H0qWcGQ==
=qRHc
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
