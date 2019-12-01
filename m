Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6CFC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B920718
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfLAQos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:44:48 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:56945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:44:47 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MJmbB-1iLhfb0JOj-00KBLo for <linux-kernel@vger.kernel.org>; Sun, 01 Dec
 2019 17:44:46 +0100
Received: by mail-qt1-f182.google.com with SMTP id 38so2681408qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 08:44:45 -0800 (PST)
X-Gm-Message-State: APjAAAVpzuYY5x/kW5CHLQOOwdt/ffNtxsbdG8rY7dicAxmYQ6PfwnNX
        DwpodFV5+YBdMOPKhL1dRRRGHselOTK++0KlrOM=
X-Google-Smtp-Source: APXvYqxvnxSj/66+/lDecdMwj6M8AFyXqy/26aPCnzwthmCG6oW0xv/BsNFL2aznxBZfoqspozN/VN3dgd/uaZZVSQs=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr27264902qtr.142.1575218684964;
 Sun, 01 Dec 2019 08:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20191201151049.GH18573@shao2-debian>
In-Reply-To: <20191201151049.GH18573@shao2-debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 1 Dec 2019 17:44:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2rFb6RykcL3=4djkPgza=yi9hZE8w-Bu4-zUn5W9Pgvg@mail.gmail.com>
Message-ID: <CAK8P3a2rFb6RykcL3=4djkPgza=yi9hZE8w-Bu4-zUn5W9Pgvg@mail.gmail.com>
Subject: Re: 942437c97f ("y2038: allow disabling time32 system calls"): BUG:
 kernel hang in test stage
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qe/AVritUqdg5kDYs5g4RO4Y3VWlbyxZkviapj5+HBezMS/QK8Q
 d7ZUAdoeWyFPsBe2JjXni+xC8g572rzo96LOiOyNWA1Hmx72JAGMyKaeBMZYHN+sR3oHdW2
 6IaX2Cc3qU/HnGBQ04OaYI5b0SYXVj4Podv0i9q95rCLjcpea35N06p4mZNrX1mPSvrdnHh
 lPZ5Q2IVVQkbEJJ2xRaiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oFGmITc1nDA=:ntH/FEWTc0cW69siELE0xA
 ZdGFxI+XlSkUnEb10nd0KP9qvebvVQUfukEgwzf+MZjC49OWB+atE9zYI9rKj8Tb2n3hQYT8e
 J1iucDO4LPbYbPenpUsd7Q8J7/Zy9L2jnMppas3tXArzweRSh1OyMafELsLts0GjIrLUDEq53
 Jf24NNgVXJ25ks0XNaca2l915hshdU08vGa0QoaLjJaECAA0mJWN8X7CPtdGcFTYgcmwwrwYy
 74425RBWTUuoT94tBTWGAEBhXFJeTyDhWdH+6avv5Rn9QR4ONuZ0k/IFnz5GZw6mI0+vkxZSl
 a5wB3XsoTxGFs3TFT9S6OXhTX3lw6NAFNAu6q0DXyUVwwL76Z35rVPfzbrPBcteqVpOC/8dS2
 p7haguxwk0v1i/iqhdH8uxMKPq+4WJZU+BRoVwiNyLLv6BMdvWeY7+APlITKPWuFHLmCVZzWa
 KGMjN6PHFexr4OxfHkS1X5vB77bu6Ssp9YR//jQyAE+g0S4Hi/h3hja04d6srzeFn/iWqG/rR
 zF7Dfc6ukEomFfjA9unmE2pfw7Eket8C+VD382xV0rbLNUJeRTETkOqmHJUb/cZJuOVdH0Eu7
 r3L24n8AyzD+VXRT7CGIWN5r3ks9zpN745+rycgF/ZlFZ6s7+4l8niyOk7OSPSO7xCDfZb54c
 eTaaeXf2dBB3io5/ddkjBgu88/Y4lTSninBYW99ngiPXN1ARafXHrcC3RBFhWAESsDtoINPYQ
 P826yP3HqofOixcA+67QBjygakQgrxa/wa918d40uoInrlHDboXHmcxti439TxsJ5Ca2gjPV0
 5V3LYGOhZFCYc1N7pJBZfylhS0Lbp1tX6MzslOpCJBHzEyQ8PQMna8HKbT1Aw3yjvAugHA0np
 zQJDStexIV31wQekoMGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 4:11 PM kernel test robot <lkp@intel.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>
> commit 942437c97fd9ff23a17c13118f50bd0490f6868c
> Author:     Arnd Bergmann <arnd@arndb.de>
> AuthorDate: Mon Jul 15 11:46:10 2019 +0200
> Commit:     Arnd Bergmann <arnd@arndb.de>
> CommitDate: Fri Nov 15 14:38:30 2019 +0100
>
>     y2038: allow disabling time32 system calls
>
>     At the moment, the compilation of the old time32 system calls depends
>     purely on the architecture. As systems with new libc based on 64-bit
>     time_t are getting deployed, even architectures that previously supported
>     these (notably x86-32 and arm32 but also many others) no longer depend on
>     them, and removing them from a kernel image results in a smaller kernel
>     binary, the same way we can leave out many other optional system calls.
>
>     More importantly, on an embedded system that needs to keep working
>     beyond year 2038, any user space program calling these system calls
>     is likely a bug, so removing them from the kernel image does provide
>     an extra debugging help for finding broken applications.
>
>     I've gone back and forth on hiding this option unless CONFIG_EXPERT
>     is set. This version leaves it visible based on the logic that
>     eventually it will be turned off indefinitely.
>
>     Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> bd40a17576  y2038: itimer: change implementation to timespec64
> 942437c97f  y2038: allow disabling time32 system calls
> +-----------------------------------------------------------+------------+------------+
> |                                                           | bd40a17576 | 942437c97f |
> +-----------------------------------------------------------+------------+------------+
> | boot_successes                                            | 38         | 0          |
> | boot_failures                                             | 0          | 19         |
> | BUG:kernel_hang_in_test_stage                             | 0          | 15         |
> | Assertion_failed                                          | 0          | 4          |
> | Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode= | 0          | 4          |
> +-----------------------------------------------------------+------------+------------+
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
> [    3.739930] rm (184) used greatest stack depth: 6556 bytes left
> [    5.754828] mount_root: mounting /dev/root
> [    5.762906] urandom-seed: Seed file not found (/etc/urandom.seed)
> [    5.767017] sh (172) used greatest stack depth: 6308 bytes left
> BUG: kernel hang in test stage

Thanks a lot for the report. As far as I can tell from the attached files, this
is a randconfig test on a 32-bit platform with
CONFIG_COMPAT_32BIT_TIME disabled, so this is expected
to fail because the existing user space application actually requires
the old system calls until it has been recompiled against a new
C library using 64-bit time_t.

We could probably make the failure more explicit and print an error
message for these particular syscalls when they are disabled.
Alternatively the configuration step would need to be changed that
the 0day bot is unable to run into this case.

      Arnd
