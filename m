Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF73C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD92082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCEIcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfCEIcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:32:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 796C2B034;
        Tue,  5 Mar 2019 08:32:07 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v8 0/2] PWM support for HiFive Unleashed
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
        <mvmfts228vu.fsf@suse.de>
        <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
X-Yow:  Either CONFESS now or we go to ``PEOPLE'S COURT''!!
Date:   Tue, 05 Mar 2019 09:32:06 +0100
In-Reply-To: <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
        (Yash Shah's message of "Tue, 5 Mar 2019 13:55:41 +0530")
Message-ID: <mvmlg1tzpq1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 05 2019, Yash Shah <yash.shah@sifive.com> wrote:

> On Mon, Mar 4, 2019 at 4:39 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Mär 01 2019, Yash Shah <yash.shah@sifive.com> wrote:
>>
>> > This patch series adds a PWM driver and DT documentation
>> > for HiFive Unleashed board. The patches are mostly based on
>> > Wesley's patch.
>>
>> That doesn't appear to work with the heartbeat trigger, the led doesn't
>> flash.
>
> Make sure you modify the DTS file

Which DTS file?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
