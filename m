Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6792F206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfCZVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:19:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfCZVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:19:29 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tSr-0006XE-Fg; Tue, 26 Mar 2019 22:18:33 +0100
Date:   Tue, 26 Mar 2019 22:18:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 08/14] watchdog/hardlockup: Decouple the hardlockup
 detector from perf
In-Reply-To: <1551283518-18922-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262213470.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-9-git-send-email-ricardo.neri-calderon@linux.intel.com>
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

On Wed, 27 Feb 2019, Ricardo Neri wrote:
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Detect hard lockups on a system
> + *
> + * Copyright (C) Intel Corporation 2019
> + *
> + * Note: All of this code comes from the original perf-specific hardlockup
> + * detector.

And because you copied it from there without modification this becomes
automatically Copyrighted by Intel?

May I recommend that you talk to your legal departement about this.

Aside of that there is really no value in creating yet another file. The
code in question can simply wrapped into a large #ifdef PERF in the old
file.

Thanks,

	tglx


