Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E76C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F176D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfDQMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:04:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfDQMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:04:04 -0400
Received: from [192.168.1.110] ([95.117.89.119]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnac7-1gXWi237uH-00jZ36; Wed, 17 Apr 2019 14:03:19 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
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
 <c783a83a-01a1-9813-e2f7-0516cf7a1c16@metux.net>
 <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e58d1694-c143-3465-512d-43301422bd8b@metux.net>
Date:   Wed, 17 Apr 2019 14:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWWoEvnzx6oLTEajBmiArScX5sSt74o2VO+aTiwEi_9mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S6381OmZdIJPo14f04+kynwonZHVnZAMZunGyEEpDujyIA49q5i
 eaPD0ry9oTBiNONUezdHdoZWyqeJJwC7ha/lUiUSZLjpPIKcS5Ku3xUGzvI2g34og8R++V0
 7MBNA1EeohnNXlkiT+ZCGutssGlxVCC5OHoMB75EUhS4octH9+I+DY7LS3O4VD7o/7vw1IZ
 lDIlxjCeJPzh+TpmCvplg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6QTSXU9U/x0=:wbOvqRVDQMzVX2dvNaK7xT
 c/tSxEjSUcWWrxflOaDsKm+zbOXBZILyVxSO/phzMQJZU7007ikwslZeN8wEPI2AE8DybvYrZ
 X0hEHPEJLKWlbdvJUrg7zVepp0rIr/IgvcXMU9Qmbq3LtNHxrF0AcGvclgM5hXRKqvKplzt+a
 oE3mBNIDPQZG9T3Op/PzC4s3vhCFHzj0pooHK4yysv4V2ZEdrYPH71ymf6y8xww8WCIaGGonI
 aeIJAsqvqW4zwICB9dCD+W05YrBIWrvcks+d+7xCmkJX5QfQAKVPVcnf4N5XXdp8+nVWcw1Ur
 +GbFhKIbBe1JCdyblZByFqVTGWX575qp7OSefCc0WOICL0YiXIt5oVki+8hI0ue3xzqqph/QI
 zIiBvEaQsIzMiEhZM1Pz0l/YwmK5N1/7RcLIqJi/qBaEMt0h4lOkknf0sm3EbwCWf8OZsFlP9
 77MSUZsVtJTys0ho07zSRsaAo6DBfeR+60piPa82duGkSJkhqTdr65uydi+izP/0SbCH9vI3B
 Zs9tbC4GrPzunzdPeYpzsiC0pUh/qbZ4GsjEs3S2Ou651P+k2r9Vr9/hT7LCUmGgpIqcxhwlC
 BYIY47tjhY2+q1fKYll52fYBXeEf+rWw7y75xg/mr0B87MCYuA2b0/itA2HLhLcPWpUt+ablf
 2jqJiYiIAGpJGlp3jq8/javMY7oWpQhuIZDy3LhDxwaZq2DOw/FFeJtnZXpEU/NWfuZP+a1r/
 mqilclcqCZIW8BALL6iNfYJAHlj3lA8o+SnJ2UGQeIVyPRBcJJlPIR7tusQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 23:31, Andy Lutomirski wrote:

>> How exactly would the pidfd improve this scenario ?
>> IMHO, would just need to pass the inherited fd's to that daemon (eg.
>> via unix socket) which then sets them up in the new child process.
> 
> It makes it easier to wait until the privileged program exits.
> Without pidfd, you can't just wait(2) because the program that gets
> spawned isn't a child.  

Ah, that is a cool thing !
I suppose that also works across namespaces ?

What other things can be done via pidfd ?

>> But: how can we handle things like cgroups ?
> 
> Find a secure way to tell the daemon what cgroups to use?

hmm, do we have some fd-handle to cgroups ?
In that case a process could send a handle of his cgroup to some
other process (eg. some "login" deamon) allowing him to join in.

We could look at cgroups more as kind of capabilities instead of
limitations (eg. things like: members of cgroup "net-foo1" are
granted n% of network bandwith, etc). That would open up completely
new approaches to security and resource control :)

It could go even further: anybody can create new cgroups within his
own, narrow down some limits and pass this to some other agent that
acts on behalf of him and is allowed to use his share of the system
resources for that.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
