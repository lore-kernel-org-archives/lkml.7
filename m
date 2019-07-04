Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB4C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E810218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H7FHmBvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGDHb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:31:28 -0400
Received: from ozlabs.org ([203.11.71.1]:40375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDHb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:31:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fV5m4gPFz9sNw;
        Thu,  4 Jul 2019 17:31:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562225485;
        bh=q87gVoKRcRIAQlzi5EChTZT/OGMlSSIYaWdvi4yp0Oc=;
        h=Date:From:To:Cc:Subject:From;
        b=H7FHmBvQcjDN7fUVtIu2uORseFAX4zI2YtNQlX1wNoSWwmC/Y+6rRv21S+7tNMox1
         UQ1oOcIWAPeYHhUZ2t8hWtyYtYJIMFBKBiiNTOKItT3bCuvR+9rcZkPJvgAEOwrTEc
         YPbSwcUnSMPqcFsTIUMs2ieil7TgdKl+pC0B6iL+nvTCvcNXkUmOvetnL5nlg8/jXN
         jJJ3Q1+0l0qbcbY6ySl+41cA1NDWMSp35/CNN8CKpRaFQtl5RiZ9fIWzebMxtaf3pI
         HPm1pHVVnuXxQIWmGfeB/BN+Jkg1OzNVxmbT8D8I+tYFuCYqf+BAonmjcGiXh/udpx
         fUt1Bq/3hoGaQ==
Date:   Thu, 4 Jul 2019 17:31:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Angelo Dureghello <angelo@sysam.it>
Subject: linux-next: build failure after merge of the slave-dma tree
Message-ID: <20190704173108.0646eef8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5Uwy=RftkHFD=8Kb.kRS_pm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Uwy=RftkHFD=8Kb.kRS_pm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slave-dma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "of_irq_count" [drivers/dma/fsl-edma.ko] undefined!

Caused by commit

  7144afd025b2 ("dmaengine: fsl-edma: add i.mx7ulp edma2 version support")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5Uwy=RftkHFD=8Kb.kRS_pm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dq0MACgkQAVBC80lX
0Gw25QgAlkBcHoKNDsts7uDCb+TIb/+BTdKtIPSjqP0frXooQBUCE+IN3vuiyNXi
ueJo3wEhJEdptdWnQ9AqlePIFPq+oxoozy19K40EvoJT+NTyvSGaN2q+PEwnis6J
ONWpVklgmsajuI0QNBV/oeo5xytChtDKXSgq/bnn1Jvbeyi3OnDijrmJBpJF/vEB
fuT72XdhNTnDRFFL0erV8kS2Pon/WOSNJSL6C5qY0NVOrU8H6nmmjMEWUPjp/WvJ
5727vIEnyHsDQBPON2jWcfmcty/O3+foKKD/rF+qWVF1jbq38HAxe09u6UwZlfex
Y6Opxh+s7+a+W72SFH+StwCUEpTY5Q==
=qnN0
-----END PGP SIGNATURE-----

--Sig_/5Uwy=RftkHFD=8Kb.kRS_pm--
