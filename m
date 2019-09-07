Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19C206A5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406307AbfIGUo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:44:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404588AbfIGUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:44:59 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i6hZo-0001mK-TF; Sat, 07 Sep 2019 22:44:57 +0200
Date:   Sat, 7 Sep 2019 22:44:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Subject: Re: Linux 5.3-rc7
In-Reply-To: <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909072243570.1902@nanos.tec.linutronix.de>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com> <156785100521.13300.14461504732265570003@skylake-alporthouse-com> <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de> <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de> <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
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

On Sat, 7 Sep 2019, Linus Torvalds wrote:
> On Sat, Sep 7, 2019 at 8:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> So why wouldn't we just revert it?

That's what I just replied to Chris. Can you do it right away or should I queue it up?

Thanks,

	tglx
