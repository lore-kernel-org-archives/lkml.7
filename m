Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6682B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmldmbDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfJHPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:39:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=QmldmbDs5B8413t4l8UOWLdRv
        8afKzVgYAMSqTAt4/DD2AEFXErozw3FX2IkOsPZqyqCxVCizXW4L8izM3+qlDNNYROdzVaTkS7hzW
        1YoODgGSt0PStcUOgMti7z4sHkuncxLPZukO/uega6TWzwij0zrzBlLnSESJlE7GXad/tfm6AaXB/
        ytgNUKs4NEaWOcJe0cTO9+iNJwmKvVfoS813Z0gd3TQWaNZCq0ybh30gtL6BmcX2iCtFxwcR89uH4
        4qI3dJLWbvbeBmZPi+DQOYi+lqI55Py0d/NYZRO06B5gIFUUkLsQCinND3zG6SigTQa86X8FMHqCC
        AOk0XV4qA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrag-0005VI-Su; Tue, 08 Oct 2019 15:39:58 +0000
Date:   Tue, 8 Oct 2019 08:39:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Ghiti <aghiti@upmem.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [v1 PATCH  1/2] RISC-V: Remove unsupported isa string info print
Message-ID: <20191008153958.GB20318@infradead.org>
References: <20191004012000.2661-1-atish.patra@wdc.com>
 <20191004012000.2661-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004012000.2661-2-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
