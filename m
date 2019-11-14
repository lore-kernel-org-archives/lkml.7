Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8202AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC032070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKNNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:38:00 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36339 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:37:59 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N4z2a-1hmFvu1zSm-010vTY for <linux-kernel@vger.kernel.org>; Thu, 14 Nov
 2019 14:37:58 +0100
Received: by mail-qt1-f174.google.com with SMTP id t8so6784425qtc.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:37:58 -0800 (PST)
X-Gm-Message-State: APjAAAXVCEoHeGchz3hVow5l1+00VKvMr+dm1nSVTTYDAJcQaEmEh5bB
        HJ/Yn3ZUPm29apf3zIVwVU9ljgtkWNqNM5FkDh8=
X-Google-Smtp-Source: APXvYqzSK6wr6Em0+s4Y4wr0WRhfpgdJiSMT5gaO4R50uDMcEna9JltLJIPrUDETGJSMZRlVSg2rdQJ1rKkG1nvBra8=
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr8188706qta.204.1573738677418;
 Thu, 14 Nov 2019 05:37:57 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
 <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com>
 <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com>
 <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com> <CACT4Y+YnaFf+PmhDT5JRpCZ9pqjca6VeyN4PMTPbCt7F9-eFZw@mail.gmail.com>
In-Reply-To: <CACT4Y+YnaFf+PmhDT5JRpCZ9pqjca6VeyN4PMTPbCt7F9-eFZw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 14:37:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1viWDOHPxzvciDt8fPCm3XkbLJxAy1OjtJ_-vuP-86bw@mail.gmail.com>
Message-ID: <CAK8P3a1viWDOHPxzvciDt8fPCm3XkbLJxAy1OjtJ_-vuP-86bw@mail.gmail.com>
Subject: Re: linux-next boot error: general protection fault in __x64_sys_settimeofday
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QqFlPG29xq+Vkzw2ZtzTkPHHa3EjD2CoCpUrPWOCG9/CsX2mUlH
 QyuJ7XwZmbpV5JkSMx/NwtotcBPJhDeEM0diH/SF4eYkCh+gSZqGNkNlW+5uf9L8HChefck
 0ayNw4myzlwCkKpvKM1LJnZkr6Si44YSJUyr3/OCMzUhYoFneBcLtkBkbQR30iDww23ne6j
 YQhqZxI2hpAvaOX58Zu2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/g9SfRQuOZA=:2zmZfikiwPcV5/w9KgG4od
 EDSx9w/A/+HVO0G38Cl/D2VwSLxKESbKq5MKle2T7pyq8btdvhJslwtFj9M+78HxJfFq3AHfd
 OD6aUf+RCq5PWzzeNR/cbQYHb24lFoOeKl9ALOgsxuNzAuOwoyJGX1FrLuPNNBd319dhaQAdT
 CF5n6n9d3Ib7KdfGUeg72kGTig8Xp7kpUKhPVLZTaY0qbpZl6j6KIDLsoavHhnQs86tg9o+p1
 4FuDJXDL6GDI2C+F/F+I4HpDun7iDQcahkOze4/0JxBFTazAqwbkSurOXeT14Q2ng7H1fmLsz
 KoWGYMPT/mYycAOs5Vcs7zGq3jj18Ad7bInjUFNc77FbYcu4R/6eEpJGJ/5GS98zo8u9RnbyD
 ErVQoC3ncjno1vbfXr9LIU41zrwAa6pe9l1mdnJ91FlCgwmTeDlGGWcuQUtrJH8jqGUzdYCuv
 yz0aQXJUeeILUm/IOPlUCW7+nV53KrdOmHpjLO5uB2Yvq5XNfjQhBUWJ6VNz7REyZBxUHinpc
 CqNkXWfsFzwHTsY6ihJ+RFniaNobJ3Jr3qQVpjDnDE9QsXdmFp+y9RR95tcpCXNccJ60DPWX+
 qEdSrczgkKyLkU2bs0J+H1TaeCQti7xYDrGL7Cz45GCfKDo6U5Hd2qcsTOzoUf8btIvMFUWcL
 uU8MPLcjYfmg/fCPmy7bTNTGFJqWkAl9J07/chA/XDsu9UckPN+0MX9kkYSsUJ2JyrgWOXJNd
 XYikA57OOrp/z3QmriSt3h6rrzdDC+3Bh6x5rxCy8IlkcwWH13CXz7TU6pXPQh5am3S8AP085
 aeMdVWHtbdjxH/7VJsKT5QHfwkAMw83ALl1jt0Jm53jF9uP72z48f3up9dO6/w9RXjhrxJgV/
 PDrWvB9D8hz2QhTHiSIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Nov 14, 2019 at 2:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Nov 14, 2019 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Thu, Nov 14, 2019 at 1:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >
> > > > > On Thu, 14 Nov 2019, syzbot wrote:
> > > > >
> > > > > From the full console output:
> >
> > > >
> > > > Urgently need +Jann's patch to better explain these things!
> > >
> > > +Arnd, this does not look right:
> > >
> > > commit adde74306a4b05c04dc51f31a08240faf6e97aa9
> > > Author: Arnd Bergmann <arnd@arndb.de>
> > > Date:   Wed Aug 15 20:04:11 2018 +0200
> > >
> > >     y2038: time: avoid timespec usage in settimeofday()
> > > ...
> > >
> > > -               if (!timeval_valid(&user_tv))
> > > +               if (tv->tv_usec > USEC_PER_SEC)
> > >                         return -EINVAL;
> >
> > Thanks for the report!
> >
> > I was checking the wrong variable, fixed now,
> > should push it out to my y2038 branch in a bit.
> >
> >       Arnd
>
>
> This part from the original reporter was lost along the way:
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com
>
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#rebuilt-treesamended-patches

Is there a recommended way to give credit to sysbot if the bug only
existed briefly in linux-next? Simply listing Reported-by would be wrong
when I fold the fix into my patch, and it also doesn't seem right to
leave it as a separate patch while I'm still rebasing the branch.

      Arnd
