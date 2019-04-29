Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72BD2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfD2Im6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:42:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44697 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbfD2Im6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:42:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.239167|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.325225-0.0257244-0.649051;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.ERai8Dx_1556527374;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.ERai8Dx_1556527374)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 29 Apr 2019 16:42:54 +0800
Date:   Mon, 29 Apr 2019 16:42:05 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Add support for perf registers sampling
Message-ID: <20190429084204.GB22718@vmh-VirtualBox>
References: <69322515ac3fcba8af004039f44473cec5ecbdcc.1554961908.git.han_mao@c-sky.com>
 <mhng-0787435f-0b2c-4ab4-ad73-0b68a815e613@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0787435f-0b2c-4ab4-ad73-0b68a815e613@palmer-si-x1e>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:11:02PM -0700, Palmer Dabbelt wrote:
> On Thu, 11 Apr 2019 00:53:49 PDT (-0700), han_mao@c-sky.com wrote:
> >+	PERF_REG_RISCV_S10,
> >+	PERF_REG_RISCV_S11,
> >+	PERF_REG_RISCV_T3,
> >+	PERF_REG_RISCV_T4,
> >+	PERF_REG_RISCV_T5,
> >+	PERF_REG_RISCV_T6,
> >+	PERF_REG_RISCV_MAX,
> >+};
> 
> Is it expected this eventually supports floating-point and vector registers?
> If so, how do we make this extensible?
>

It seems none of current architecture put their fp/vfp registers into this
file, gpr is normally enough for backtrace and context restoration. I'm not
quite understand the problem of extensible. All modification to this file
should be synchronzied as the perf tool is released with the kernel.

Thanks,
Mao Han
