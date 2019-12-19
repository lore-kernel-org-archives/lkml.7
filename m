Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E97C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21100227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576773689;
	bh=qejQAHskynvERXs2mQnFZfJZmbAprTXsUbB4QtkwTkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwEm4mylrYSKlxeY6o3+oROfRlB8RVWB5I4+5nypJHwWlV8JytCBkVwl65LZT7NjL
	 +4hziOFtCB7tMdWKwMjsgHMWlhA5xnVFj7d4MKxNFQuIEwGa38e80G7BPAJksHqdOB
	 u5k95WHr1uF/gBLmmrWaLfgA74cT1zeLqGZlnHME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLSQl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:41:28 -0500
Received: from foss.arm.com ([217.140.110.172]:40896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:41:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7723F1FB;
        Thu, 19 Dec 2019 08:41:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E79573F718;
        Thu, 19 Dec 2019 08:41:26 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:41:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "wuxu.wu" <wuxu.wu@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
Subject: Re: [PATCH]    spi: spi-dw: Add lock protect dw_spi rx/tx to
 prevent concurrent calls
Message-ID: <20191219164125.GG5047@sirena.org.uk>
References: <1576767380-12947-1-git-send-email-wuxu.wu@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <1576767380-12947-1-git-send-email-wuxu.wu@huawei.com>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 10:56:20PM +0800, wuxu.wu wrote:

> 	[ 1025.321405]  default_idle_call+0x30/0x4c
> 	[ 1025.321415]  do_idle+0x22c/0x300
> 	[ 1025.321417]  cpu_startup_entry+0x28/0x30
> 	[ 1025.321426]  secondary_start_kernel+0x17c/0x1c8
> ---
>  drivers/spi/spi-dw.c | 17 ++++++++++++++---
>  drivers/spi/spi-dw.h |  1 +

You haven't provided a signoff so I can't do anything with this, see
submitting-patches.rst for details on what this is and why it is
essential.  That also has some other information on formatting
submissions.

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl37qDQACgkQJNaLcl1U
h9AJaAf/VcHw+FsWnYuqSH2qZ99vzwAVGSKy0z4tlu31qUpDCG9ck7/2ZIjbLjfC
9oJH30f+UFJ+8FbtWqkjqlQKlWfEsvJb1u6t3/MT2id0izMJhZmNEL2rejzJN9mJ
er+nAY71b7qSiGFeZIJ4WfDisQ5PN13Bb8Jc89xX81/AhXeeWQD+nzSim1oTkC51
nL6yv7348KLjmfxjWh/RDRpMGjnB36NqDElOS5JFleqrBj5VpYGgCaPAAYHiUByO
fRk//M+nrGRqaYxQ6ux4KQjsnMURsAiI1eC1FsZ+qR6WBXFIyiWy2DfF7YnnWGuO
XxFimsqORIFr+lhUPeBOxQjQ4XHnVw==
=Xr2v
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
