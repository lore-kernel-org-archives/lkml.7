Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC53C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5D42339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfHURXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:23:03 -0400
Received: from foss.arm.com ([217.140.110.172]:33878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHURXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:23:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5040D344;
        Wed, 21 Aug 2019 10:23:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC56F3F718;
        Wed, 21 Aug 2019 10:23:00 -0700 (PDT)
Subject: Re: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to the
 new notification method
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, baicar@os.amperecomputing.com,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
References: <Shiju Jose> <20190812101149.26036-1-shiju.jose@huawei.com>
 <20190812101149.26036-3-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <12b3ccff-0cda-0467-a9ba-0682be6f333e@arm.com>
Date:   Wed, 21 Aug 2019 18:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812101149.26036-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/08/2019 11:11, Shiju Jose wrote:
> This patch adds ghes_handle_memory_failure to the new error
> notification method.

The commit message doesn't answer the question: why?

The existing code works. This just looks like additional churn.
Given a user, I think the vendor specific example is useful. I don't think making this
thing more pluggable is a good idea.


Thanks,

James
