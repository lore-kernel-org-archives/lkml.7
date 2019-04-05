Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CA82146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmQOHSXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfDEQ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:27:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfDEQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sbTsBVoYFo/VMKMOMjNFqOroXRAV9hVyhQ4X5TCbmnY=; b=dmQOHSXl2iB3S8pMk0CkmurYG
        JeUXaVmE+ygmO/goFmVM/SVLsIYIAnPZDj9MN6qTKzyROU8tzV4jTZRPffnQn1/eKRfqQHhqG37ck
        goumNlVLYObLnv7ZcHyN0JzeUX46faomJvam0eBgySfY7jRglzM/h8v9uSftj0bPZvD8b2hI2Ogmy
        3GCVGvpYkvR4LLugARwi/gVcB5+nhS9DUohZsNyYeGz7GsOIsZhpjIoYKmKffzBNEvTG2RC2d7STo
        8d61N7iOkcVVf2NrwlSxxWk/1Clm/p4CduAPPTY1u7VkiRl7JMVh2boYP5iGy/dul0ZDw6+JEFk3x
        O6ymPQkxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCRgL-00069K-R9; Fri, 05 Apr 2019 16:27:09 +0000
Date:   Fri, 5 Apr 2019 09:27:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: redefine zero as a unsigned long
Message-ID: <20190405162709.GQ22763@bombadil.infradead.org>
References: <20190405065217.125140-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405065217.125140-1-houtao1@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:52:17PM +0800, Hou Tao wrote:
> We have got KASAN splat when tried to set /proc/sys/fs/file-max:

Matteo Croce already has a patch in-flight for this.
