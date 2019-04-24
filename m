Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C32C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfDXWLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:11:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37130 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726611AbfDXWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:11:45 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3OMAbOB002770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 18:10:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D2E76420497; Wed, 24 Apr 2019 18:10:36 -0400 (EDT)
Date:   Wed, 24 Apr 2019 18:10:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
Message-ID: <20190424221036.GA12279@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181011225421.GA21093@beast>
 <20181012142902.GD2420@thunk.org>
 <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
 <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
 <20190416160948.GE3004@mit.edu>
 <CAGXu5jLexxSyX4cVz=LrvQ-RDVK+JRfyBJuqTn2UDgqyPiwvMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLexxSyX4cVz=LrvQ-RDVK+JRfyBJuqTn2UDgqyPiwvMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:20:58PM -0700, Kees Cook wrote:
> > Yeah, sorry, it got lost; my bad.  I'll take it and push it out at the
> > next merge window.
> 
> Gentle poke. :) I still don't see this in -next...

Oops, sorry, I pushed it out to the master branch, and I forgot that
the -next branch was pulling from the dev branch.   Fixed.

    	  	     	     	      - Ted
