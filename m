Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBA921841
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCSM7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:59:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfCSM7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:59:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BB1168F;
        Tue, 19 Mar 2019 05:59:37 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7B73F59C;
        Tue, 19 Mar 2019 05:59:36 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:59:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     William Cohen <wcohen@redhat.com>
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/stacktrace: Export save_stack_trace_regs()
Message-ID: <20190319125933.GE59586@arrakis.emea.arm.com>
References: <20190301200041.31305-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301200041.31305-1-wcohen@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:00:41PM -0500, William Cohen wrote:
> The ARM64 implements the save_stack_trace_regs function, but it is
> unusable for any diagnostic tooling compiled as a kernel module due
> the missing EXPORT_SYMBOL_GPL for the function.  Export
> save_stack_trace_regs() to align with other architectures such as
> s390, openrisc, and powerpc. This is similar to the ARM64 export of
> save_stack_trace_tsk() added in git commit e27c7fa015d6.
> 
> Signed-off-by: William Cohen <wcohen@redhat.com>

Queued for 5.1-rc2. Thanks.

-- 
Catalin
