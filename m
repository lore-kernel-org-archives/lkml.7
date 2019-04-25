Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F161DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AE82084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wu2DTQ0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfDYUno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:43:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbfDYUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oT5IUq1oB5grq+8ibT89BkE15eXcEKcFPW7d3+C169Q=; b=Wu2DTQ0KG/JEULwJZXBLeUBT8
        tIF7U3Vqo9FVMpEc82wmWmLWfgXr998Wfp0MeuAXsSvY6JmY3lTB1ls9aNdiEHJZp3Mmj5LJmUG+O
        1nNrBLTT0ykjJrNM5SQp/bzMyhn1WeoTZ5zq7yEAIr1Bi9SOG1zMT2hyCGMPlLwGTcDgi0Vhrj49b
        0MZ0unEQaCe24kV1+JXybOoB/PTj14ZmVKo+IXtz4ufOipPHFljjzh1vHfRgOEhgyrGrAkCZVyFgE
        s1LxVSb8skgvjbdFjVBK2UhW3ktTtBJW5Jj482+uYbeyF89dX0ryUyGi3ctg0GO7PpWiW3FyETmXO
        gqSfHRIbA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJlDb-000841-SN; Thu, 25 Apr 2019 20:43:43 +0000
Date:   Thu, 25 Apr 2019 13:43:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 2/2] docs: remove :c:func: annotations from xarray.rst
Message-ID: <20190425204343.GK19031@bombadil.infradead.org>
References: <20190425200125.12302-1-corbet@lwn.net>
 <20190425200125.12302-3-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425200125.12302-3-corbet@lwn.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:01:25PM -0600, Jonathan Corbet wrote:
> Now that the build system automatically marks up function references, we
> don't have to clutter the source files, so take it out.

Well, that reads a lot more nicely and makes it much easier to write!

Acked-by: Matthew Wilcox <willy@infradead.org>

