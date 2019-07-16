Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FAC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E1206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfGPDqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:46:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36260 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGPDqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:46:46 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hnEQO-0003Ya-4P; Mon, 15 Jul 2019 21:46:45 -0600
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jon Mason <jdmason@kudzu.us>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190716130341.03b02792@canb.auug.org.au>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
Date:   Mon, 15 Jul 2019 21:46:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716130341.03b02792@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, yamada.masahiro@socionext.com, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: linux-next: build warning after merge of the ntb tree
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-15 9:03 p.m., Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ntb tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: could not open /home/sfr/next/next/drivers/ntb/ntb.c: No such file or directory
> 
> The only thing I could see that might be relevant is commit
> 
>   56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules")
> 
> and some others in the kbuild tree. Nothing has changed recently in the
> ntb tree ...
> 
> drievrs/ntb builds a module called ntb but there is no ntb.c file.
> 
> Any ideas?

I renamed the ntb.c file to core.c so we could add more files to build
ntb.ko. See [1].

Thanks,

Logan


[1]
https://lore.kernel.org/linux-iommu/20190422210528.15289-6-logang@deltatee.com/
