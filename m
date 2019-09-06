Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EAE2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbfIFGO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:14:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfIFGO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:14:28 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i67Vq-0000KK-JT; Fri, 06 Sep 2019 08:14:26 +0200
Date:   Fri, 6 Sep 2019 08:14:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Biggers <ebiggers@kernel.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com>
Subject: Re: WARNING in posix_cpu_timer_del (3)
In-Reply-To: <20190906044954.GF803@sol.localdomain>
Message-ID: <alpine.DEB.2.21.1909060813320.1902@nanos.tec.linutronix.de>
References: <0000000000009b6b880591a8b697@google.com> <20190906044954.GF803@sol.localdomain>
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

On Thu, 5 Sep 2019, Eric Biggers wrote:
> On Tue, Sep 03, 2019 at 09:38:07AM -0700, syzbot wrote:
> > Rebooting in 86400 seconds..
> 
> FYI, this is still reproducible on latest linux-next (next-20190904).

Yes because the fix did not make it into -next yet. Will be there tomorrow.
