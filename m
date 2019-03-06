Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D95C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCFXKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:10:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57582 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:10:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 11E928052F; Thu,  7 Mar 2019 00:10:20 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:10:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Harald Dunkel <harald.dunkel@aixigo.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 4.20.1: BUG: unable to handle kernel paging request at
 0000100000000008
Message-ID: <20190306231027.GF7915@amd>
References: <fd58236d-a939-ec7b-b666-706f6853c49d@aixigo.de>
 <4b1cdcac-e6ec-09ca-558a-1ff391f13e52@aixigo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <4b1cdcac-e6ec-09ca-558a-1ff391f13e52@aixigo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-01-22 11:15:39, Harald Dunkel wrote:
> Is this the wrong list to report this problem? I haven't found a
> "mem" mailing list on vger.

Right list, ugly looking problem. How reproducible is it?

You may want to look at MAINTAINERS file, cc x86 and memory management
people...?

									Pavel

						=09

> Regards
> Harri
> -------------------------------------------------------------------------
> On 1/14/19 2:01 PM, Harald Dunkel wrote:
> >Hi folks,
> >
> >my server stumbled over this last night:
> >
> >Jan 13 19:03:15 sylvester kernel: [272280.820190] BUG: unable to handle =
kernel paging request at 0000100000000008
> >Jan 13 19:03:15 sylvester kernel: [272280.820198] PGD 0 P4D 0
> >Jan 13 19:03:15 sylvester kernel: [272280.820203] Oops: 0000 [#1] PREEMP=
T SMP PTI
> >Jan 13 19:03:15 sylvester kernel: [272280.820207] CPU: 3 PID: 46 Comm: k=
swapd0 Not tainted 4.20.1-raw #1
> >Jan 13 19:03:15 sylvester kernel: [272280.820211] Hardware name:=A0 /DH6=
7CF, BIOS BLH6710H.86A.0125.2011.0705.1517 07/05/2011
> >Jan 13 19:03:15 sylvester kernel: [272280.820219] RIP: 0010:find_get_ent=
ries+0xed/0x240
> >Jan 13 19:03:15 sylvester kernel: [272280.820223] Code: 4e 4e 00 48 89 c=
2 48 85 d2 0f 84 91 00 00 00 48 81 fa 02 04 00 00 0f 84 a3 00 00 00 48 81 f=
a 06 04 00 00 74 ca f6
> >Jan 13 19:03:15 sylvester kernel: [272280.820230] RSP: 0018:ffffc90000fd=
b9c8 EFLAGS: 00010246
> >Jan 13 19:03:15 sylvester kernel: [272280.820234] RAX: 0000100000000000 =
RBX: 000000000000000f RCX: 0000000000000000
> >Jan 13 19:03:15 sylvester kernel: [272280.820238] RDX: 0000100000000000 =
RSI: 0000000000000680 RDI: ffffffffffffffc0
> >Jan 13 19:03:15 sylvester kernel: [272280.820242] RBP: 0000000000000002 =
R08: ffff8880a98b7d80 R09: 0000000000000000
> >Jan 13 19:03:15 sylvester kernel: [272280.820246] R10: 000000000000004b =
R11: ffffc90000fdb9c8 R12: ffffffffffffffff
> >Jan 13 19:03:15 sylvester kernel: [272280.820250] R13: ffffc90000fdbae0 =
R14: ffffc90000fdba60 R15: 0000000000000000
> >Jan 13 19:03:15 sylvester kernel: [272280.820255] FS:=A0 000000000000000=
0(0000) GS:ffff888217980000(0000) knlGS:0000000000000000
> >Jan 13 19:03:15 sylvester kernel: [272280.820259] CS:=A0 0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
> >Jan 13 19:03:15 sylvester kernel: [272280.820263] CR2: 0000100000000008 =
CR3: 000000000200a003 CR4: 00000000000606e0
> >Jan 13 19:03:15 sylvester kernel: [272280.820268] Call Trace:
> >Jan 13 19:03:15 sylvester kernel: [272280.820276]=A0 pagevec_lookup_entr=
ies+0x15/0x20
> >Jan 13 19:03:15 sylvester kernel: [272280.820280]=A0 truncate_inode_page=
s_range+0xc5/0x810
> >Jan 13 19:03:15 sylvester kernel: [272280.820289]=A0 ? ___cache_free+0x2=
c/0x2f0
> >Jan 13 19:03:15 sylvester kernel: [272280.820296]=A0 ? jbd2_journal_rele=
ase_jbd_inode+0x105/0x130 [jbd2]
> >Jan 13 19:03:15 sylvester kernel: [272280.820301]=A0 ? iput+0x1e9/0x210
> >Jan 13 19:03:15 sylvester kernel: [272280.820305]=A0 ? __inode_wait_for_=
writeback+0x7a/0xe0
> >Jan 13 19:03:15 sylvester kernel: [272280.820319]=A0 ext4_evict_inode+0x=
52/0x5d0 [ext4]
> >Jan 13 19:03:15 sylvester kernel: [272280.820325]=A0 evict+0xbf/0x190
> >Jan 13 19:03:15 sylvester kernel: [272280.820328]=A0 dispose_list+0x30/0=
x40
> >Jan 13 19:03:15 sylvester kernel: [272280.820332]=A0 prune_icache_sb+0x4=
d/0x70
> >Jan 13 19:03:15 sylvester kernel: [272280.820337]=A0 super_cache_scan+0x=
121/0x1a0
> >Jan 13 19:03:15 sylvester kernel: [272280.820342]=A0 do_shrink_slab+0x13=
6/0x2d0
> >Jan 13 19:03:15 sylvester kernel: [272280.820346]=A0 shrink_slab+0x22a/0=
x290
> >Jan 13 19:03:15 sylvester kernel: [272280.820351]=A0 ? __mod_node_page_s=
tate+0x64/0xa0
> >Jan 13 19:03:15 sylvester kernel: [272280.820354]=A0 shrink_node+0xe1/0x=
450
> >Jan 13 19:03:15 sylvester kernel: [272280.820358]=A0 kswapd+0x3f9/0x740
> >Jan 13 19:03:15 sylvester kernel: [272280.820362]=A0 ? mem_cgroup_shrink=
_node+0x1b0/0x1b0
> >Jan 13 19:03:15 sylvester kernel: [272280.820367]=A0 kthread+0x111/0x130
> >Jan 13 19:03:15 sylvester kernel: [272280.820371]=A0 ? kthread_create_wo=
rker_on_cpu+0x60/0x60
> >Jan 13 19:03:15 sylvester kernel: [272280.820376]=A0 ret_from_fork+0x35/=
0x40
> >Jan 13 19:03:15 sylvester kernel: [272280.820380] Modules linked in: cpu=
id fuse btrfs xor zstd_compress raid6_pq zstd_decompress xxhash ufs hfsplus=
 ntfs vfat msdos fat j
> >Jan 13 19:03:15 sylvester kernel: [272280.820423]=A0 scsi_mod mfd_core u=
sbcore e1000e
> >Jan 13 19:03:15 sylvester kernel: [272280.820452] CR2: 0000100000000008
> >Jan 13 19:03:15 sylvester kernel: [272280.820456] ---[ end trace b383b20=
0f5d976a9 ]---
> >Jan 13 19:03:15 sylvester kernel: [272280.820461] RIP: 0010:find_get_ent=
ries+0xed/0x240
> >Jan 13 19:03:15 sylvester kernel: [272280.820465] Code: 4e 4e 00 48 89 c=
2 48 85 d2 0f 84 91 00 00 00 48 81 fa 02 04 00 00 0f 84 a3 00 00 00 48 81 f=
a 06 04 00 00 74 ca f6
> >Jan 13 19:03:15 sylvester kernel: [272280.820472] RSP: 0018:ffffc90000fd=
b9c8 EFLAGS: 00010246
> >
> >
> >I have opened https://bugzilla.kernel.org/show_bug.cgi?id=3D202257, prov=
iding
> >kernel.log and config file.
> >
> >Is there anything else I could do to help tracking down this problem?
> >
> >
> >Regards
> >Harri
> >

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU2MACgkQMOfwapXb+vLGowCffkPN5s3KaMAvMjEhKJD+hK/E
ehsAoI9cqyXd2tVdPLCY2JkOrjaINX9W
=q2Km
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
