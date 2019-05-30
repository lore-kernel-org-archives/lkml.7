Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B273C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635E625D91
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfE3Qhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:37:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3Qhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:37:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0180341;
        Thu, 30 May 2019 09:37:32 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5CFE3F5AF;
        Thu, 30 May 2019 09:37:31 -0700 (PDT)
Subject: Re: [PATCH RESEND 5/7] RISC-V: entry: Remove unneeded need_resched()
 loop
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
References: <mhng-066fe6a6-4d0a-4286-bc01-faaf21ff2698@palmer-si-x1e>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1b251faf-0b5b-2972-1bfd-9d40a8fd3609@arm.com>
Date:   Thu, 30 May 2019 17:37:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-066fe6a6-4d0a-4286-bc01-faaf21ff2698@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2019 05:09, Palmer Dabbelt wrote:
[...]
> 
> Sorry I missed this the first time around.
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Do you want this through the RISC-V tree, or are you going to take it?

Thanks! It's a standalone change so this would be fine through your tree.
