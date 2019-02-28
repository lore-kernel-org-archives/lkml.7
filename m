Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA82C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B261F21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfB1MB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:01:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46460 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfB1MB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:01:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DEA080D;
        Thu, 28 Feb 2019 04:01:27 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396723F738;
        Thu, 28 Feb 2019 04:01:25 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:01:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com, Andre.Przywara@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] arm64: add system vulnerability sysfs entries
Message-ID: <20190228120122.GB226495@arrakis.emea.arm.com>
References: <20190227010544.597579-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227010544.597579-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Tue, Feb 26, 2019 at 07:05:34PM -0600, Jeremy Linton wrote:
> Jeremy Linton (6):
>   arm64: Provide a command line to disable spectre_v2 mitigation
>   arm64: add sysfs vulnerability show for meltdown
>   arm64: Always enable spectrev2 vulnerability detection
>   arm64: add sysfs vulnerability show for spectre v2
>   arm64: Always enable ssb vulnerability detection
>   arm64: add sysfs vulnerability show for speculative store bypass
> 
> Marc Zyngier (2):
>   arm64: Advertise mitigation of Spectre-v2, or lack thereof
>   arm64: Use firmware to detect CPUs that are not affected by Spectre-v2
> 
> Mian Yousaf Kaukab (2):
>   arm64: add sysfs vulnerability show for spectre v1
>   arm64: enable generic CPU vulnerabilites support

The patches look fine to me (I'm giving them some testing now). However,
It would be nice if we got the acks/reviewed-by tags from the people
that looked at the previous series (Andre, Suzuki, Julien). You haven't
included any tags in this series, I guess there were sufficient changes
not to carry them over.

If I get the acks by tomorrow, I'll queue them for 5.1, otherwise they'd
have to wait for the next merging window.

Thanks.

-- 
Catalin
