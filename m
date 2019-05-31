Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3FEC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BE6265FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEaIzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:55:07 -0400
Received: from foss.arm.com ([217.140.101.70]:48068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaIzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:55:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4D0341;
        Fri, 31 May 2019 01:55:06 -0700 (PDT)
Received: from [10.162.42.223] (p8cg001049571a15.blr.arm.com [10.162.42.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C9D3F59C;
        Fri, 31 May 2019 01:55:03 -0700 (PDT)
Subject: Re: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from
 __do_page_fault()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
 <20190530063459.GA2181@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <985b0d8f-2141-019b-8555-272eafc58ea3@arm.com>
Date:   Fri, 31 May 2019 14:25:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530063459.GA2181@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2019 12:04 PM, Christoph Hellwig wrote:
> On Wed, May 29, 2019 at 06:04:45PM +0530, Anshuman Khandual wrote:
>> __do_page_fault() is over complicated with multiple goto statements. This
>> cleans up code flow and while there drops the vm_fault_t argument.
> 
> There is no argument dropped anywhere, just a local variable.
> 

You are right. Will fix both subject line and the commit message.
