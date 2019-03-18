Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C422075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRJYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:24:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfCRJYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:24:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0CDDAD93;
        Mon, 18 Mar 2019 09:24:33 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
        <mvmimwotn60.fsf@suse.de>
        <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
X-Yow:  Are you still an ALCOHOLIC?
Date:   Mon, 18 Mar 2019 10:24:33 +0100
In-Reply-To: <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
        (Yash Shah's message of "Fri, 15 Mar 2019 17:19:59 +0530")
Message-ID: <mvmbm28r0vi.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 15 2019, Yash Shah <yash.shah@sifive.com> wrote:

> Use the open-source FSBL from:
> https://github.com/sifive/freedom-u540-c000-bootloader
>
> Modify the fsbl/ux00_fsbl.dts file and re-build the fsbl.bin

That doesn't even compile.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
