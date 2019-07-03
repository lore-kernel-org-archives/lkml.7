Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B894C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0DB218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGCTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:33:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:33:55 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQMqN-1hvlgV3yxl-00MMxE; Wed, 03 Jul 2019 21:31:43 +0200
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
 <20160825201919.GE3296@wotan.suse.de>
 <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
 <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <40f70582-c16a-7de0-cfd6-c7d5ff9ead71@metux.net>
 <20190703173555.GW19023@42.do-not-panic.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9a2ae341-9ea7-d4c6-7c3e-b12bb6515905@metux.net>
Date:   Wed, 3 Jul 2019 21:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190703173555.GW19023@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kb/MYLc04HZOKlSnabqpK7DsYFcfO94OtT241V79SgdBtnFK6If
 3tPNNpMoG1pn8RBT4JKFPkFxXdMvYp1jNHC9iHtM2vV6TleiNErFy9d3yL0iJTmg4PdJxma
 5Od557VVQzR6m2nGhX9XXh80GZ1N11ZxfgvlC58thnluFXulWdn0/hyGLu4O3KZGjFCRlPs
 XrIUoqVcrdlEMU5owxolA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GGlFYQ9CSoI=:Oa3dYStAtCjwENUukwkjWX
 sP+nmf03MSeLVUBXJoE2AtBF93nOE8vvGOFm32bPxfQ34x2wy+21ZoThtwKT35yHbyFNuItEl
 c75grpJrW93c8AtAKhom/gas95IZt8skAZQnAqRW5bCSFldNjjXR3CljqNMvfU1WJYhjvf4Pr
 mgNHZYe913MSHlOHBIVO9C6Dtxi7ijr5BNTn2meODYTNqX0TpQ8ClwVtsNpiVUWuiHOs/xDzV
 Cx22KNB+14YZntZYOBMZs2noZmw8uvTQLHjfs0z3ZGKoS0t0Gf2Bh9Xm3rEIDPx/gYGRAYq3B
 PIl6lzjP01A/TjGMt0UdbBlcry4OhujX00Ja0QK3XdQItsa19TS7Xgm5ZjGkBT4xAZRGF/Plb
 aLkGh0dhCoiJoXkwQCOQGFO+JLvZEID0jydypYE2Lc2+najdBgeLHDDcs9eSpLqe3ODtw45jb
 FY1u8wC5mELMqYgD+pXhw8olH0QXUby95p4KD8xaQXc3uofsVDBWwOeCJtCHb/wvQSTKNSi0c
 6soxqkkuEMgL8/CU2b2h1G12pdoVlxCZp7N+sL1diqgKgWJk6lwNzUkkyI31ZESu9tFuQGI08
 /SC71/9bcNwD7yXXHjiszSQact/mSnS7v6pCC/MU7P/6VXvf8RjcLRcbwIQgIIrLqo9a+bMoT
 YffbvCVsPWkzphA9JX7tmQUplK2FNtbHe5FtqUbsWZCDp5eKyJdiDICeljThaZJ9jj/LZky4i
 xEHCvWBnS/eETyTAp4LtIPZDKb9292NNkJzWSs7OeDsu6A0yg+A6r2Zq2j8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 19:35, Luis Chamberlain wrote:

Hi,

>> Okay, but IIRC this will add more boilerplate those modules.
> 
> Just one module attribute.

Yes, but still one per module. This raises the question whether
maintainers are willing to cope w/ tons of tiny patches for just
one line - for something that will take quite some time to become
actually useful (doesn't help much if only few drivers support it),
and is only helpful in a few use cases.

And to make it really useful, we also need some way to automatically
derive which other symbols to enable (subsystems, etc), w/o auto-
enabling stuff one doesn't need here. (are the defaults sane for
this usecase ?)

The main problem here, IMHO, is that the kconfig system doesn't really
know what makes up a module (it only knows that something w =y cant
depend on something thats =m).

So it smalls like we'd need some config language that really understands
things like modules, subsystems, arches, etc with their properties and
is used by both kconfig and kbuild. Then we could put all metadata there
instead of the current macro calls. At that point we could also put
things like match tables in here, which would solve the problem of
finding the right driver by hardware descriptions.

But that's really a *big* topic, it's not easy.

>> And I wonder whether target binaries are the right place for those
>> things at all - IMHO that's something one wants to derive from the
>> source code  / .config's.
> 
> For the use cases mentioned for why the module attribute is being
> suggested it would help to not have to download kernel sources. 

Are we still talking about compiling custom kernels ?
(how to do that w/o source code ?)

> The only question we want to answer is: for the hardware components
> present on this system, which configs options do I need to enable
> to support these components?

What else would one need that data, if not compiling a custom kernel
(which in turn needs the source) ?

> At least for virtualization we decided to support at least these two to
> help:
> 
>   * make kvmconfig
>   * make xenconfig

