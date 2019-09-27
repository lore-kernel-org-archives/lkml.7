Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC3CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F11A2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K72cvBVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfI0WYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:24:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0WYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GMhX4IEoEZR9fDA9m6gHVRHcmk8xst8oXUoqv2OMAvg=; b=K72cvBVJzl9f+bC8V1PYsT6Mb
        3pKPyNaRzzzDUdowci+OV8ukpD6sul3R/F/rzYeygI87BXkyhogbMGO98D3BERCQ6mD92guPxeZBu
        ir8kfaJIP2LHYv4vy5mrlpQvIKDfv97JVskFSIB9uCyMq6K29FSJZt0q8I2/5WuM4fB30R2LSmISX
        0e+NRCTWq+Gkprf6GczgyCTobPHWgfRrrulJaOIfnZNsZ429GYkKByUfyAosXdqJsk3qwvslEZUZl
        CXAUGQQKS/+un4VSOGEl1K03mzWEb4COwoqsglrM0i504ROgy6EzgU2mPxkmiLGlvnnrdxEXsuxPz
        1r38Lkdqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDyef-0002wN-2O; Fri, 27 Sep 2019 22:24:01 +0000
Date:   Fri, 27 Sep 2019 15:24:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        me@carlosedp.com, linux-kernel@vger.kernel.org, joel@sing.id.au,
        marco@decred.org
Subject: Re: [PATCH] RISC-V: Clear load reservations while restoring hart
 contexts
Message-ID: <20190927222401.GE4700@infradead.org>
References: <20190925001556.12827-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925001556.12827-1-palmer@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:15:56PM -0700, Palmer Dabbelt wrote:
> This is almost entirely a comment.  The bug is unlikely to manifest on
> existing hardware because there is a timeout on load reservations, but
> manifests on QEMU because there is no timeout.

Given how many different lines of RISC-V hardware are around how do
you know it doesn't affect any existing hardware?

Except for that the patch looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
