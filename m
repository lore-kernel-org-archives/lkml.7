Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE44C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FC9208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfH3GBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:01:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52241 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3GBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:01:44 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3Zyb-0004ue-GG; Fri, 30 Aug 2019 08:01:37 +0200
Date:   Fri, 30 Aug 2019 08:01:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>,
        kbuild-all@01.org, linux-tip-commits@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [tip: timers/core] itimers: Use quick sample function
In-Reply-To: <201908300744.vEL0XoT5%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.1908300748100.1938@nanos.tec.linutronix.de>
References: <156698738074.5699.15444340345912474204.tip-bot2@tip-bot2> <201908300744.vEL0XoT5%lkp@intel.com>
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

On Fri, 30 Aug 2019, kbuild test robot wrote:

> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190829]

Of course not. Because the patch is already in v5.3-rc6 next-20190829

> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]

I did so several times now and so did Borislav.

Can you please stop applying random patches from tip-bot2 notifications
which are part of a larger series and if applied alone obviously fail
because the prerequisite patches fail?

tip-bot2 mails are notifications that a patch has been merged into a branch
of the tip tree. They contain the information in which branch these patches
are applied so please start testing that branch in the proper order or
ignore tip-bot2 completely.

I really value your service, but recently the usefulness to noise ratio has
degraded massively.

Thanks,

	tglx
