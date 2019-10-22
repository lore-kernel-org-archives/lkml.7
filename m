Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E47CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBC220679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfJVIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:47:57 -0400
Received: from [217.140.110.172] ([217.140.110.172]:46756 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2387938AbfJVIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:47:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2BFB1000;
        Tue, 22 Oct 2019 01:47:27 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BA973F718;
        Tue, 22 Oct 2019 01:47:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 09:47:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu-topology: declare parse_acpi_topology in
 <linux/arch_topology.h>
Message-ID: <20191022084721.GA17984@bogus>
References: <20191022084323.13594-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022084323.13594-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:43:23AM +0100, Ben Dooks (Codethink) wrote:
> The parse_acpi_topology() is not declared anywhere which
> causes the following sparse warning:
>
> drivers/base/arch_topology.c:522:19: warning: symbol 'parse_acpi_topology' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Greg,

Can you pick this up ? Thanks.

--
Regards,
Sudeep
