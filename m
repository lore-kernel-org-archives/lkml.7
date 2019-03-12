Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCLJnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:43:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfCLJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96D7AA78;
        Tue, 12 Mar 2019 02:43:30 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BF33F59C;
        Tue, 12 Mar 2019 02:43:29 -0700 (PDT)
Subject: Re: [PATCH 12/14] sparc64: rtrap: Remove unneeded need_resched() loop
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <20190311224752.8337-13-valentin.schneider@arm.com>
 <20190311.161313.458909688496508375.davem@davemloft.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1a2c2001-96ae-23c0-c043-e128e24d5560@arm.com>
Date:   Tue, 12 Mar 2019 09:43:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311.161313.458909688496508375.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/03/2019 23:13, David Miller wrote:
[...]
> 
> We must re-evaluate the %tstate value stored in ptregs, you cannot
> make this change.
> 

That's the one I was the less sure about, thanks for clearing it up and
sorry for the noise.
