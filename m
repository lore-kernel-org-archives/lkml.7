Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E2921872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfJXWlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:41:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45210 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfJXWlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:41:06 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iNlmv-0002nv-UM; Thu, 24 Oct 2019 16:41:02 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com> <20191024011743.GC5190@lst.de>
 <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
 <20191024220119.GA25484@redsun51.ssa.fujisawa.hgst.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d0ab4459-80c1-a722-ff75-269b0e61da19@deltatee.com>
Date:   Thu, 24 Oct 2019 16:40:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024220119.GA25484@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: maxg@mellanox.com, sbates@raithlin.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-24 4:01 p.m., Keith Busch wrote:
> On Thu, Oct 24, 2019 at 11:18:20AM -0600, Logan Gunthorpe wrote:
>> On 2019-10-23 7:17 p.m., Christoph Hellwig wrote:
>>>
>>> First signoff needs to be the From line picked up by git.  I don't really
>>> care if you keep my attribution or not, but if you do it needs From
>>> line for me as the first theing in the mail body, and if not it
>>> should drop by signoff and just say based on a patch from me.
>>>
>>> Otherwise the series looks fine.
>>
>> Ok, understood. Do you want me to fix this up in a v2? Or can you fix it
>> up when you pick up the patches?
> 
> I'll adjust with the commit. Just let me know which way you'd like to go,
> whether attribute author to Christoph or use the "Based-on-a-patch-by:"
> option.

Attribute the author to Christoph. It was all pretty much verbatim from
the draft patch he sent anyway. I just split it up and tested it.

Thanks,

Logan

