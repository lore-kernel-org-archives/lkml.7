Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6854AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3FC2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfDKOp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF9F4AE1D;
        Thu, 11 Apr 2019 14:45:24 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
References: <20181020101045.15991-1-paul.walmsley@sifive.com>
        <mvmr2bkxntv.fsf@suse.de>
        <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com>
X-Yow:  I have nostalgia for the late Sixties!  In 1969 I left my laundry with
 a hippie!!  During an unauthorized Tupperware party it was chopped &
 diced!
Date:   Thu, 11 Apr 2019 16:45:24 +0200
In-Reply-To: <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com> (Paul
        Walmsley's message of "Thu, 11 Apr 2019 01:54:05 -0700 (PDT)")
Message-ID: <mvm1s28fvnf.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Wed, 6 Mar 2019, Andreas Schwab wrote:
>
>> Trying to log in on the serial console causes the system to freeze.  The
>> last message is:
>> 
>> [  115.597858] sifive-serial 10010000.serial: BRKINT/PARMRK flag not supported
>
> Have not seen that problem.

# stty sane -F /dev/ttySIF0
<crash>

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
