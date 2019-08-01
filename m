Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B60C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1849A2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M+3MT2Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfHAP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:56:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfHAP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SE/8eGqfJXFHoRyVUxUskQ3HNtF1lZGN92qDzAmZU6k=; b=M+3MT2KhOqKNG0wszgkJTCK1C
        FfiJ8Cov1zPjr5c4QOiivkOGHa3OB7l6npDxomp7gdTa/Qbhf70qm91Fqye9YOu/TxluvzBouD6VW
        ujzPyT6idKjP6lkZMi7lvZ0+Hr3812qqDeBFpM+Hoy/sYsiwrNAQj2LqHuUf93sIEp3ivWC4y3eE3
        2n+8xEc/08CPbq9Qpz166poJR8zczhTOHb6kDEZhy7Ie0JDwL3DhEgtsclrCXvn1MWvsKEMfArVcF
        eXix41526drtK5FmM5akA3y41YuiW2ew3mGPl8vY+3JM030k6irxQcfsUtojeFwSsT1nCsiAdv8UB
        U0Ae1ys4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htDRR-00008w-Kf; Thu, 01 Aug 2019 15:56:33 +0000
Date:   Thu, 1 Aug 2019 08:56:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v3 4/5] RISC-V: Export few kernel symbols
Message-ID: <20190801155633.GA366@infradead.org>
References: <20190801005843.10343-1-atish.patra@wdc.com>
 <20190801005843.10343-5-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801005843.10343-5-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:58:42PM -0700, Atish Patra wrote:
> Export few symbols used by kvm module. Without this, kvm can not
> be compiled as a module.

Please add this to the kvm series instead as we don't merge exports
without their users in the same series.
