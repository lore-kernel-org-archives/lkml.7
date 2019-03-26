Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA797C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E392070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfCZRAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:00:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48906 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbfCZRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:00:11 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8pQl-0001wd-US; Tue, 26 Mar 2019 18:00:08 +0100
Date:   Tue, 26 Mar 2019 18:00:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Fixes and cleanup from LTO tree
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1903261756100.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org>
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

Andi,

On Thu, 21 Mar 2019, Andi Kleen wrote:

> Here are a range of bug fixes and cleanups that have accumulated in my
> gcc Link Time Optimization (LTO) branches; for issues found
> by the compiler when doing global optimization and a few
> other issues.
> 
> (https://github.com/andikleen/linux-misc lto-*)
> 
> IMNSHO they are all useful improvements even without LTO support.
> 
> About half of it is in x86 specific code, but the others are
> random all over. I tried to always copy the respective maintainers,
> but since it's (nearly) a tree sweep I'm also copying Andrew.

Can you please once and forever stop sending a random pile of patches which
are:

  - fixes independent of LTO
  - LTO required changes
  - RFC material

It's very clear where x86 related patches go through and it's also clear
that fixes have to be separate from features and other material.

You complain about maintainers being inresponsive and slow, but you are not
even trying to make their work easier by following the general process.

Thanks,

	tglx
