Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AFZuZhXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfHZGoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:44:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfHZGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DSOVCOtncdhSuwUFuuj7nkqf3ww3WZ07yPPFdcJFhCI=; b=AFZuZhXCe4CpdaKK5l+KfMIXs
        SreA8IMJa8zQu7oPRxiXGd6ciRD4dHsjYn9k1dluRUW0m7YHewR1YKG8ee6GTh4m6qnVAlj9Ou358
        E1M+BI/zvh/Izyc54KDulq+OSnOE4qK5OOtjo5UvPfYw1wLKAgkPpDM7n/k64U3FRF5rVZNkp4yTA
        xOnwB5Q9SacWYd5aATRGjU5Nxu67xWYUJxJKD1/eCUixRotDvN+oop/4dISyNNFB/9yxAsermdInM
        J0apa93a4n2/7M+i41uBKLgCBimxx+5Pw8CHQd9HbHWchRHSJDadrnthueVmH/HVA0lhgsmduomku
        OMJF5tCsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i28ju-0001Il-6l; Mon, 26 Aug 2019 06:44:30 +0000
Date:   Sun, 25 Aug 2019 23:44:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
Message-ID: <20190826064430.GD29871@infradead.org>
References: <20190819051345.81097-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819051345.81097-1-anup.patel@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer, Paul - are you going to pick this up?  Seems like we've just
missed -rc6.
