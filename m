Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5675F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfHZPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:12:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbfHZPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:12:18 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2GfF-00079X-KF; Mon, 26 Aug 2019 17:12:13 +0200
Date:   Mon, 26 Aug 2019 17:12:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Len Brown <len.brown@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v2-resend] MAINTAINERS: mark simple firmware
 interface (SFI) obsolete
In-Reply-To: <20190825173053.5649-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.1908261706460.1939@nanos.tec.linutronix.de>
References: <20190825173053.5649-1-lukas.bulwahn@gmail.com>
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

Lukas,

On Sun, 25 Aug 2019, Lukas Bulwahn wrote:

> Len Brown has not been active in this part since around 2010. The recent
> activity suggests that Thomas Gleixner and Jiang Lui were maintaining
> this part of the kernel sources. Jiang Lui has not been active in the
> kernel sources since beginning 2016. So, the maintainer's role seems to
> be now with Thomas.

Nice try. All I did there was converting the existing code to new
interfaces and to use SPDX identifiers. You touched it last, you own it, is
not really working.

TBH. I have no clue what that is except that it's bitrotting.

>  SIMPLE FIRMWARE INTERFACE (SFI)
> -M:	Len Brown <lenb@kernel.org>
> -L:	sfi-devel@simplefirmware.org
> +M:	Thomas Gleixner <tglx@linutronix.de>
>  W:	http://simplefirmware.org/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
> -S:	Supported
> +S:	Obsolete
>  F:	arch/x86/platform/sfi/
>  F:	drivers/sfi/
>  F:	include/linux/sfi*.h

So why not removing this whole entry. arch/x86/platform/sfi is already
covered by x86 and the driver cruft falls back to the people who are used
to deal with dead drivers anyway.

Thanks,

	tglx
