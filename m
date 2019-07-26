Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ECC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8542070B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfGZOxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:53:16 -0400
Received: from foss.arm.com ([217.140.110.172]:45848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfGZOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:53:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90873152D;
        Fri, 26 Jul 2019 07:53:14 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A35F3F71F;
        Fri, 26 Jul 2019 07:53:12 -0700 (PDT)
Subject: Re: [PATCH v9 0/8] EDAC drivers for Armada XP L2 and DDR
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        jlu@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
From:   James Morse <james.morse@arm.com>
Message-ID: <d1dfe8ec-66e8-e2c8-5421-a18d7e7fc8fc@arm.com>
Date:   Fri, 26 Jul 2019 15:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 12/07/2019 04:48, Chris Packham wrote:
> I still seem to be struggling to get this on anyone's radar.

Whose radar does it need to cross?


> The Reviews/Acks have been given so this should be good to go in via the ARM
> tree as planned.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.html

For your v8 I took this to mean this series was done!

If nothing has changed with Boris and Russell's decision (it was two years ago....),
details of the patch system are here:

https://lore.kernel.org/linux-arm-kernel/20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk/


Thanks,

James
