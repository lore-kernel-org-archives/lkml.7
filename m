Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84375C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534492173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Yh086HFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfC1Xrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:47:35 -0400
Received: from ozlabs.org ([203.11.71.1]:60321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbfC1Xre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:47:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44VhPG07dhz9sQy;
        Fri, 29 Mar 2019 10:47:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553816850;
        bh=EcIRos7//W8AlSG9bSaCmUPnVbeLg4qcNGq2kqZQijc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yh086HFbVziKPRifqKG4CvRDxoZmHwODVM9/L/IQ2AH63lzUD7rR6fg1GsFXRWbmR
         utGu5SegMw8fPxlVGZxmtl0jIcJ3esrKyUEeORjrtBcft5T+i0IfTyLCG+3VZaz3n4
         f3ZMzyzoRyY+Qa5oGTv+T0anDLQUxqMBMeUvgsI6zf1YpatJi0fVcdYBzFnkM7n4ce
         YZ/5PQo/GyMxoE6b1KSD36ByXaHRzZfoWMrJP6K5gzi7ENfHuYlAYGFtKDldtEf0A7
         OzFdhllo9S75Eg+dO+mKPXkMGOJJqvuPMeEUSkaL2F2a6AmHUWSwNYSjvwHV39Z8jq
         7LiLEg+ORp0OA==
Date:   Fri, 29 Mar 2019 10:47:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 5.1-rc1)
Message-ID: <20190329104711.12718e5a@canb.auug.org.au>
In-Reply-To: <CAHk-=wj1c_Tb-wwM6qaPLdggXtW3rOh1JzYUOs+O7PsHt-=+jg@mail.gmail.com>
References: <CAHk-=wj1c_Tb-wwM6qaPLdggXtW3rOh1JzYUOs+O7PsHt-=+jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bUmv7_/x3SXNwr=7WGREpV0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bUmv7_/x3SXNwr=7WGREpV0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20190304 was the first linux-next after
the merge window opened.)

Commits in v5.1-rc1 (relative to v5.0):            11241
Commits in next-20190304:                          10955
Commits with the same SHA1:                        10131
Commits with the same patch_id:                      375 (1)
Commits with the same subject line:                   39 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20190304:     10545 93%

Some breakdown of the list of extra commits (relative to next-20190304)
in -rc1:

Top ten first word of commit summary:

     69 net
     43 perf
     30 drm
     24 scsi
     18 kbuild
     18 cifs
     17 platform
     16 sunrpc
     15 tracing
     15 pwm

Top ten authors:

     39 trond.myklebust@hammerspace.com
     30 arnd@arndb.de
     21 yamada.masahiro@socionext.com
     14 alexandre.belloni@bootlin.com
     12 vadimp@mellanox.com
     12 mchehab+samsung@kernel.org
     12 kjlu@umn.edu
     11 lsahlber@redhat.com
     11 evan.quan@amd.com
     10 stfrench@microsoft.com

Top ten commiters:

    143 davem@davemloft.net
     41 trond.myklebust@hammerspace.com
     35 acme@redhat.com
     28 yamada.masahiro@socionext.com
     28 stfrench@microsoft.com
     24 torvalds@linux-foundation.org
     23 martin.petersen@oracle.com
     23 alexander.deucher@amd.com
     22 rafael.j.wysocki@intel.com
     21 axboe@kernel.dk

There are also 410 commits in next-20190304 that didn't make it into
v5.1-rc1.

Top ten first word of commit summary:

     41 mm
     23 scsi
     23 btrfs
     22 arm
     20 xtensa
     13 dt-bindings
     12 nvmem
     12 clocksource
     11 nfc
     10 dm

Top ten authors:

     32 gustavo@embeddedor.com
     20 akpm@linux-foundation.org
     18 jcmvbkbc@gmail.com
     12 wqu@suse.com
     12 stefan.wahren@i2se.com
     10 jglisse@redhat.com
      8 logang@deltatee.com
      8 claudiu.beznea@microchip.com
      8 arnd@arndb.de
      7 snitzer@redhat.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

    125 sfr@canb.auug.org.au
     24 gustavo@embeddedor.com
     24 dsterba@suse.com
     23 jcmvbkbc@gmail.com
     18 srinivas.kandagatla@linaro.org
     18 daniel.lezcano@linaro.org
     14 mst@redhat.com
     12 stefan.wahren@i2se.com
     11 sameo@linux.intel.com
     10 vgupta@synopsys.com

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).
--=20
Cheers,
Stephen Rothwell

--Sig_/bUmv7_/x3SXNwr=7WGREpV0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlydXP8ACgkQAVBC80lX
0GwtEQf/WC/9sHySpboyxsYXmzQm4Qm3NakchAGUZkjwnui8wf738j9K7nxl+NyS
5igffjsJ3SyWcVXEbUbKr1hGYK/z2JmKBBUKsJddtZzclpv1+M5g1jUXROygQ3vw
Y+ydOx3FZUpJpD9rmxPcPhBSTD0jVO2+FPejAakAjXSwX2c2ip6Y1ABS4gwWRlhx
he94+/+2CH2/jI9E7H90UO5WNQ54ggvf1VDNXWdY/7lUN61MxoRs9NdUHLPS1fwY
/J+UPxhGtM3jvAKilZ13uPe+m2TbghzNLZGG6om9zTbAVKHIa44TN4FMBstQ+tfv
N9Kh/sj7n1++JI7E6SEWT3INIUt1/A==
=GnVu
-----END PGP SIGNATURE-----

--Sig_/bUmv7_/x3SXNwr=7WGREpV0--
