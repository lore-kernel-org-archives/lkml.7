Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D471C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E820840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCGWP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:15:59 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:15:59 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mhnnc-1gX4CG0lea-00dryB; Thu, 07 Mar 2019 23:11:28 +0100
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
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
References: <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
 <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
 <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net>
 <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com>
 <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net>
 <20190307205505.GB30028@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5e558126-9038-1ca5-4519-7b5864ca9fa1@metux.net>
Date:   Thu, 7 Mar 2019 23:11:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307205505.GB30028@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uNHDc1vwsilvfnytZZnjZFhbo4iFIljuaLhsiywyHRse+80WyM/
 GnHSLC3p+pyS0Y+KVzPihft8B0zjDsqIl4K8S2WQKujpbBBUejz/ZcWcCkdGs+Enrm7rGv8
 1Nh92C0QcQDhiU2gtnl7lweLMH+jkRb5qGg0lo5NVtIqEncLBEfXBz11YYV9KFChfkFeGS6
 2titgnjdKx5r3HAPOqQlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kfCuygT8KeE=:roVvJS4UdsEyGwhMLrOlRd
 2FamOXbZvtvugZFhyFsSBEhT00sh9MgzJNxhLZoKM+WGMYkc6VCGUetfafElfybAvWvFiwibj
 QHjaEvb3GGuabd7+hrsUJvP9XZC9HCwaJJ0Mn/gGOVVMeF4pzry0gTSJoTtUb02VLqqcf3vyA
 DckiN4rV3XNfOvHzXsxAAX+UAUJgRM+MAF6voqhgN2iH4agHil0DQ2IMojjViTN+Orw0CJGsO
 mvTKGkNauJ+AZPXvzZ+wNvU4l7gqbP5ufmUNePYZ2+jHWUrEyTfPGhLRN8/iipRXgQIuC6/Yg
 h/2TlY37C17y7a9JccaJvXhqznHJZudBPQvi3bHfUqVUIS9XSEIlPsfeoDr6iUvsPRQsiay4J
 gUPE+7x4f3LMHI7QJ3q5E0H39x1x8Fno1OwnJUSVb1Td0eF7J79QPQKk5aEyJDD+fFf2fXvEb
 qnXlZDNyEjK4WKMAdpZA7ztX0/T3yDLcw+MjhhEHnD0ccXXBmksJ9aSdRBmmcP80r+Z1p2IPV
 SNe5Iun6B+ZoYve1fHVacyOLJjO1ii+LnQ+On5DSfD6Zhz8jCrt6KU+JLihrwJAj+UzW3sbcn
 rqLD3RfXWdeV5BhL8H/E2qeEkoJ2N7JAfALKmZXNnsjb1o5qEjsn/pLhJmKKswnUadRKtGTqm
 C5Gqq9W6kwtlyfVwCKGvwJH6EI4xQzQsurRUgqArS5Nmo+qhQIGMKX0KhiX8Jfrpqr7U9pZck
 gsUtK3ehX066ALq85L0FGGXqj8ZAZG9pSuL4TrAC0HglFNSZizQpzEaBExEd/6pT6snuql4xd
 zHFlHwmv4TbwbPISDHSQ39C+YUywuMQ0T0218X5C2VmK3vyt8Yw7eKhJo3oYN8uz91FhkDd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 21:55, Greg KH wrote:

> Ick, no, no more squashfs please, let's just kill that mess once and for
> all :)

okay, then: s/squashfs/whatever_fs_image_or_archive_you_like/;

> Again, putting this in a simple compressed tar image allows anyone to do
> whatever they need to with this.  If they want a full filesystem,
> uncompress it and use it there.  If they just want it in-memory where
> they can uncompress it and then discard it, that works too.

And let me stress the point: doesn't need any kernel changes at all,
when it's just a file in the same place where the .ko's live.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
