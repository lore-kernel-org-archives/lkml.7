Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92BBC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05E21734
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubkCq9dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfGWPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:35:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbfGWPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h95vwUAZb17z11iq6MTE7WMBYtBu9s65Dlh5cgJgPUg=; b=ubkCq9dpxj9v7lSz8/AQ/smT2
        34fTGpEBrA8UiKObJOtvXQYgFS5Jlj7AtIcS9PpNJEoTnIB3Dtf7I2h3pX3vebsNbMXYL1JJvMCkQ
        ZOsZLsAa4KxBZxW2ZEjDhZQg7/z3wsZNRg7zw7BsLwrCsM+bgrZ59KYceR6Lp1KUYQKJ5Gn3+gHhh
        zDxYmihcYPDfqsxTP14i+3xl1seXb6EQ5KWCTjNCHsP7RLWug79t1WJi3dIaweAS067ifAyj5JHga
        EUz4tu1Iw3U1BR+kuO3iq1Zfm/cga+KwskIWjkBJsv/625ICZMKSnpaHqvMCGHzQbPHPcOO02M8L1
        PdsrO2O/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpwol-0005pZ-I4; Tue, 23 Jul 2019 15:35:07 +0000
Date:   Tue, 23 Jul 2019 08:35:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: scsi_debug module panic
Message-ID: <20190723153507.GA18638@infradead.org>
References: <20190722233906.5kkmqjcoapw4ev62@XZHOUW.usersys.redhat.com>
 <cd82bbd5-a8b4-3aa4-e342-ac888273923f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd82bbd5-a8b4-3aa4-e342-ac888273923f@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 07:37:49PM -0700, Randy Dunlap wrote:
> [add linux-scsi]

Fix:

https://marc.info/?l=linux-scsi&m=156378725427719&w=2
