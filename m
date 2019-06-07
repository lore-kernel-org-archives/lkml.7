Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0DBC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87D420684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfFGJjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:39:49 -0400
Received: from foss.arm.com ([217.140.110.172]:36606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfFGJjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:39:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D64367;
        Fri,  7 Jun 2019 02:39:48 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3403F96A;
        Fri,  7 Jun 2019 02:41:28 -0700 (PDT)
Subject: Re: [PATCH v2] x86/resctrl: Don't stop walking closids when a
 locksetup group is found
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>, stable@vger.kernel.org
References: <20190603172531.178830-1-james.morse@arm.com>
 <20190606130802.DD95D20684@mail.kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <fe2ceae9-9aeb-bad5-ed24-ca80f0297cf3@arm.com>
Date:   Fri, 7 Jun 2019 10:39:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606130802.DD95D20684@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/06/2019 14:08, Sasha Levin wrote:
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: dfe9674b04ff x86/intel_rdt: Enable entering of pseudo-locksetup mode.
> 
> The bot has tested the following trees: v5.1.7, v5.0.21, v4.19.48.

> v5.1.7: Failed to apply!  Possible dependencies:>     7390619ab9ea ("x86/resctrl: Move per RDT domain initialization to a separate function")
> 
> v5.0.21: Failed to apply! Possible dependencies:
>     7390619ab9ea ("x86/resctrl: Move per RDT domain initialization to a separate function")
That's cleanup, I don't think you want for stable. I'll do a backport.


> v4.19.48: Failed to apply! Possible dependencies:
>     2a7adf6ce643 ("x86/intel_rdt: Fix initial allocation to consider CDP")

This one changed an adjacent line.


>     723f1a0dd8e2 ("x86/resctrl: Fixup the user-visible strings")
>     7390619ab9ea ("x86/resctrl: Move per RDT domain initialization to a separate function")

> How should we proceed with this patch?

I'll come up with backports for v5.1.x/v5.0.x and v4.19.x once this reaches mainline.


Thanks,

James
