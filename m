Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC71B20449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfDPSdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:33:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfDPSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:33:36 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXH3e-1hLU9S3cvm-00YfCs; Tue, 16 Apr 2019 20:32:53 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415155034.GA25351@mail.hallyn.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <000a64d6-1e22-21bf-f232-15f141092e44@metux.net>
Date:   Tue, 16 Apr 2019 20:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190415155034.GA25351@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:idE9K/WQ5QvXO0GQUgKPPOXnURDmwBfbTQPPulkXHuxDXT9GYUO
 LPw5vgoEhKwXDluN/3BoulMwRZKmvyk3SSX6AUmsye0TT6WDJRCWYX6NkUzRSekO+0f8S5c
 ZL/sOOSXRkzPZxHtAnSQd+0usHn3VL8U1MCIOAsoHXjjaw6pggbr3OpU1DHY9MmUmcoYGkB
 22Vgx0eafWk8cb+CNSk0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xCVq+f5vwCI=:X0A1NubqmRzmVILUpG0wQ2
 7sLI2bE9mgh1HsyCg+SKr1C9bW7FIlG83Y9i5u06CAdOwSsfxjzIhuPlkKtfgPbTYQsQlrtlz
 Lfe2AiGzi0uIjKxEn7UZfrP41vDvF8reqaVF+lX6/xvNd5+UL02rwUyS2Gi/i2sT7iclx1drV
 tTTLug0fp+mkrzglDFcliI2kT0Cf0IFvgsjWoTJCZT4ZrXYC9G5mOXiHUAigOi3ieMv0SxJC+
 VNe/rBIk65lJFzb5Z4tuoAfuwtI2HyZdqJS9NIsVrqNLDla1fyDZaropEtPK42JvcI/JBoUST
 1sAVhwPmxJJ2Pu2jX8aJASvuXZ+mKYk1TMvrlCX6evGrHVMC+oHDj58asQFlkG3VLKgYyntSs
 R6K3JvzK101b8Iod2QLBGDH91XpuPE16hNvcX1NdXEOrgFQip30utGr0h56VuMKZPZk5mjjBB
 QgB+8HCYgRgOo1iMzux7E6pZKblX80Ie2kKUc12zHmZG434iJlnOSkUrETuNMbVL4bIX5Tzz5
 Fmag5pFauq7WmIUYA25aKiJn0/9TH8AHUkj5dtnewk6dkDwSjBjj3unIjedMdHRsdbZ6EhMyw
 zE63/1BrZ7G0Qo3itzwHNaouHy0XosjYZQGSZlJt4vifgRE3b9OJrULoL2xUUrR2BCwoLmhq3
 gajd5UhOLOS5kiH5VfEmgdQgeKmlIC8dKJ8pkTYt8DLu2eWD1T2ENnaxu3jN3tAdsFAFGgK/W
 uRoLim+vGPUnmY+nzvG/hGhqmU0KDct2909hpcUYQLc/cSXfnamFWJQfaZ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.19 17:50, Serge E. Hallyn wrote:

Hi,

>> I'm working on implementing plan9-like fs namespaces, where unprivileged>> processes can change their own namespace at will. For that, certain>
> Is there any place where we can see previous discussion about this?
Yes, lkml and constainers list.
It's stalled since few month, as I'm too busy w/ other things.

> If you have to disable suid anyway, then is there any reason why the> existing ability to do this in a private user namespace, with only>
your own uid mapped (which you can do without any privilege) does> not
suffice?  That was actually one of the main design goals of user>
namespaces, to be able to clone(CLONE_NEWUSER), map your current uid,>
then clone(CLONE_NEWNS) and bind mount at will.
Well, it's not that easy ... maybe I should explain a bit more about how
Plan9 works, and how I intent to map it into Linux:

* on plan9, anybody can alter his own fs namespace (bind and mount), as
  well as spawning new ones
* basically anything is coming from some fileserver - even devices
  (eg. there is no such thing like device nodes)
* access control is done by the individual fileservers, based on the
  initial authentication (on connecting to the server, before mounting)
* all users are equal - no root at all. the only exception is the
  initial process, which gets the kernel devices mounted into his
  namespace.

What I'd like to achieve on Linux:

* unprivileged users can have their own mount namespace, where they
  can mount at will (maybe just 9P).
* but they still appear as the same normal users to the rest of the
  system
* 9p programs (compiled for Linux ABI) can run parallel to traditional
  linux programs within the same user and sessions (eg. from a terminal,
  i can call both the same way)
* namespace modifications affect both equally (eg. I could run ff in
  an own ns)
* these namespaces exist as long as there's one process alive in here
* creating a new ns can be done by unprivileged user
 One of the things to make this work (w/o introducing a massive security
hole) is disable suid for those processes (actually, one day i'd like to
get rid of it completely, but that's another story).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
