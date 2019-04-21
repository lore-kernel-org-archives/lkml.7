Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B788C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403392147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 06:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNUlycy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDUGfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 02:35:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDUGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 02:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QbJcszTM+gxA3XJM3jmypEvTCZnJwuovtV/tL3IRfIg=; b=XNUlycy/ft5MN28WzAEn6uMBo
        TESco0alp9lFcHK4jHOxl3Bj57XhgXWwcFmKofdCxu8CocGMrR13fEWmkFOCFOLJIqWPlTAlHgQ/A
        5OvlyRb75xrfcY1YY5j0NP0y3kMD+E9sfC9yt8BbYoWU6KEM+CmHNrBsISy8r9uTUe9Q49Ke1ahMI
        Gs1niu3ZAzwcZDZjAzPcQfWzJla0Rqg83gbeKN83RCazuyy2Ae+EoGKXVWgz5iBFFaHQzkoJZtdWQ
        RJ6zU7HCUoWPudVwsDW8bTY6/xPq12OMsY9bjZmyRW3pt2U0/1nRkFnCq+DmxjW4tXeBI7ItCwTO7
        RqUzzOcEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hI64H-0001q3-Kq; Sun, 21 Apr 2019 06:35:13 +0000
Date:   Sat, 20 Apr 2019 23:35:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fdomain: Resurrect driver
Message-ID: <20190421063513.GA2288@infradead.org>
References: <20190420201126.827-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420201126.827-1-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned before:  please drop the unused ISA and PCIMCIA code.
We don't need to (re-)add untested code.
