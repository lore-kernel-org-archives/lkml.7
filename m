Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6089C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C8A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfH2XmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:42:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43546 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfH2XmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:42:12 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i3U39-0003ai-9a; Thu, 29 Aug 2019 17:41:56 -0600
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Zong Li <zong@andestech.com>,
        Michael Clark <michaeljclark@mac.com>,
        Olof Johansson <olof@lixom.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190828214054.3562-1-logang@deltatee.com>
 <alpine.DEB.2.21.9999.1908291542160.12266@viisi.sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <58b828bd-d691-f460-49aa-7e6f15180343@deltatee.com>
Date:   Thu, 29 Aug 2019 17:41:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1908291542160.12266@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, sbates@raithlin.com, greentime.hu@sifive.com, olof@lixom.net, michaeljclark@mac.com, zong@andestech.com, rppt@linux.ibm.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, palmer@sifive.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, paul.walmsley@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-29 5:38 p.m., Paul Walmsley wrote:
>> +#ifdef CONFIG_SPARSEMEM
>> +#define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
>> +#define SECTION_SIZE_BITS	27
> 
> Do you have a specific rationale behind this selection, or is this simply 
> a reasonable starting point?

It's inline with what other platforms are doing. So in some ways it's a
reasonable starting point but I don't see any reason to change it in the
near term.

>> +#endif /* CONFIG_SPARSEMEM */
>> +
>> +#endif /* __ASM_SPARSEMEM_H */
> 
> The following is what I'm getting ready to queue.

Great, thanks!

Logan

