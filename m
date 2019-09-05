Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554DC3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF45233A1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfIECtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:49:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33532 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730074AbfIECto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:49:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08002193|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0740845-0.00454813-0.921367;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FOyO4sV_1567651782;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FOyO4sV_1567651782)
          by smtp.aliyun-inc.com(10.147.42.253);
          Thu, 05 Sep 2019 10:49:42 +0800
Date:   Thu, 5 Sep 2019 10:49:41 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V6 3/3] riscv: Add support for libdw
Message-ID: <20190905024940.GB3949@vmh-VirtualBox>
References: <cover.1567060834.git.han_mao@c-sky.com>
 <4cba2dfb6b1ef0df01185c6bce78a0a2867d0a7d.1567060834.git.han_mao@c-sky.com>
 <alpine.DEB.2.21.9999.1909041422220.13502@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909041422220.13502@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:24:57PM -0700, Paul Walmsley wrote:
> Hello Mao Han,
> 
> On Thu, 29 Aug 2019, Mao Han wrote:
> 
> > This patch add support for DWARF register mappings and libdw registers
> > initialization, which is used by perf callchain analyzing when
> > --call-graph=dwarf is given.
> 
> > diff --git a/tools/arch/riscv/include/uapi/asm/perf_regs.h b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> > new file mode 100644
> > index 0000000..df1a581
> > --- /dev/null
> > +++ b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> As with 
> 
> https://lore.kernel.org/linux-riscv/CAJF2gTRXH_bx0rwsTZMTnX+umZfVTL_iVnewPtVM50sLaqJPTg@mail.gmail.com/T/#t
> 
> is it possible to change this license string to "GPL-2.0 WITH 
> Linux-syscall-note" to match the other Linux architectures? 
>
Thanks for suggestion. I didn't notice the UAPI headers are supposed to 
have the exception notes. I'll update the license string and resend them.

Thanks,
Mao Han
