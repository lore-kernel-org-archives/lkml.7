Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF271214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCLKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfCLKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA9B1AC24;
        Tue, 12 Mar 2019 10:14:15 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
X-Yow:  It's OKAY --- I'm an INTELLECTUAL, too.
Date:   Tue, 12 Mar 2019 11:14:15 +0100
In-Reply-To: <1552378289-27245-1-git-send-email-yash.shah@sifive.com> (Yash
        Shah's message of "Tue, 12 Mar 2019 13:41:27 +0530")
Message-ID: <mvmimwotn60.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 12 2019, Yash Shah <yash.shah@sifive.com> wrote:

> This patch series adds a PWM driver and DT documentation
> for HiFive Unleashed board. The patches are mostly based on
> Wesley's patch.

Heartbeat trigger still doesn't work for me.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
