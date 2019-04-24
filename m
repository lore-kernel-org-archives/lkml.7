Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427E820685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="myL0OpWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfDXHYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:24:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDXHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ym3EBbr5VFX4UJVh85HSsuUzQr4O6LFzKi0IWrtgWrQ=; b=myL0OpWmfWLJ6jofcPF0tdKNX
        Ad5ukPTqyrpJT8PINSyKjPelwRuiWhSXfDrMvnsJ4GlZGcoBtRngkKoSGl8quv9ZWVgwhRnrRjqxb
        eAbSjDwrM8FNLsL0pwNVwGGq8YTLYBkuKWgCn3U91lrAZ6x1Z7usM9JRPaQms9Hgg350e6gTvfkcR
        D3FHAs1dIIpZH43WK5/fyxeNXdMzzRmlr4zckV7DxcifuTVppL+Ko45QM7JVEFjuNQSH8o0d5yOtn
        mzhkCCD6tN3gkj99z7hxfuQY6T+c6G5PeOMqVClIdmpqGJDmvsyWcgl3Knt5k/GKa3iHvnHECgJeT
        hJPGlfyuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJCGC-0000fB-QJ; Wed, 24 Apr 2019 07:24:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8CD62203C130C; Wed, 24 Apr 2019 09:24:02 +0200 (CEST)
Message-Id: <20190424071923.275371441@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 24 Apr 2019 09:19:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org
Subject: [PATCH 0/2] objtool uaccess fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here the two patches required to build a clean x86_64-allyesconfig with older GCC (<8).


