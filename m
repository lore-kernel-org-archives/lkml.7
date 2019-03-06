Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1C20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfCFLIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:08:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:42486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfCFLIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:08:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06D25B9BB;
        Wed,  6 Mar 2019 11:08:12 +0000 (UTC)
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
X-Yow:  I've got an IDEA!!  Why don't I STARE at you so HARD,
 you forget your SOCIAL SECURITY NUMBER!!
Date:   Wed, 06 Mar 2019 12:08:12 +0100
In-Reply-To: <20181020101045.15991-1-paul.walmsley@sifive.com> (Paul
        Walmsley's message of "Sat, 20 Oct 2018 03:10:44 -0700")
Message-ID: <mvmr2bkxntv.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to log in on the serial console causes the system to freeze.  The
last message is:

[  115.597858] sifive-serial 10010000.serial: BRKINT/PARMRK flag not supported

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
