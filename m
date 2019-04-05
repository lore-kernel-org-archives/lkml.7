Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EFEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0609217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfDEMax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:30:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:30:53 -0400
Received: from [192.168.1.110] ([95.114.101.225]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MEFfB-1h2Fdn1BCP-00AEOC; Fri, 05 Apr 2019 14:30:50 +0200
Subject: Re: Query on how WWAN and Modem interact
To:     Ajay Garg <ajaygargnsit@gmail.com>, linux-kernel@vger.kernel.org
References: <CAHP4M8VDaAQF=5DTNX2SoMmytNwjsa82i1qfx3FnFvpjH4eYVg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <463b23e5-b84f-9fbe-bb44-7d60077f69aa@metux.net>
Date:   Fri, 5 Apr 2019 14:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHP4M8VDaAQF=5DTNX2SoMmytNwjsa82i1qfx3FnFvpjH4eYVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JL/kuyT5PF+Z5MFDqUDronrfE7ZiRc2M7n5j735Hg/PMYPbYzu6
 SZ/Mu5iIRcVYxn3Kjha4a5FNp0uqnHP7ExXHCFxyxIfJMB7HiO545VTcHiaJNRppPpwn9ZC
 EbT2PR61Lg9hJX/hpFcKsvXGYBUfzaI6fzop+/+/x7VYhnnI2toUFnAagpdw/f6rPkk10xA
 xUjeKq7TpKjdK0g4aU9+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O+TwzKew2OI=:Umxfp0qESNl2wKcFvG6Hns
 B602D2Jjm16jKehT9VWqFRIa+8ICJ6s4aF0466Q+Jl0B/5oSa9qZj9dlmdHODp+nCyl5hKVS2
 hmM26aou3HfiDiPqR46kYzc5sIVGsSv6gSqzkrvkiQ6XSvYWGporzX5ZzFZjW5xZ8YivXDd99
 K4I/Xe981dSDdkVsErVi+/VvUi258Ee3ajtUlJBVoao9QM4FquAKUfRWxoPeJa10rRieO6KbJ
 RcvK4GZrsHP7unUJz5WbVTcGV+dAyDsT6N8QFMbNWTZm1srMNxZjrdqh+nM0RidyFw2seQAFW
 WCfmfs6WDpPcVY40L0dCrOOvXZNxEzIquBT4zyhf0TtK4vf6JyRG0Z2Hi71PaDaFPmkdNpnSi
 XwXzWvBWvPURXsdGBDtoEsyJAs01PmOxTwEnXhJEhoVsqOS7kxrEFn1J4QPztEOevosTEM0E7
 OoQFkvtli+NeYGomV4JyYQlK5iw+UIOX0njqG7yJT1ap57CAG+ir/b5QIG4xtNNXAklie07qm
 foIYjhwR5sbz5Q3cb6qPYH8GQtyO790fSulyhr7taqQNwzadJonbxhw36dUd3Qf5RboRxq51g
 xxOutfDTABKdqalcNW7MeKUo93f998r6kXbnOwB3fAeSkSLMxPZkXBnhMYX8JPlsk5xU9bTKt
 C77wC0uk0yn0eR4PD9ftuJk9yjglhSqeRX1Bcz4g98akgQo3ug/Oew8hfWbDhuXfsgLt3Wt4r
 6dSg0aX9Ee1d6uR0YLAUE+GExtSoAqzX6E7mQGwSA9Tjr/yh7n2sH8uYrpE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.19 05:35, Ajay Garg wrote:

> I am wanting to have some insight on how a modem plugs into the
> linux-kernel at architecture level.

Well, that depends ... which type of modem ? which protocols ?

The most common case are the classical serial modems, attached to
some uart (including those isa or pci cards that just have  speaking AT
commands. Here, somebody needs to do the
dialing (eg. 'chat' command) - after dialing the some daemon
for the corresponding (ppp, uucp, ax25, ...) needs to take over.

With async-ppp (ppp over uart) it goes like this:

* pppd is started, sets up tty, etc
* pppd calls a chat script (usually using 'chat' command) for doing
  the dialing (AT commands) - this subprocess gets the fd to the
  tty as its stdin/stdout
* when this finished, it takes back control and does some ppp handshake
  (line probing, authentication, address/routing handshake, ...)
* then it creates a new ppp* device, attaches the ppp line discipline
  to the tty and assignes this to the new device
* the unix black magic: line disciplies
  -> these are special filters that can be attached to a tty for
     intercepting the traffic, eg. for job control or trivial line
     editing via a terminal, etc
  -> the kernel also has a ppp line discipline which intercepts ppp
     frames that contain IP packets puts them into the ppp network
     interface's rx queue (so pppd won't ever see them), as well as
     writing out the outbound packets back to the tty

Of course, there're are also lots of other kind of modems and protocols
that work differently ...

> Now, we are in a bit of situation, where only the AT-interface (of the
> modem) might be available to us (via a serial /dev/tty interface).

That's the classic old fashioned way - pppd package comes with tools to
handle that. (by the way: I wouldn't like to cope w/ complicated things
like modemmanger, etc).

> Also, using AT-commands to actually set up sockets is also fine.

What do you mean w/ sockets ?

Are you talking about basebands with integrated ip stack ? Those are
nice for tiny MCUs w/o any OS, but tricky to properly integrate into
into the berkeley socket api.

What chips exactly are you talking about ?

> Now, my query is once the AT-commands succesfully set up a socket, how
> does that link to "wwan" interface in "ifconfig" listings.

If the baseband/modem really does the whole IP stack, including sockets,
on its own, the answer most likely is: not at all.

But that depends on what baseband/modem exactly you're talking about.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
