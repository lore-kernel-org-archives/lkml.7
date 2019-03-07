Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6909CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370BE20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCGQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:27:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:45283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:27:49 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MekvV-1gTgrc1AQP-00aiib; Thu, 07 Mar 2019 17:24:25 +0100
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Joel Fernandes <joel@joelfernandes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Daniel Colascione <dancol@google.com>, Pavel Machek <pavel@ucw.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
 <20190307014251.GA184167@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <8c76dd7d-5964-9704-ba3a-0ea56b6a558c@metux.net>
Date:   Thu, 7 Mar 2019 17:24:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307014251.GA184167@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QvywTqOd1uNPR7K2X4O10MRv5nFc+u0oD7vtETqPVHY0lVKZkvC
 g8tS/bm3n2XEPK8b3qRte7/JJb2AzVSJxe0EuMtb7lOkQZ9wdcodanuzJKlZk7MhQraIOTo
 VoA4jxjMFud3P//TlHYcmqP04EJwMthMuhIdGgJ/GEKFm4/7IVZZr/S7/YcEDwFQRMTC6aY
 rUYLPzr5FByUvt+cMoHfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wtkf7o79wFE=:0I10qi2Oa9B5YCxYn6A0jx
 F+cNDJHZFh+w5g5M3JIAOGNfFiOU3/zkFqynB8OLTOPYkE7xCpCKMBkYHvbJd8Jxspxbd3/ip
 xgbGA31j0i0+HNdExGjirNvWX81DfR5kdcfYKZTpYBztmuoadjscfkIILt6gKFiqejZ59hGUJ
 S69f/FKwV4hnx1jGUW0k6TKBn6GhT8zGXbB/Pctmlf0nruA6laxSBlzoo4bSyl1ZehXG9F7b2
 KfmmsCNfYVPoDrRMX+wWxvCKUTWezuckMfYzf9OAB+lnhvm9RYmVKMS/G43C4ucmJH4Ut5KnW
 JtibTRsqAmbLZnvXQkYGKmJeCQc1ZT7w6T6zy4zgHQWv+BfnP/v1qpZ3/HlxsJwWB8U82Zb3G
 1YXpt8RCZwi6vMxBVX/M+leJuR+Abl1EiVeeFiTQ56EEiCizub3FXaMU9XdRi9yuf7Z1jvdjP
 facYExHr+/xA2AZT1Iy8C1b+EjOqcf128j93kNYUVxOrjXf5KMifGMtvLakyb+dMiMWUb2Jtt
 3v2lnPudJKLKt6gLT2v/ttn++w+6C28qPewBvFc8lH2JUJPhJsCAX4cNsoDKL2ExIB03a7VuQ
 s5CXh1frchXRwHIgbxco+mdDEcF4nTTwNVNwQW0KvlDGCazAGI5fvGhIi+hdemVGimpewPOYE
 9AjWsEwrPBGmeoM/k4qXH2V62UlAqIzkOetP/UMqEoDOzRGuIxhSsArej7/l9izz+eBnSVpog
 iHGyu/JKMhnafsEQLMxwX2mHKw1NdT8CsI6l/NFsZSLMGXdQkQvz3LQqzgk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 02:42, Joel Fernandes wrote:


Speaking as an embedded linux architect, who's daily job for a large
part is to getting bootloader, kernel, userland and customer
applications play nice together, in a stable, secure and easily
maintainable way:


> They would include the module because we can enforce that certain> config options in the kernel need to be enabled for Android features
to work.

Ok, but then you could also enforce them to simply put a tarball to the
module directory.

The modules need to built and deployed together with the kernel image
itself anyways, as well as they need to live on some filesystem that
has to be mounted at runtime. So, putting a tarball there is obvious
and trivial. No need to invent extra tools to build and use that stuff,
don't even need to touch the kernel source for that.

> As I said in previous posts, some people want to boot a kernel image without> any update to FS, for debug purposes.

So, it's just a workaround for your weird build/deployment mechanisms ?
(sorry, but I've got a hard time containing myself from starting a
really big rant against the Android architecture and build/deployment)

> In the Android/embedded world,> developers want to build and boot a single binary blob (for debugging).

Maybe in Android world (I didn't touch this for aeons - I'm just too
lazy add another hdd for it and wait days for everything pulled and
compiled), but in embedded world (speaking of: industrial machinery,
power plants, freighter ships, locomotives, medical devices or even
TV sets - that's the stuff I'm doing all the day), we usually either
build and deploy full system images (including the whole userland)
or use package management (eg. dpkg, ipkg, etc).

For me, as an embedded linux architect, the whole idea of having the
kernel have a completely different lifecycle process (even from a
completely different vendor) than the userland, is a really weird idea.

[ Yes: I've sometimes got customers with similar weird ideas (like BSP
coming from the board vendor, as a binary image, and they "just" put
their application ontop), but sooner or later this heavily crashes
against the wall, and then I can teach them how to do it right. ]

> Once they are done debugging, they can switch the CONFIG option back to> module instead of building it in and consuming memory, so that it is
not> loaded into memory until needed.
Okay, if it's just for debugging (in the lab, not in the field), then
why not fixing your development environment ? Why do you need that very
android specific stuff mainlined ?

Quite frankly: the whole thing really reminds me to the folks who wanna
push desktop bus into the kernel, just because their strange init system
is entirely based on that and they've created some nasty circular
dependencies. Please not yet another flamewar of that kind.

IMHO, you've got a serious architectural userland and development
environment problem (the massive problem of many millions completely
unmaintained and insecure devices in the field comes from exactly
that. Begins with the same fundamental mistakes which MS also still
refused learn, over decades - lack of a decent package management).

I doubt that workarounds in the kernel are good solution to that.

>> 3. Use a squashfs image instead of an archive.>
> This point number 3 sounds like a non-starter because it will make the kernel
> build system fail if squashfs-tools is not available. 

apt-get install squashfs-tools ?

Sorry, but the whole Android build machinery is so *extremly* huge,
that adding yet another tiny tool, which is in all relevant distros
for  aeons, really shouldn't be a problem worth even talking about.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
