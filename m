Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5888B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfC1PvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:51:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38232 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfC1PvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:51:16 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9XJA-0004Qj-4B; Thu, 28 Mar 2019 09:51:12 -0600
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20190327213643.23789-1-logang@deltatee.com>
 <20190327213643.23789-3-logang@deltatee.com>
 <20190328114924.GD14864@rapoport-lnx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <863cb31f-cdb6-7d1b-335f-ed11157b8687@deltatee.com>
Date:   Thu, 28 Mar 2019 09:51:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328114924.GD14864@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, linux-riscv@lists.infradead.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, corbet@lwn.net, aou@eecs.berkeley.edu, rppt@linux.ibm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/7] RISC-V: doc: Add file describing the virtual memory
 map
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-28 5:49 a.m., Mike Rapoport wrote:
>> +
>> +The direct mapping covers as much of the physical memory space as
>> +possible so that it may cover some IO memory.
> 
> Please move the text before the tables, so that meaning of Sv32 and Sv39
> would be clear.
> 

Ok, thanks. I've queued up this change for a v2.

Logan
