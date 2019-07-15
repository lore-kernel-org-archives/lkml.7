Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AEEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D98214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfGOJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:25:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:25:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hmxEd-0007ea-Ri; Mon, 15 Jul 2019 11:25:27 +0200
Date:   Mon, 15 Jul 2019 11:25:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mike Lothian <mike@fireburn.co.uk>
cc:     thomas.lendacky@amd.com, bhe@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        luto@kernel.org, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to
 be reserved
In-Reply-To: <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com> <20190713145909.30749-1-mike@fireburn.co.uk> <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de> <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de> <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
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

On Mon, 15 Jul 2019, Mike Lothian wrote:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

> That build failure is from the current tip of Linus's tree
> 
> If the fix is in, then it hasn't fixed the issue

Sorry, my bad. There was a very similar issue and I confused the two:

  013c66edf207 ("Revert "x86/build: Move _etext to actual end of .text"")

The reverted commit caused a build fail with gold as well. Let me stare at
your issue.

Thanks,

	tglx
