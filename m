Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ABAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9304217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6lKXu+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:14:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5L8OrZdXK+BUwU5dnNtd+rSouGyvbkZnf41TYzqgRRk=; b=H6lKXu+cn9RYWL7ax1k0QQa95
        pt1+bchp7wB6pbxzdSON30mNH+RPZofbjCEPa7UPRZ5TRnUx2C68OOJkYR42JqSn7LoZEaf9y+cAR
        OIc2RHLKyUxKQKhiJaltxtvWFQwCiCKJEhvlsGLOYtQHZbeAKf5r0XOKvK1ZChNJDM//MnQjAyS6x
        b0zL6U3/+dqJEEj/nvPyJ9fpH7FhU+9PO1wLXhm8HaWJXd37xeiuqpFk4JvrKD4tSv7+VKVLtF95R
        nXeunbkXXBxfvZWyeVlJZi3MYjnlCYoFJo7+hSFD6HKf0+BRLKkDZ3T/+1U0DbyzP8P1e1lLS9SL6
        T2C93I/qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEaTM-00046M-1Q; Thu, 11 Apr 2019 14:14:36 +0000
Date:   Thu, 11 Apr 2019 07:14:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 0/3] riscv: Add perf callchain support
Message-ID: <20190411141435.GA8343@infradead.org>
References: <cover.1554961908.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554961908.git.han_mao@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please also send all riscv patches to the
linux-riscv@lists.infradead.org list.
