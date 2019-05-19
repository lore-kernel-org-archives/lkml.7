Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DA7C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044F120675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfESSGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:06:09 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:41984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727623AbfESSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:06:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id DC7AE182D7B29
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 05:07:55 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7428837F24A;
        Sun, 19 May 2019 05:07:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: money15_44f87b89aa330
X-Filterd-Recvd-Size: 1863
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 May 2019 05:07:53 +0000 (UTC)
Message-ID: <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
From:   Joe Perches <joe@perches.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Sat, 18 May 2019 22:07:52 -0700
In-Reply-To: <20190518210037.13674-1-paul.walmsley@sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> The RISC-V architecture has a register named the "Supervisor Exception
> Program Counter", or "sepc".  This abbreviation triggers
> checkpatch.pl's misspelling detector, resulting in noise in the
> checkpatch output.  The risk that this noise could cause more useful
> warnings to be missed seems to outweigh the harm of an occasional
> misspelling of "spec".  Thus drop the "sepc" entry from the
> misspelling list.

I would agree if you first fixed the existing sepc/spec
and sepcific/specific typos.

arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register


