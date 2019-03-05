Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6313C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFF520684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCEJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:40:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36333 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCEJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:40:16 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1h16YY-0005Vl-MX
        for linux-kernel@vger.kernel.org; Tue, 05 Mar 2019 09:40:14 +0000
Received: by mail-ed1-f71.google.com with SMTP id o9so4152557edh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 01:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:organization
         :mime-version;
        bh=TcZ2RcQGONGsbKn0IVkuOHaUiOrxsTFfNrsjLo1TGGc=;
        b=EVvESRuDvKOUxh2TaqKgGw0/s0ZqGpSX+0YWtg9DwZy0/KOtvjMgoVGrHBTDUf9jdE
         YgKKXzwz2TXTgwMuo8+UIu6MSaiJAanavsf4O+JyiMszK3h+NVAKCE4fNgDlI++nYpZ6
         oU8ptWlOKt2HOAEoRo3teeX0yKjr01B/6VOh5j3y5szkj20sg8VOqnutxw3TeaCTV5Qu
         hn9biyD8cUhDhVVEpSLKEkhsWkpw92+8LtglsDy8+ORhHiSRrTU6N/koZs23aeXxS3RP
         zZsT+vYMn4Bml3MsGEd6OKvZRXUjAMOnEvjGH33/gue0pMDeQZ8NOH6Jm/6KY2mKoSQ+
         T6yQ==
X-Gm-Message-State: APjAAAXGVBKkFQX4G0bK5NZzVgPlI39q7K0ZPZzONIfB+cVhlRaY/scv
        JIzbghgyD1m8TCh3HkpG/cYflV1hzdCJfuOWmBV1Ru9hyQkQhtxsZXYfuoNgmQL+jxwvLqbH5ZL
        CUShTULxBtLHZ4kfaesT+ZgEwEHF89Nes75auw/FtUw==
X-Received: by 2002:a17:906:1503:: with SMTP id b3mr11573300ejd.111.1551778813792;
        Tue, 05 Mar 2019 01:40:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqydDDbWcGONLAc/kf32ROz5wsxGcI5++N/ZGb5Lqa7imZC6/tC3ZHKv/cPmUV3Y61WIzc8Ykw==
X-Received: by 2002:a17:906:1503:: with SMTP id b3mr11573286ejd.111.1551778813385;
        Tue, 05 Mar 2019 01:40:13 -0800 (PST)
Received: from gollum ([81.221.192.120])
        by smtp.gmail.com with ESMTPSA id m41sm2878118edm.61.2019.03.05.01.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 01:40:12 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Tue, 5 Mar 2019 10:40:10 +0100
To:     pshelar@ovn.org, davem@davemloft.net, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: openvswitch crash on i386
Message-ID: <20190305104010.6342e9b9@gollum>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ncEWhAH8Ihoh0Wvy74SK_Mp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ncEWhAH8Ihoh0Wvy74SK_Mp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Running the following commands in a loop will crash an i386 5.0 kernel
typically within a few iterations:

ovs-vsctl add-br test
ovs-vsctl del-br test

[  106.215748] BUG: unable to handle kernel paging request at e8a35f3b
[  106.216733] #PF error: [normal kernel read fault]
[  106.217464] *pdpt =3D 0000000019a76001 *pde =3D 0000000000000000=20
[  106.218346] Oops: 0000 [#1] SMP PTI
[  106.218911] CPU: 0 PID: 2050 Comm: systemd-udevd Tainted: G            E=
     5.0.0 #25
[  106.220103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.1-1ubuntu1 04/01/2014
[  106.221447] EIP: kmem_cache_alloc_trace+0x7a/0x1b0
[  106.222178] Code: 01 00 00 8b 07 64 8b 50 04 64 03 05 28 61 e8 d2 8b 08 =
89 4d ec 85 c9 0f 84 03 01 00 00 8b 45 ec 8b 5f 14 8d 4a 01 8b 37 01 c3 <33=
> 1b 33 9f b4 00 00 00 64 0f c7 0e 75 cb 8b 75 ec 8b 47 14 0f 18
[  106.224752] EAX: e8a35f3b EBX: e8a35f3b ECX: 0000869f EDX: 0000869e
[  106.225683] ESI: d2e96ef0 EDI: da401a00 EBP: d9b85dd0 ESP: d9b85db0
[  106.226662] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010282
[  106.227710] CR0: 80050033 CR2: e8a35f3b CR3: 185b8000 CR4: 000006f0
[  106.228703] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  106.229604] DR6: fffe0ff0 DR7: 00000400
[  106.230114] Call Trace:
[  106.230525]  ? kernfs_fop_open+0xb4/0x390
[  106.231176]  kernfs_fop_open+0xb4/0x390
[  106.231856]  ? security_file_open+0x7c/0xc0
[  106.232562]  do_dentry_open+0x131/0x370
[  106.233229]  ? kernfs_fop_write+0x180/0x180
[  106.233905]  vfs_open+0x25/0x30
[  106.234432]  path_openat+0x2fd/0x1450
[  106.235084]  ? cp_new_stat64+0x115/0x140
[  106.235754]  ? cp_new_stat64+0x115/0x140
[  106.236427]  do_filp_open+0x6a/0xd0
[  106.237026]  ? cp_new_stat64+0x115/0x140
[  106.237748]  ? strncpy_from_user+0x3d/0x180
[  106.238539]  ? __alloc_fd+0x36/0x120
[  106.239256]  do_sys_open+0x175/0x210
[  106.239955]  sys_openat+0x1b/0x20
[  106.240596]  do_fast_syscall_32+0x7f/0x1e0
[  106.241313]  entry_SYSENTER_32+0x6b/0xbe
[  106.242017] EIP: 0xb7fae871
[  106.242559] Code: 8b 98 58 cd ff ff 89 c8 85 d2 74 02 89 0a 5b 5d c3 8b =
04 24 c3 8b 14 24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d=
> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  106.245551] EAX: ffffffda EBX: ffffff9c ECX: bffdcb60 EDX: 00088000
[  106.246651] ESI: 00000000 EDI: b7f9e000 EBP: 00088000 ESP: bffdc970
[  106.247706] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[  106.248851] Modules linked in: openvswitch(E)
[  106.249621] CR2: 00000000e8a35f3b
[  106.250218] ---[ end trace 6a8d05679a59cda7 ]---

