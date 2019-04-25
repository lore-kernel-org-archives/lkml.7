Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9443F218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7hYzG/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfDYImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:42:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3/1qXqSuPyTQ7Pi+XantWQIwgvgZ3JBoaERQaX7/NNQ=; b=c7hYzG/qoNwYfbD4q+ZkRDnZM
        fgsaO9G09m0iQKdxu7mk4NGnQ4T9JlTTMNvcqMUsF6Glx/QLW8FBOL1hXr9PfIrtnpWFqTfNKllTc
        Dfsojq4S5Ebnzhn3niK9BTo7Tu27rhnxm79AYmaTZy2GBk8v1rRgbg+yfiyIjrIvBiZh2tFFIgRPT
        WzR5HjeWE21JRKorMRC30+k7lNcF4Rr7mr40wjvbSOaGHLEI3CuS+4Lu82zsJQewoV0m0/NRim+Mz
        mF9scSzqZGbKhP1P0oleo7VRzgbbLuosrdFYiVFkj5G67mLfOLHLVb01DjhfCs3MHCi+GIoU8ht6s
        Www6MFrJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZxe-0001du-NU; Thu, 25 Apr 2019 08:42:30 +0000
Date:   Thu, 25 Apr 2019 01:42:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Message-ID: <20190425084230.GA3612@infradead.org>
References: <20190425083804.11991-1-anup.patel@wdc.com>
 <20190425083804.11991-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425083804.11991-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:38:37AM +0000, Anup Patel wrote:
> This patch adds SCAUSE interrupt flag and SCAUSE interrupt related
> defines to asm/csr.h. We also use these defines in kernel/irq.c and
> express SIE/SIP flags in-terms of SCAUSE interrupt causes.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
