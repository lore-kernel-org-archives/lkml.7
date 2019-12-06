Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC4424679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLFIA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:00:59 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52687 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:00:59 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MLQgv-1iLKZu35U3-00IRyV for <linux-kernel@vger.kernel.org>; Fri, 06 Dec
 2019 09:00:57 +0100
Received: by mail-qk1-f179.google.com with SMTP id f5so5733312qkm.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 00:00:57 -0800 (PST)
X-Gm-Message-State: APjAAAVX4YPhryGZ6Bnx11bB/lSzmCqe3qcCS6+Iha0YZsXNOxaCx7gt
        GETGngEHICpWlL9a5Da15elt1sWaOGkErP6rLh4=
X-Google-Smtp-Source: APXvYqxvPvngGnqI3KfxX5TA14iqLHRpY0Nw9Q8k2LQPLebD37U3xSpF1VsHKNGGBRVISdDBrCF58YljODTEnh8KDV0=
X-Received: by 2002:a37:84a:: with SMTP id 71mr12246779qki.138.1575619256605;
 Fri, 06 Dec 2019 00:00:56 -0800 (PST)
MIME-Version: 1.0
References: <201912060818.dgGGxpRK%lkp@intel.com>
In-Reply-To: <201912060818.dgGGxpRK%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Dec 2019 09:00:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
Message-ID: <CAK8P3a23_rWdmjyZNezd9k=-KL4VZyV+DCLvh-UgCQUQTsysyw@mail.gmail.com>
Subject: Re: drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and
 *UND* sections) for `^'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3tcRftNLo6AAe96emUVRqtlq1TFfAHHTissaNYKAicwtWEOgFr5
 G/3XvWBNf1beqBdn34+r0oLj8SfRMoZpZ9/E7Cnajt4/sVJDW3xKwNbEwkuS6nb1ctiPrnz
 sG/jN+xggqKSebXCI7y77aCPCnZh9BiWwcQKwQYpp+qVJINHXHaJruXURdRsYDrZ9hxY0JJ
 jSm6r3INFlBMjXcUbvEdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sbiIH7oMTlU=:zTrPq+BH57aTAw6CHmSK51
 hUtX4uwZM2PJ2uBA3VoOLXQjVeOnsaL3lMm/PCu4hSm5dLo/Kr/Yc6enFP7/D+FckvabnczJ0
 UNpJvyj2NN3RAZvTo+ujWSyOmhles2wf+cLZ6PoWwD/dNR6tUcnN4Qme85Pi3TG0j7GqNMo1U
 R4WnuiU5zn2SLMphuiDezv7l5V82aYxYh1wkdoCzjt+6r3bxchtyb4F78itdv/58LvGQ5Av7a
 OsnODxSAHHr3KQ+714KW8KN+8DDIWZVYBoTUCu1PUn8cR6pU/vr0BhKgdBR6UPhn5FljJJTGx
 EITbi4HvtVNXq+y+LO/A++fW+cWhGPOJ1nK7h2ZFrFqp32kby7NZ/2Bc6uCfJIFuKnWHuwjMg
 DQm3PaKoM7u81/l1YaYIJMZR7dRVp8lFQWfCNoN0j1l2DzLDK7zBl53mzTJ2f27vcLIter/X5
 Z9F6N+LUFgIhTY7YOn+rqCSGOjGA8MF3pTnVTAc/4CVOZQqNWQ7bBcBwgQbndTTz+EjgIwsav
 9wMHPm9wrRHuCXiAdt4HrSMod91Cuh94gPN19LPAF/VR8bJrYerAAPQ5Quj0kuF/ayueChAqG
 VZdZ09DQLU7QDCajc1g70GgVPVRjBqLEkceI/GKCCLbldVp8P7BhKQ0qn3qYgCn4R/+Ffvy1w
 3udZ9dJdBIB3lz2TUwx/A3s0Al9G/YYJkEOqvGVQEj98Fb9ET7jJn+PRgBz8UI0OmXPBApoiR
 073UrppIb3yjvEYXgTSyKu+Yo0QfeOolFEHaWWv5IGMIgp/Xq/T8HcS4rB+Hlzag1pANleBIn
 bCb+qx/GN6PkmQey++4a461UtsH/uPeH6GKRe2vtFhUfxkzHSr5LfXyiD7KO/Pjv9uxrUBpge
 vu397cVXfMkpRhWkXAvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 2:05 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2f13437b8917627119d163d62f73e7a78a92303a
> commit: 1207045da5a7c94344e0ea9a9e7495985eef499a compat_ioctl: move tape handling into drivers
> date:   6 weeks ago
> config: nds32-allyesconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 1207045da5a7c94344e0ea9a9e7495985eef499a
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=nds32
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/scsi/.tmp_mc_st.s: Assembler messages:
> >> drivers/scsi/.tmp_mc_st.s:3: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:4: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:5: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:6: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:7: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:8: Error: invalid operands (*UND* and *UND* sections) for `^'
>    drivers/scsi/.tmp_mc_st.s:9: Error: invalid operands (*UND* and *UND* sections) for `^'

Adding nds32 maintainers to Cc:

It looks like a regression caused by my patch, but I don't think it's something
I did wrong, but rather a toolchain bug being uncovered by the modified sources.

Are you able to reproduce this?

       Arnd
