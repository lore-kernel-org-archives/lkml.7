Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE118C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F720651
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCSR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:57:21 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58688 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfCSR5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:57:20 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6Iyx-0002P8-U4; Tue, 19 Mar 2019 11:57:00 -0600
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     robh@kernel.org, dalias@libc.org, ysato@users.sourceforge.jp,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        sbates@raithlin.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <mhng-96f28491-e123-459a-b09c-88732de06bbf@palmer-si-x1c4>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c9f13314-204b-10a5-e9eb-2c4d8fca6c90@deltatee.com>
Date:   Tue, 19 Mar 2019 11:56:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <mhng-96f28491-e123-459a-b09c-88732de06bbf@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, linux-riscv@lists.infradead.org, hch@infradead.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, ysato@users.sourceforge.jp, dalias@libc.org, robh@kernel.org, palmer@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

On 2019-01-23 12:56 p.m., Palmer Dabbelt wrote:
>> @Palmer: if you can just look at taking the second patch, I'll resubmit
>> the first one to the appropriate list.
> 
> Works for me.  I'll queue the second patch into my staging branch, targeted for
> the next merge window.

It doesn't look like my sparesmem patch made it into v5.1-rc1. Did it
fall through the cracks?

Thanks,

Logan
