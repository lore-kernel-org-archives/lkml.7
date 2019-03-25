Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D0D20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfCYK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:59:40 -0400
Received: from foss.arm.com ([217.140.101.70]:45372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfCYK7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:59:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098301596;
        Mon, 25 Mar 2019 03:59:39 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA7883F575;
        Mon, 25 Mar 2019 03:59:36 -0700 (PDT)
Subject: Re: [PATCH v6 04/10] arm64: Advertise mitigation of Spectre-v2, or
 lack thereof
To:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        julien.thierry@arm.com, mlangsdo@redhat.com, stefan.wahren@i2e.com,
        andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
References: <20190321230557.45107-1-jeremy.linton@arm.com>
 <20190321230557.45107-5-jeremy.linton@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3a642196-4c6c-9efe-946b-9d6ecf33c9e3@arm.com>
Date:   Mon, 25 Mar 2019 10:59:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321230557.45107-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2019 23:05, Jeremy Linton wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> We currently have a list of CPUs affected by Spectre-v2, for which
> we check that the firmware implements ARCH_WORKAROUND_1. It turns
> out that not all firmwares do implement the required mitigation,
> and that we fail to let the user know about it.
> 
> Instead, let's slightly revamp our checks, and rely on a whitelist
> of cores that are known to be non-vulnerable, and let the user know
> the status of the mitigation in the kernel log.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> [This makes more sense in front of the sysfs patch]
> [Pick pieces of that patch into this and move it earlier]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
