Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DA9206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfH0GvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:51:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0GvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:51:04 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2VJh-0003tT-2y; Tue, 27 Aug 2019 08:50:57 +0200
Date:   Tue, 27 Aug 2019 08:50:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bandan Das <bsd@redhat.com>
cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:x86/urgent 3/3] arch/x86/kernel/apic/apic.c:1182:6: warning:
 the address of 'x2apic_enabled' will always evaluate as 'true'
In-Reply-To: <jpgwoezgldx.fsf@linux.bootlegged.copy>
Message-ID: <alpine.DEB.2.21.1908270849540.1939@nanos.tec.linutronix.de>
References: <201908270037.RmH8iN2a%lkp@intel.com> <jpgwoezgldx.fsf@linux.bootlegged.copy>
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

On Tue, 27 Aug 2019, Bandan Das wrote:
> kbuild test robot <lkp@intel.com> writes:
> 
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> > head:   cfa16294b1c5b320c0a0e1cac37c784b92366c87
> > commit: cfa16294b1c5b320c0a0e1cac37c784b92366c87 [3/3] x86/apic: Include the LDR when clearing out APIC registers
> > config: i386-defconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> > reproduce:
> >         git checkout cfa16294b1c5b320c0a0e1cac37c784b92366c87
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    arch/x86/kernel/apic/apic.c: In function 'clear_local_APIC':
> >>> arch/x86/kernel/apic/apic.c:1182:6: warning: the address of 'x2apic_enabled' will always evaluate as 'true' [-Waddress]
> >      if (!x2apic_enabled) {
> >          ^
> Thomas, I apologize for the typo here. This is the x2apic_enabled() function.
> Should I respin ?

  https://lkml.kernel.org/r/156684295076.23440.2192639697586451635.tip-bot2@tip-bot2

You have that mail in your inbox ..
