Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0524C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A669214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbfDRTR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:17:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37933 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:17:56 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHCXh-000344-6O; Thu, 18 Apr 2019 21:17:53 +0200
Date:   Thu, 18 Apr 2019 21:17:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        thomas.lendacky@amd.com
Subject: Re: [5.0.0 rc3 BUG] possible irq lock inversion dependency
 detected
In-Reply-To: <CABXGCsP414BbijQQ+NJkCV83zdCKcfCyR0NBwyor6z3T8CawDg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904182116450.3174@nanos.tec.linutronix.de>
References: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com> <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com> <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de> <CABXGCsNaw=mb0YF4Bkd5_CTwMfU=dNZ=RTV96dwO=UQy=n_gOQ@mail.gmail.com>
 <CABXGCsP414BbijQQ+NJkCV83zdCKcfCyR0NBwyor6z3T8CawDg@mail.gmail.com>
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

On Thu, 18 Apr 2019, Mikhail Gavrilov wrote:
> On Mon, 15 Apr 2019 at 01:07, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> > How should we proceed with this patch?
> 
> So I wonder is any further actions are required for merging patch to mainline?

You also received automated mail that it is queued in the x86/urgent branch
which is targeted for 5.1-rc6. So nothing to do for you.

Thanks,

	tglx
