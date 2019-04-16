Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8322C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953C3206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfDPSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:46:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:46:33 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRTAj-1hSvvh3muT-00NPYB; Tue, 16 Apr 2019 20:45:45 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     Andy Lutomirski <luto@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin>
 <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
Date:   Tue, 16 Apr 2019 20:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X9Wc31OSfOB3dqfuHaYOzelhc80zfhScriOgFKi0nk/nIFZB53n
 ZgffFeJwmoPEFr/tZb6STR6CFfiusgJ/SnyOT4pcaRQt3+ORWoE4cavoyjTSxAtiBW88SQQ
 jnRDt31+/lVkio47xCjR3tgTOgJjDNZ1H2r6Lo8VOEhwaagBhmgHd7WpyTZFffW6+g9o1vg
 0/GSWW/YZ0CN9xg5D/aig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:grgZT6TsS78=:s0jOXq5IEMHRpNEb4eb5li
 BgNE8KmCLYc9kZo0266WGvUe7Bi842Q3ez7gEpkABk8vp3EAUVdQjym6GQwHoDcNtdQGjgPxh
 r3EVRzqPPOBARUvyd2mMCJn7MJZiL/9iA3PMsjTUHBNt4tzy1SLEkV2OZEK7AdBfvXnK8BKVt
 7N13bF271iLEw8981aOnko3qtFS/T5TOX2o0IryN6wQhzZevTL/8Nm176gfirXtaOTa8kDm7f
 Fp9P22+Flq1HsqpcronPEwZs+0j8KdNIfRckbu8qM9mC7gF3HWD/t79baV3kM9yttVCy3yatw
 ytxlu5DRSbee7m0urDyJYECGY8om/ulkSA/Y+5tN8uAQxuwKkbs7QjTwSXV+Zot5KDAPCnRE2
 bE9cGEUYZOBs7Az5ERMFt5dHlqhlufKF4BOwsZ4gm0thpvb/GiTXrHn9vENiyEnZrAbs6D1Lb
 RVk1uRYYu4pzUsZY9HzIZyxEsL+WZhV7Jl9CIzSIwhX2wNlIRDU6dWPN2PaX4ViPrh3ky+yV9
 LvJhXWucHfomYO41s5hYCJbNy25SfFQ0Abvno4WQ1Zt2Ug8kpJURAvK50dZu47b9fUrS4KsfU
 xHiy26jObnn6jbUc4wPC4utIWSUOo4HsEEbPnxehwOTdIb4QaPxGiNO3ktdA1F/Er2wRa2hA7
 /0aqVRSSiTAuHRyKQT7O4Kl/0CkLRcX3wukwwwLud99F1VvbvN23T+dQI3eZpSCvauHM9Pq3x
 xPE8H3wmjz0tJRqd+jpgfPqPXw9M1eEUzI6/y3ZlOpPDrgtkiJMGuZOdsfY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.19 22:29, Andy Lutomirski wrote:

<snip>

> I would personally *love* it if distros started setting no_new_privs> for basically all processes.

Maybe a pam module for that would be fine.
But this should be configurable per-user, as so many things still rely
on suid.

Actually, I'd like to move all authentication / privilege switching
to factotum (login(1), sshd, etc then also could run as unprivileged
users).

> And pidfd actually gets us part of the> way toward a straightforward way to make sudo and su still work in a>
no_new_privs world: su could call into a daemon that would spawn the>
privileged task, and su would get a (read-only!) pidfd back and then>
wait for the fd and exit.

How exactly would the pidfd improve this scenario ?
IMHO, would just need to pass the inherited fd's to that daemon (eg.
via unix socket) which then sets them up in the new child process.

> I suppose that, done naively, this might> cause some odd effects with respect to tty handling, but I bet it's>
solveable.

Yes, signals and process groups would be a bit tricky. Some signals
could be transmitted in a similar way as ssh does.

But: how can we handle things like cgroups ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
