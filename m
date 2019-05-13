Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871ED21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfEMOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbfEMOPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:15:54 -0400
Received: from oasis.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4136C20862;
        Mon, 13 May 2019 14:15:52 +0000 (UTC)
Date:   Mon, 13 May 2019 10:15:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        'christophe leroy' <christophe.leroy@c-s.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
Message-ID: <20190513101550.736fb5f6@oasis.local.home>
In-Reply-To: <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
References: <20190510081635.GA4533@jagdpanzerIV>
        <20190510084213.22149-1-pmladek@suse.com>
        <20190510122401.21a598f6@gandalf.local.home>
        <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
        <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
        <20190513091320.GK9224@smile.fi.intel.com>
        <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 14:42:20 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > The "(null)" is good enough by itself and already an established
> > practice..  
> 
> (efault) made more sense with the probe_kernel_read() that
> checked wide range of addresses. Well, I still think that
> it makes sense to distinguish a pure NULL. And it still
> used also for IS_ERR_VALUE().

Why not just "(fault)"? That is self descriptive enough.

-- Steve
