Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84673C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A95E214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="FMBVGqlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfG2Kzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:55:49 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:42485 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387424AbfG2Kzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qJwhLMPSe3C9YgLvBSNOGorf/nwsbbvmT2Y7mbu5aMI=; b=FMBVGqlJlkL5BslLpwdm3U0Yer
        e16bQoNK6my/0tSlydt6gNRBMs5Iua7+FIDR9C/QBoSFbYEl1sbamXLgvrkSW3ps6kerNy0CmUJvE
        ghUW/WxBWGrBw1jzhlcpjVq6De7XGFWJN0avJ7eLijcn/74D5NEzTUQdp49P7EqJ6O2ELbQgM/kVK
        UIXux3+igNhEDPlTX2CRZZ6DAmzjyZuj59+O1tFQ5ZCBK/v5t4HnD7gjCSHoqgdTSudm5Cujvq7XC
        peFWhFSSvj9bmddcrdlaL9VUOIhXrgqRQhEVCaPAbimQvu1vbTC9V4i8NWRLfKkJ+ePnVAmQX2PVw
        djYGvaPA==;
Received: from [37.204.119.143] (port=58276 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hs3JS-0008Jg-Rr; Mon, 29 Jul 2019 13:55:31 +0300
Date:   Mon, 29 Jul 2019 13:55:21 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Message-ID: <20190729105520.GA25742@cello>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-5-ar@cs.msu.ru>
 <20190625213215.GB3116@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20190625213215.GB3116@mit.edu>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH v2 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 05:32:15PM -0400, Theodore Ts'o wrote:
> <...>
>=20
> (In particular it might be worth checking Linux ports of Oracle and
> DB2.)

A couple of weeks of asking around got me to have a look at a DB2 9.7
instance.

sn1:~ # uname -a
Linux sn1 2.6.16.60-0.54.5-ppc64 #1 SMP Fri Sep 4 01:28:03 UTC 2009 ppc64 p=
pc64 ppc64 GNU/Linux

That particular deployment used the following set of processes:

sn1:~ # ps -eo user,ppid,pid,pgid,sid,tty,state,cmd | grep db2 | grep -v ja=
va
bgpsysdb  8505   672  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,171fc0,0x110000000,0x110000000,1600000,18002,2,384f00b7
bgpsysdb  8505   687  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,191fc0,0x110000000,0x110000000,1600000,18002,2,384f80b9
bgpsysdb  8505  4309  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,151fc0,0x110000000,0x110000000,1600000,18002,2,6f5080c5
root         1  8505  8504  7146 ?        S db2wdog 0
bgpsysdb  8505  8511  8511  7146 ?        S db2sysc 0
root      8511  8512  8511  7146 ?        S db2ckpwd 0
root      8511  8513  8511  7146 ?        S db2ckpwd 0
root      8511  8514  8511  7146 ?        S db2ckpwd 0
bgpsysdb  8505  8630  8504  7146 ?        S db2acd 0 ,0,0,0,1,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,11fc0,0x110000000,0x110000000,1600000,18002,2,398072
bgpsysdb  8505 15280  8504  7146 ?        S db2fmp ( ,1,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,31fc0,0x110000000,0x110000000,1600000,18002,2,bd80bb
bgpsysdb  8505 16032  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,b1fc0,0x110000000,0x110000000,1600000,18002,2,81980ba
bgpsysdb  8505 16073  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,91fc0,0x110000000,0x110000000,1600000,18002,2,12300c0
bgpsysdb  8505 17683  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,131fc0,0x110000000,0x110000000,1600000,18002,2,248600db
bgpsysdb  8505 30731  8504  7146 ?        S db2fmp ( ,0,0,0,0,0,0,0,1,0,8a6=
678,14,1e014,2,0,1,f1fc0,0x110000000,0x110000000,1600000,18002,2,370080d1

None of them has a controlling tty, so ^T pressed at any tty won't send
them a signal.

To get an idea on how do they handle signals, we can look at
/proc/*/status:

sn1:~ # cat /proc/{8512,8505,687,8511}/status | egrep '^(Pid|Sig|Shd)'
Pid:    687
SigQ:   0/128000
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: fffffffe2bbaf007
SigCgt: 00000001c44004f8
Pid:    8505
SigQ:   0/128000
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: fffffffe7ffbfeff
SigIgn: fffffffe2fbaf007
SigCgt: 00000001c0410ef8
Pid:    8511
SigQ:   0/128000
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: fffffffe7ffbfeff
SigIgn: fffffffe23b3c005
SigCgt: 00000001dc483efa
Pid:    8512
SigQ:   0/128000
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: fffffffe2fbbf007
SigCgt: 00000001c0400ef8

It can be seen from the above that SIGPWR in particular is always
ignored and sometimes blocked, which means its default disposition has
no effect.

This leads me to think that DB2 in particular would be unaffected by the
patch set.

p.s.: I do not have shell access to the machine, and never did; the commands
cited in this email were executed by a person who does, and the output
was handed back to me.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl0+0JAACgkQ9dQjyAYL
01CzdRAAu38njim8DW61okHfX3GyhvxAvUy7Fg7QPJfoLIgFRrW+s6MB1myRyem+
rvn+XScQaSlpH5a+aa50V3l3bxRuD38WF1+hU6USyjl4Jpv+DBFH5aNmYqkQIFJ1
4yKySdyOVF+jFCIpdCihoT3nfRhim7rhd4sjlYX6zWzLEvnmsYe7zPm7BZMcNPTV
wgEz/AwLXjtKCoa/W6EHQUiylutWcs0TLqMCQhYpt9p9FSg2/GmCczYGc1/SZ4en
Fvjp7BMYg9Ha2rNnVHkd3QbJu6S+1eyKx5srz5x2CEuAwR3Q/ojw0f4kMJgUXqCk
fqj81B9hxwXoV8f3gfhLUTmZO9tmt2hP9J9aLDFfETNxzhTs0hPdPW+7Vg3CsUQ/
/WbGu6riGUsRQkUjvRoiisIVRHthxO2g6MD0taEJx3ZBfUFEtnNfzzP6xCrrKaHY
LQ59yngfVUTVkHFlK+WYEHlhLXqrRHS1Kt9LFR/k7N6o7h2RspJoEOFzTZwlwV9+
A2o4xAuUeg+3frmbUC3aWljzfet5FmSZ9And6QhtD1C40DQWVtZpitI6xWULcj1i
UgLFd+/02Nu1jeDnfV1r5dWGdn1K7B1TmNJ8E0xZPwPQ+d8r3bN4Cg6lwVuz7wUp
tba+wUzDoTqvjmJ6sHz5qwjBfzi+OKwBR2ip4AbkWMtY843R5lQ=
=6Ez9
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