I've bisected this down to the following commit that seems to have introduc=
ed
the issue:

commit 120645513f55a4ac5543120d9e79925d30a0156f (refs/bisect/bad)
Author: Jarno Rajahalme <jarno@ovn.org>
Date:   Fri Apr 21 16:48:06 2017 -0700

    openvswitch: Add eventmask support to CT action.
   =20
    Add a new optional conntrack action attribute OVS_CT_ATTR_EVENTMASK,
    which can be used in conjunction with the commit flag
    (OVS_CT_ATTR_COMMIT) to set the mask of bits specifying which
    conntrack events (IPCT_*) should be delivered via the Netfilter
    netlink multicast groups.  Default behavior depends on the system
    configuration, but typically a lot of events are delivered.  This can be
    very chatty for the NFNLGRP_CONNTRACK_UPDATE group, even if only some
    types of events are of interest.
   =20
    Netfilter core init_conntrack() adds the event cache extension, so we
    only need to set the ctmask value.  However, if the system is
    configured without support for events, the setting will be skipped due
    to extension not being found.
   =20
    Signed-off-by: Jarno Rajahalme <jarno@ovn.org>
    Reviewed-by: Greg Rose <gvrose8192@gmail.com>
    Acked-by: Joe Stringer <joe@ovn.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Reverting that commit from 5.0 makes the problem go away. I'm not able to
reproduce the crash on x86_64.

...Juerg

--Sig_/ncEWhAH8Ihoh0Wvy74SK_Mp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAlx+Q/oACgkQD9OLCQum
QreQqA//Q8PXX7CI6dxC/ShNQIADlBp4OD4YOyN8us+Ow/6Vq0QzmFyHwex0AYCo
WZBJHXpiDybaoSaOHoaQEjC5QbQw3elfrs0Q45jvv5KakaxEBJ9DFPUOr2wq6bVe
5QABqGsGEAxhH+IZBksnPZfA8cF3MJ/PKI+0PeRgR6ldNTJ5jx7L1w+vPFejycpL
CFMR2+yIEFPxKMhMcTzstyps9EIFdZ0l8gIXvbnvR+YdnD64wZ4IVL1M/kdfftbb
Zuoz9l0FfPzpeCPNaWTsdXgQI6dtYB4ufKkDP/fR5sCTzGwZmUoCUK17ovdZKluZ
jI0V/QwJ6EAGP3IF+sM6TJeco7/b5XPaeEA+IejN3EE2P9mMau1tCa+4DrZRP7Cy
JnsQuNyLpIqLciaoHgsnsKQ+hTAn8S5x6IuNgHNtnagQlKibYA620sGepcKHMhEI
Ysl2aXPSUA1o5dG9Eykn4VfyMBj7IG1JwMDsq7UJsZ/W3v9/UL5Rfbr6jCXHyYRM
tkUFImNHThUTN6btQvMjyd25tcD9OGENjccUxQSm9/dM+Ybax0b1SXiAgCqoV7WP
gNHvvYMwT/w0JtLlaOCKo0FU6OCMkN5dQ5M10X1VO9cQ8xp64vyk8KbLOuC1mYo1
McHJ5z93whHyAOgicJYpJH0pz4iPen/99aR1SpiDdpAeBMohEhY=
=ig/a
-----END PGP SIGNATURE-----

--Sig_/ncEWhAH8Ihoh0Wvy74SK_Mp--
