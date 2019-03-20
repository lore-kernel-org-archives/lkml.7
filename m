Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4106218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCTVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:00:39 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43092 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfCTVAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:00:39 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6iKD-0003hg-JT; Wed, 20 Mar 2019 15:00:38 -0600
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190321075818.24f9703a@canb.auug.org.au>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
Date:   Wed, 20 Mar 2019 15:00:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321075818.24f9703a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-20 2:58 p.m., Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   f4d0dd1064b8 ("NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed")
> 
> Fixes tag
> 
>   Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean:
> 
>   c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")

My fault. I sent the fix patch with the fixes tag before the original
patch was merged upstream expecting them to be squashed. c59666bb32b9 is
the correct hash in upstream now.

Logan

