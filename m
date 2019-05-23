Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57B0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A492168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfEWJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:58:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbfEWJ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:58:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9B7341;
        Thu, 23 May 2019 02:58:22 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E293F718;
        Thu, 23 May 2019 02:58:20 -0700 (PDT)
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
 <e70ead93-2fe9-faf9-9e77-9df15809bad6@arm.com>
 <20190516141640.GC43059@lakrids.cambridge.arm.com>
 <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
 <20190523093138.GB26646@fuggles.cambridge.arm.com>
 <20190523095405.GE23850@rapoport-lnx>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f11fdcc0-ab77-378f-b1b8-341bdae36de1@arm.com>
Date:   Thu, 23 May 2019 10:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523095405.GE23850@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2019 10:54, Mike Rapoport wrote:
> On Thu, May 23, 2019 at 10:31:38AM +0100, Will Deacon wrote:
>> Hi Steven,
>>
>> On Thu, May 16, 2019 at 03:20:59PM +0100, Steven Price wrote:
>>> I'll spin a real patch and add your Tested-by
>>
>> Did you send this out? I can't spot it in my inbox.
>  
> https://lore.kernel.org/lkml/20190516143125.48948-1-steven.price@arm.com
> 
> And Andrew already took it to the -mm tree.

And it's made its way to Linus' tree:
commit 5d59aa8f9ce972b472201aed86e904bb75879ff0

Steve
