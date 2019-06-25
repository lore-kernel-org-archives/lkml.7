Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F39C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE01C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eKRpeYo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfFYRD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:03:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:44399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfFYRD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561482205;
        bh=0exmBa3v5Fx1E33w0NM7D+ZEc4ilILyfqTpdzWB8iqQ=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=eKRpeYo12R+UBTjglAVW4a3GVPG4o3FqxYdfsLbwbQem9/7+OSXG/sgkeBbVfuq9U
         iDkHeS0QSt9KC+JCIYVBbVryfQJaUCHI2KRcdz/eZLnm3X69d8O+2jJCewlQlxf3BF
         cxN8VWaeZTjPSjoR1EavkG2/LgcAnxRJBLfYoYZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.10.152.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1iASV63XPP-00eab4 for
 <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:03:25 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: new dmesg message "dmesg-5.1.15:tty tty2: hash matches" with 5.1.15
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <06f0d820-c50e-52dc-4bac-707914b403e9@gmx.de>
Date:   Tue, 25 Jun 2019 19:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MX3saBcFFshQQ0InauTf9vAEmUJ+BrhdmaQGQaYWsfxqaxSEk2K
 RdLWRsqYzFazG6nqQFAMy8Fj0k+RDI43sltDpQqtVL0AbYEFSehBbmPYuyQHnywXGGmioh8
 4mMcCbc6ogH+6hdTxRHLgV/yjSFzDzwRX8MKPay0Wn6r5D3Y+I0iLKgVijgQq5VF7LrXvnX
 F3CsWyx11ycp9XHhMjyuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MV3O1OhHrwc=:Np6bOENOXMjz6zY4y0zyeS
 vHu3bK9EQBJDoW6x+cmje0ypd+7Cm58fWzaiWVQqLxCeQABqi+VOsi3tSeOr55K/rIbXi345r
 u3BZhJ81nqsvkD1TIxoj5KqNbOoFbSkF2uE+2EfZa/FfOk9AG78L5+fLxI9d90EiglVKlBaGX
 pR70KOjWdVP3J2Y9uFZ7GUi11+MRuEE21x9Y7/jknXkfGwT866SnmOxIKHflqv2vzgUKkxqmJ
 UubQfO2FU9vM/UXh2H0NwPTc4axYRfXNCBQU8IO7i6WRlcczXtHN1+PEubZGM1B+UNEsoI3rF
 onHz+Qvv3Dla4zBKIu8TF78iwV05xQfNOVohsCHWqapupoY1FSAizqAlfUQjfDlS0BLQ457Uc
 o0Ms3Eki/AE4ZnnZbcTmzlJc8nLsTOeYQLZb+wZpDv4zhBzAhUhkpSd09RCF5EX9+WyD9KjkV
 BkC1beU9tMLoCrtcYZLnd7Gv8JFZthNP/HGjDKHd8OF67DfPDlti2RyXLKG54raMipyUTWjYa
 UT7PgTLYVVuMThdaq/7tpnbKRk+1jWjqA/QDkyCjGtKhoCvWBMuBqRdSXgaqBx/CDp+d7DnuD
 qFcEY9X/jXxB7Ag6AfveBSAjxS6mO/qigqV5YVFnWq/P4ulEXB5NUUYhw24jTk2o4dHELSf9l
 rPa7OGw/9AgCHO7uxi3z7kgn8SogL7nCMkU/3fFSsYgh9tO23J4cd//y+/M3UODBtlUtcVfkZ
 2tulL5ZY2E0TBq9Zd0kxGVmSxGOxp4r601TCbwRwtjVqcg7Nq5FxHujbG7T5wDWOG/DNiabK/
 0UWzkoSZimyGNzbIuH0qmXih5mn7vj7F9dCHel9GTlPI913M9pP/gBN+2UiIjgwVdv3/dyDOY
 36ZwQl4YLx0+DPoQjoZ5riOkFHtkOT1VivNzbFMQ2CZEm2UDP1fO6mFjqr/0tnMPTnhQvJ69m
 r6Myoxfexed2PIfH+ugsAk159XYPA7F2yU+lXSBqYGqoox/wC3JUA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at my docked ThinkPad T440s.

I'm just curious what this does mean?

...
sched_clock: Marking stable (765790894, 14019108)->(786693847, -6883845)
registered taskstats version 1
Loading compiled-in X.509 certificates
alg: No test for pkcs1pad(rsa,sha1) (pkcs1pad(rsa-generic,sha1))
Loaded X.509 cert 'Build time autogenerated kernel key: ac61161b25852a930a=
9d67e7f2b9e5a9633ce42f'
Btrfs loaded, crc32c=3Dcrc32c-generic
PM:   Magic number: 7:467:945
cpuid cpu0: hash matches
tty tty2: hash matches
processor cpu0: hash matches
rtc_cmos 00:02: setting system clock to 2019-06-25T16:55:52 UTC (156148175=
2)
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
platform regulatory.0: Direct firmware load for regulatory.db failed with =
error -2
cfg80211: failed to load regulatory.db
...

TIA
=2D-
Toralf
PGP C4EACDDE 0076E94E

