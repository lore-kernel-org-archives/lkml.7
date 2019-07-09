Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC34C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B412166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YSok24rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGIAIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:08:35 -0400
Received: from ozlabs.org ([203.11.71.1]:34729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfGIAIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:08:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN2S2FK0z9s7T;
        Tue,  9 Jul 2019 10:08:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630912;
        bh=gIbeMJpsgUZdACr7gjCFzSrPO4XcPubah6dmaViDyX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YSok24rhAuzbBnDgImJvUM0Oqd9cn1DbrgLq4DeCO+ui5TkBP9ExoVKVsUk+YPqDT
         PniEy4cr47ey41DFUpSX2FeLhfZMG5EOEq9q6cMg8St0V2AGnxGkyxniyvSxlKYeWk
         tfU5Cbt+cg6VTBrzbpKoZasQHx/2fOcEPI8wqe0HLTfDM9qssSSuZV4uXmScaBgG5u
         GkaAsxg9DGBxKlDaRBRp50HIQNPhM1/hEOinTgL7+C7K98i3q4be83kndhNJSdfZ5D
         MjaSGiA76BRy6CMjzDQyouhIboFWt724gz2eIkQKRvgnNlm4juRoiQxKTA7DqTh0kD
         jVJJXjUa57I9w==
Date:   Tue, 9 Jul 2019 10:08:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the block tree with the jc_docs
 tree
Message-ID: <20190709100830.5d76bb12@canb.auug.org.au>
In-Reply-To: <20190625144226.48fff697@canb.auug.org.au>
References: <20190625144226.48fff697@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JYZFN1xrTdD/9l5Mo4UoRqO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JYZFN1xrTdD/9l5Mo4UoRqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jun 2019 14:42:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   Documentation/fault-injection/nvme-fault-injection.txt
>=20
> between commit:
>=20
>   10ffebbed550 ("docs: fault-injection: convert docs to ReST and rename t=
o *.rst")
>=20
> from the jc_docs tree and commit:
>=20
>   7e31d8215fd8 ("Documentation: nvme: add an example for nvme fault injec=
tion")
>=20
> from the block tree.
>=20
> I fixed it up (I removed the file and applied the following patch) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 25 Jun 2019 14:39:46 +1000
> Subject: [PATCH] Documentation: nvme: fix for change to rst
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  .../fault-injection/nvme-fault-injection.rst  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Doc=
umentation/fault-injection/nvme-fault-injection.rst
> index bbb1bf3e8650..cdb2e829228e 100644
> --- a/Documentation/fault-injection/nvme-fault-injection.rst
> +++ b/Documentation/fault-injection/nvme-fault-injection.rst
> @@ -118,3 +118,61 @@ Message from dmesg::
>      cpu_startup_entry+0x6f/0x80
>      start_secondary+0x187/0x1e0
>      secondary_startup_64+0xa5/0xb0
> +
> +Example 3: Inject an error into the 10th admin command
> +------------------------------------------------------
> +
> +::
> +
> +  echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
> +  echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
> +  echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
> +  nvme reset /dev/nvme0
> +
> +Expected Result::
> +
> +  After NVMe controller reset, the reinitialization may or may not succe=
ed.
> +  It depends on which admin command is actually forced to fail.
> +
> +Message from dmesg::
> +
> +  nvme nvme0: resetting controller
> +  FAULT_INJECTION: forcing a failure.
> +  name fault_inject, interval 1, probability 100, space 1, times 1
> +  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc2+ #2
> +  Hardware name: MSI MS-7A45/B150M MORTAR ARCTIC (MS-7A45), BIOS 1.50 04=
/25/2017
> +  Call Trace:
> +   <IRQ>
> +   dump_stack+0x63/0x85
> +   should_fail+0x14a/0x170
> +   nvme_should_fail+0x38/0x80 [nvme_core]
> +   nvme_irq+0x129/0x280 [nvme]
> +   ? blk_mq_end_request+0xb3/0x120
> +   __handle_irq_event_percpu+0x84/0x1a0
> +   handle_irq_event_percpu+0x32/0x80
> +   handle_irq_event+0x3b/0x60
> +   handle_edge_irq+0x7f/0x1a0
> +   handle_irq+0x20/0x30
> +   do_IRQ+0x4e/0xe0
> +   common_interrupt+0xf/0xf
> +   </IRQ>
> +  RIP: 0010:cpuidle_enter_state+0xc5/0x460
> +  Code: ff e8 8f 5f 86 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 0=
2 0f 85 69 03 00 00 31 ff e8 62 aa 8c ff fb 66 0f 1f 44 00 00 <45> 85 ed 0f=
 88 37 03 00 00 4c 8b 45 d0 4c 2b 45 b8 48 ba cf f7 53
> +  RSP: 0018:ffffffff88c03dd0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdc
> +  RAX: ffff9dac25a2ac80 RBX: ffffffff88d53760 RCX: 000000000000001f
> +  RDX: 0000000000000000 RSI: 000000002d958403 RDI: 0000000000000000
> +  RBP: ffffffff88c03e18 R08: fffffff75e35ffb7 R09: 00000a49a56c0b48
> +  R10: ffffffff88c03da0 R11: 0000000000001b0c R12: ffff9dac25a34d00
> +  R13: 0000000000000006 R14: 0000000000000006 R15: ffffffff88d53760
> +   cpuidle_enter+0x2e/0x40
> +   call_cpuidle+0x23/0x40
> +   do_idle+0x201/0x280
> +   cpu_startup_entry+0x1d/0x20
> +   rest_init+0xaa/0xb0
> +   arch_call_rest_init+0xe/0x1b
> +   start_kernel+0x51c/0x53b
> +   x86_64_start_reservations+0x24/0x26
> +   x86_64_start_kernel+0x74/0x77
> +   secondary_startup_64+0xa4/0xb0
> +  nvme nvme0: Could not set queue count (16385)
> +  nvme nvme0: IO queues not created
> --=20
> 2.20.1

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/JYZFN1xrTdD/9l5Mo4UoRqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2v4ACgkQAVBC80lX
0GxjeQf8C4sX4LFHiH7ta1FzJ+XfKEE6aDaTRAekdUPyKdadebk1onRgZd+L7m9/
tUPbPX+DAJHFQUFu+CAHogxDD056jcVIiuCmtV4dBAYPjP7HD4B4bGTRNkCCNAYs
t9v28XeIeFXCcKvHEuHtJyvN01kHIBvda1+7eC7MYCD5pSD1HWwPk9EwGE1bNIkJ
V448cVaNzrE2yqw7SpXLnXVCIbTgCt8fj+ng1nJWAm2WMmzXitvR6j1ezcuWs8CM
sdXon9+BjA7lA/JLJv49yFWlHTMJIKkbQukKGJoYK6G+jmYzZxGMFHeuH4ANpEc6
QsHdDGKOrkKzsEwaOS++8Wjf/EviyQ==
=vKNy
-----END PGP SIGNATURE-----

--Sig_/JYZFN1xrTdD/9l5Mo4UoRqO--
