Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7921850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfDEOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:14:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfDEOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:14:33 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCPbr-0003zb-US; Fri, 05 Apr 2019 16:14:24 +0200
Date:   Fri, 5 Apr 2019 16:14:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 07/21] x86/io: Remove useless definition of mmiowb()
In-Reply-To: <20190405135936.7266-8-will.deacon@arm.com>
Message-ID: <alpine.DEB.2.21.1904051613500.1802@nanos.tec.linutronix.de>
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-8-will.deacon@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019, Will Deacon wrote:

> x86 maps mmiowb() to barrier(), but this is superfluous because a
> compiler barrier is already implied by spin_unlock(). Since x86 also
> includes asm-generic/io.h in its asm/io.h file, we can remove the

s/we can//

> definition entirely and pick up the dummy definition from core code.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
