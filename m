Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A061C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6923B218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpSbQZcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfCVNZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:25:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfCVNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qoN4/hANxT2V0vdjDQ0bOs9SHwMnxI7CvbuVsdL4zL8=; b=SpSbQZcQJwYtjir+3pUCEpa9T
        tFnunf+3DJp+nLL/zJTKYzeJoGcnaP9PEafmaKTLplCyJb+3O09JPDaHLhkadO/QCbuc1YpO7g6G7
        qY+wL/cXGMmarwjz2JK/mHnjDXoiQkf6raMXQbK/cCoKQhIFTbck7BPestZknayHoYmtPhD3FvCKL
        PSYTnNVurCImjBCV+rEiWUI1YCz8Nv+L8xvY+CnV0rfFZK12FfZ2FtXnzcHiXk3DgcgBktaQbJDLS
        zkTABCu8WJWnA2AFlM5/aLWo5VNVYA829OrAsE10xaHXaU34XjQr3xBeonIrGnixepixNDT//vPIu
        nV8TLdQ6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7KAX-0006dR-Tn; Fri, 22 Mar 2019 13:25:09 +0000
Date:   Fri, 22 Mar 2019 06:25:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
Message-ID: <20190322132509.GA19263@infradead.org>
References: <20190322100414.32221-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322100414.32221-1-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, what is the 32-bit test vehicle of choice?  qemu with the
virt machine?
