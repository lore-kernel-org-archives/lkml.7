Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbfDJPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:50:05 -0400
Received: from foss.arm.com ([217.140.101.70]:57094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfDJPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03759374;
        Wed, 10 Apr 2019 08:50:04 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 166D33F59C;
        Wed, 10 Apr 2019 08:50:02 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:50:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix leak in scmi_mailbox_check
Message-ID: <20190410155000.GD3952@e107155-lin>
References: <20190325173722.49414-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325173722.49414-1-steven.price@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:37:22PM +0000, Steven Price wrote:
> of_parse_phandle_with_args() requires the caller to call of_node_put() on
> the returned args->np pointer. Otherwise the reference count will remain
> incremented.
>

Good find and thanks for the fix.

> However, in this case, since we don't actually use the returned pointer,
> we can simply pass in NULL.
>
> Fixes: aa4f886f3893f ("firmware: arm_scmi: add basic driver infrastructure for SCMI")
> Signed-off-by: Steven Price <steven.price@arm.com>

Applied.

--
Regards,
Sudeep
