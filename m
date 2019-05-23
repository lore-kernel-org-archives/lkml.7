Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8435C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191320675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfEWJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:31:44 -0400
Received: from foss.arm.com ([217.140.101.70]:41412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfEWJbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:31:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 587CD341;
        Thu, 23 May 2019 02:31:42 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B223F718;
        Thu, 23 May 2019 02:31:40 -0700 (PDT)
Date:   Thu, 23 May 2019 10:31:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190523093138.GB26646@fuggles.cambridge.arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
 <e70ead93-2fe9-faf9-9e77-9df15809bad6@arm.com>
 <20190516141640.GC43059@lakrids.cambridge.arm.com>
 <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, May 16, 2019 at 03:20:59PM +0100, Steven Price wrote:
> I'll spin a real patch and add your Tested-by

Did you send this out? I can't spot it in my inbox.

Cheers,

Will
