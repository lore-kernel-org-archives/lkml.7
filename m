Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9D20842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfCGBZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:25:39 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCGBZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:25:38 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MhlCg-1gX1l51mr2-00dotm; Thu, 07 Mar 2019 02:22:59 +0100
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Daniel Colascione <dancol@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
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
 <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net>
Date:   Thu, 7 Mar 2019 02:22:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6swaBrmdOtKyStgzefBtaJvrQ/G1ygCASH7FQKPujuq2ntSpB2K
 pPrgRD7taWECi9OILna5x315j0I3BNV3zOCyxpvKI36jRp6rOQjP9ZQwjbEg1J7p0zH+yNy
 yQZUxxGU12ftn88SraxyG0Npff4NqhmAklpwcK8Fhy34BRUhHRDW4i/DfCS3hnYyfErZITt
 SYM23+oxl/4SfaEGCbBSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eQEu1S8QLu8=:PpCvODzuiFdAoA5nSbVvLj
 ty+U7oGcir6yr/IsVQF+ao9bI+UN8EDHOB7vYKwAlvCsED/5v85YpbDdL0+6LgPieQSR4BnUt
 SnHX5S2FjopLutDWYw69Uvp7tGB1kIUDjgPgfO/otRkJ8AqRQnTW38dBTdZv9R8+PG0XKQ04M
 8sF84DPNPd428caBOq3ey3qYLIMbaRv8PJ4jbMhOMaYxyIOm3V9pfhOnURA3NSaB2Ktm6UK+R
 m/mfED3WHSgfrQul3oCHhKM+T13PIPuXScDBbcuxz9kFzEhs+4YLgeHN6XjW6kx3l0NY58e86
 0iU7p6kiUj4Kd3iJ6XAoKLELJ8DoddaUfglefBuPFI12aOtxevUOn/13nCn9whe+TqzuvaaJw
 s2A/i/+C3QDOKvE0yIomfPEphYWuc/pvONomheF3HE9HwcbvBI9BKByA+tQ+cVcuOSSza3Cbm
 EqmJ7xysZ38MKdYNrzs2jPR8lwaNNcb+D0+gJrBqVQIT7LYlf3n4jlj09ah8E6V5LxQAKFCHq
 wSthuWd4yfCHPev/JZ1qe43X+C7kwraUSQ/2LOgzS+iWZV4pLQfYhOFJWf8WA2vTXeQ+iw/p+
 jZAczvYZi+O2w3nJoBl8vxKkpcjW/mlDopeN7hDD4ecfYImH8D83yANm/SkVLmDXQSfakMyY8
 qLnudDtSEjhizvu4Qa5Qtoo5s2YH6XiW6o+ZGsUyDrItDP1vixqCW6HN3zCHXdRaLIkMXI270
 GBRw8Q0nKC67bJNL5leg6KzskEfmcItwNnXBpeaSX/7I4yeIJWEtr7o10IY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 01:33, Daniel Colascione wrote:

> *There* *may* *be* *no* *filesystem*. 

A Linux system w/o any filesystem at all ? Well, that's interesting.

> The only thing the kernel can really guarantee is its own> existence --- it should be entire in itself.

I vaguely recall some option for linking in an initrd ... does this
still exist ?

> If I'm hacking on an> Android kernel and say "fastboot boot mykernel" without making any>
changes to the device's boot filesystem, I should still be able to use>
tracing tools that rely on knowing the headers for the kernel with

Fix fastboot to support initrd or use a remote filesystem ?

I'm doing embedded development all the day, and one of the first things
I usually set up for a project is an fully automatic netboot (or at
least usb boot). Shouldn't be so hard, and is a more generic solution.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
