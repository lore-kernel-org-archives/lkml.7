Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABADC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A3E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfJNR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:58:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfJNR6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:58:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E4128;
        Mon, 14 Oct 2019 10:58:12 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA0853F6C4;
        Mon, 14 Oct 2019 10:58:10 -0700 (PDT)
Subject: Re: [PATCH] arm64: hibernate: check pgd table allocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191014144824.159061-1-pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, mark.rutland@arm.com, tglx@linutronix.de
From:   James Morse <james.morse@arm.com>
Message-ID: <8ebe7877-93d3-dfd0-8ea3-2a4815b4f154@arm.com>
Date:   Mon, 14 Oct 2019 18:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014144824.159061-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 14/10/2019 15:48, Pavel Tatashin wrote:
> There is a bug in create_safe_exec_page(), when page table is allocated
> it is not checked that table is allocated successfully:
> 
> But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
> allocation was successful.
> 
> Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
