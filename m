Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68083C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42422206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfH0G6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfH0G6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E49E307D962;
        Tue, 27 Aug 2019 06:58:50 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E6AB196AE;
        Tue, 27 Aug 2019 06:58:49 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:x86/urgent 3/3] arch/x86/kernel/apic/apic.c:1182:6: warning: the address of 'x2apic_enabled' will always evaluate as 'true'
References: <201908270037.RmH8iN2a%lkp@intel.com>
        <jpgwoezgldx.fsf@linux.bootlegged.copy>
        <alpine.DEB.2.21.1908270849540.1939@nanos.tec.linutronix.de>
Date:   Tue, 27 Aug 2019 02:58:48 -0400
In-Reply-To: <alpine.DEB.2.21.1908270849540.1939@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 27 Aug 2019 08:50:56 +0200
        (CEST)")
Message-ID: <jpg8srf9jrr.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 27 Aug 2019 06:58:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 27 Aug 2019, Bandan Das wrote:
>> kbuild test robot <lkp@intel.com> writes:
>> 
>> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
>> > head:   cfa16294b1c5b320c0a0e1cac37c784b92366c87
>> > commit: cfa16294b1c5b320c0a0e1cac37c784b92366c87 [3/3] x86/apic: Include the LDR when clearing out APIC registers
>> > config: i386-defconfig (attached as .config)
>> > compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
>> > reproduce:
>> >         git checkout cfa16294b1c5b320c0a0e1cac37c784b92366c87
>> >         # save the attached .config to linux build tree
>> >         make ARCH=i386 
>> >
>> > If you fix the issue, kindly add following tag
>> > Reported-by: kbuild test robot <lkp@intel.com>
>> >
>> > All warnings (new ones prefixed by >>):
>> >
>> >    arch/x86/kernel/apic/apic.c: In function 'clear_local_APIC':
>> >>> arch/x86/kernel/apic/apic.c:1182:6: warning: the address of 'x2apic_enabled' will always evaluate as 'true' [-Waddress]
>> >      if (!x2apic_enabled) {
>> >          ^
>> Thomas, I apologize for the typo here. This is the x2apic_enabled() function.
>> Should I respin ?
>
>   https://lkml.kernel.org/r/156684295076.23440.2192639697586451635.tip-bot2@tip-bot2
>
> You have that mail in your inbox ..

Ah, thanks!
