Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562B620856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfCZIpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:45:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E22E9AC4B;
        Tue, 26 Mar 2019 08:44:57 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de>
        <CAJ2_jOFuw2uu7Et1cOkKpaEwVofR5nD_v-rkOgFZbACK4BvHhg@mail.gmail.com>
X-Yow:  O.K.!  Speak with a PHILADELPHIA ACCENT!!  Send out for CHINESE FOOD!!
 Hop a JET!
Date:   Tue, 26 Mar 2019 09:44:57 +0100
In-Reply-To: <CAJ2_jOFuw2uu7Et1cOkKpaEwVofR5nD_v-rkOgFZbACK4BvHhg@mail.gmail.com>
        (Yash Shah's message of "Tue, 26 Mar 2019 12:15:11 +0530")
Message-ID: <mvmva06t46u.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 26 2019, Yash Shah <yash.shah@sifive.com> wrote:

> 'On Mon, Mar 25, 2019 at 9:24 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>>
>> I still don't see any improvement.  FYI, this is the patch I use for the
>> device tree:
>>
>
> I am sharing you my test environment which has been working for me so
> that you can duplicate at your end

Please test your driver with the DT as above.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
