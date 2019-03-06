Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F46C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7782420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCFPoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:44:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfCFPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:44:43 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1Yin-0006ul-EA; Wed, 06 Mar 2019 16:44:41 +0100
Date:   Wed, 6 Mar 2019 16:44:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cpu/hotplug: Create SMT sysfs interface for all arches
In-Reply-To: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com>
Message-ID: <alpine.DEB.2.21.1903061633010.1646@nanos.tec.linutronix.de>
References: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com>
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

Josh,

On Fri, 1 Mar 2019, Josh Poimboeuf wrote:
> Make the /sys/devices/system/cpu/smt/* files available on all arches, so
> user space has a consistent way to detect whether SMT is enabled.
> 
> The 'control' file now shows 'notsupported' for architectures which
> don't yet have CONFIG_HOTPLUG_SMT.

Yes, that makes sense.

<SNIP>

Nice work!. I'll pick it up and queue it for 5.2.

Thanks,

	tglx