These two are rather simple. Most times there isn't much variance in
virtual hardware (unless one starts directly mapping in pci or usb
devices ...)

> Similar problem would be found if one wanted to find a desirable kernel
> config for a remote system. One should be able to somehow scrape some
> hardware information, dump that to a file, and then somehow generate
> a working config for that system.

Yes. That's actually pretty much the same usecase (in my case I'd also
have dts, lspci/lsusb output, etc)

> The module attribute being suggested would enable at least one way
> to gather some of the required config symbols: symbols for *hardware*
> and where one can run a modern kernel, with many features / hardware
> enabled already.

But only for a pretty specific usecase. I'm not opposed to this, but
I wonder whether maintainers are willing to accept that stuff for just
that specific usecase.

> However, folks producing embedded systems *do* / *should* have a lot of
> knowledge of their systems, and so the type of scheme you have devised
> seems sensible for it.

Usually we have (unless we need to do reverse engineering :o). But it's
a pretty time-consuming task. Especially if the requirements change
several times in the development or lifetime of a specific product.

For example "oh, we now need eth", "naah, we don't wanna use usb
anymore", "let's take a different SoM", ... not that have pretty
orthogonal sets of configs we need to maintain: hardware- and non-
hardware-related ones. And hardware-related ones can fall into different
categories like fixed-attached/onboard vs. hotpluggable ones.

Recently I had a case where the customer requested xattr support, so
I had to enable general xattr support as well as per-filesystem.
Pretty simple, but having lots of those cases quickly sums up. One of
the reasons why I've written my own little config generator.

>> In embedded world, we often have scenarios where we want a really
>> minimal kernel, but need to enable/disable certain hi-level peripherals
>> in the middle of the project (eg. "oh, we also need ethernet, but we
>> wanna drop usb"). There we'll have to find out what actual chip is,
>> its corresponding driver, required subsystems, etc, and also kick off
>> everything we don't need anymore.
> 
> Right. One *should* be able to tell some tool, hey, here is the list of
> my desirable .config options. Go and figure out what I need to make that
> work and give me a resulting .config. Its not easy.

I think I've already got into a pretty usable state - at least for my
projects. For now only supports a few boards and limited set of
features, but patches are always welcomed :)

>> I've thought about implementing some actual dependency tracking
>> (at least recording the auto-enabled symbols), but didn't expect that
>> to become practically usable anytime soon,
> 
> The ability to easily ask the kernel to enable the components needed
> for a respective config option *is* very useful but indeed not easy.

Yes, it would need to understand things like conditional definitions
to deduce that certain things need to be enabled first, before certain
drivers become choosable.

> This is not the only space where this problem exists. Similar problem
> exists for distribution packages, and dependencies. Challenges have
> been made for proper research towards these problems, and such research
> has lead distributions to opt to enable some of these algorithms.

The problem w/ dependencies is that there can be different types of
dependencies, as well as different types of software objects. Just
solving the expressions is only a part of the problem.

> This begs the question if we could learn from similar efforts on Linux
> for these sorts of questions. One possibility here is to evaluate the
> prospect of using a SAT solver with Minimally Unsatisfiable Subformulas
> (MUSes) support, which should be be able to address thir problem. This
> prospect is ongoing and currrent R&D is active, for details refer to:
> 
> https://kernelnewbies.org/KernelProjects/kconfig-sat

Good tip, I'll have a look at it.

> It certainly can be useful for components, ie, not hardware. But for
> hardware a one-to-one mapping of one driver to one config would be of
> much more use.

Unfortunately, we don't have this 1:1 mapping. Often drivers support
different sets of devices, depending on other factors, sometimes sub-
options (eg. different hw versions), sometimes depending on other
subsystems, sometimes arch-specific, etc, etc.

I think we should work towards that, but I doubt we'd reach that goal
anytime soon, and begs the question whether it's really worth all the
effort required for that.

> It would be wonderful if for instance kconfig
> supported a way to group a major set of components under *one* config
> symbol and then say: "I want this major component enabled" and then it'd
> go and enable all the defaults which would be required for it. 

Yes, thought about that, too. For example have syms for selecting whole
boards and features of them - a bit like this:

  --> Preconfigure for specific boards
      --> board A
      --> board B
      ...
  --> Enable board features
      --> Ethernet port
      --> Display
          --> Touch panel
      --> Audio
      ....

BUT: this would turn into maintenance hell, so I dropped that idea.

> An example is if you
> wanted to enable PCI on a system which didn't support it. Because of
> this, it seems you'd want *all* desirable configs and let a piece of
> software figure out what you need / can enable. And.. this is precisely
> where the SAT solver with MUSes could help...

Yes, but this piece of software first needs to know whether eg. PCI
is available on that HW. Oh, and things like PCI could be a dependency
as well as an feature on its own, depending on how you gonna use it.
(eg. if directly access from userland or VMs).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
