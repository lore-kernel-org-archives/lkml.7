Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56671C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C1A20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HKbBtXbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFVNkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 09:40:42 -0400
Received: from ozlabs.org ([203.11.71.1]:41703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfFVNkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:40:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45WGsK6CHkz9s00;
        Sat, 22 Jun 2019 23:40:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561210838;
        bh=lZ/keDuHXUg14R9OMotOzR7qvsuAlNsrI1rmNIM1Ecg=;
        h=Date:From:To:Cc:Subject:From;
        b=HKbBtXbMyf0DBxRSlYo/bJd2kIWMsEx7mqs4J6m8cQCbSYnYcam1icfZArUEnIATd
         6tkibYuvbQzv+SWSOwXVZZqTnlCVqIHi76rZoNsZLm/pSD1P7PRrpfECBcXEluYoAa
         rO/ueiIVE8YieM7RCtFSztPxM0WWfRwQXX+NVk9+T5XvAEi2FCEl5v26ppkRw2OnXt
         l7caZ0/1/gUcinv6NXYYFd4Fuz7JwNb+/4w17ylPm4X25C9z2JJjp+i7SbS0/B/4pl
         M/p0xYRaA+/9h5ClgzF7d5hg6sbD85VBSIlul79nxHkxu7vseNpC+8Vb8vAhW23OzS
         tWEAB6xEkHtmg==
Date:   Sat, 22 Jun 2019 23:40:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20190622234029.21fe1f27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EFPf+vZLkc3DLRAx3sAk+26"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EFPf+vZLkc3DLRAx3sAk+26
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  46c1bfcfcd87 ("PCI: xilinx-nwl: Fix Multi MSI data programming")

Fixes tag

  Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags across more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/EFPf+vZLkc3DLRAx3sAk+26
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0OL80ACgkQAVBC80lX
0GwVgQf+JqGiL66mbnQ6aPjk76UOBQgdadiyQwW4kXv+Mqp8As2hJdkNf/p7wssX
hE+xeno3lW5BkIBzDjCuIOQfZhmIJKolZsqAt8BB7jpeCNCFJQ5y1CtlJM2Y/8Ac
8FXNCWESWGQyMwCmTKPPXH2N5Sfb6Lqf502GvUbUlTw19oXKZE70VvtxzWBg1w6o
80fwmzi9+ALv4QwEWIrORG8VjyQstJbXbMRy0yObco1ReXaVbstdt1oYDWX7m5E9
pb5rUMtJfhxrRPT/4rligPO2SLN/fZWbHn2l+H8NGpN6nEjRgWwEU25dhLD7cN3I
16lFIXKx5tBcuTtdMFPo4ShBbsd+Cg==
=r9MJ
-----END PGP SIGNATURE-----

--Sig_/EFPf+vZLkc3DLRAx3sAk+26--
