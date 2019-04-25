Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D718C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B222088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vx//aKF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfDYOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:48:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDYOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uoywynES0xCSyvQ48sPoofcVkgbZGozd0oHgJeP1YZw=; b=Vx//aKF4b3nWKbNYEelwOa5MF
        NNImcKzlPmnGxYDMEFOlRopwOPi6mEGq/z1Cg2toUVIhJkqWQ5/LdCeTwfjeHyHUIkZ1K2RgCmi48
        W5uS1AuihzzUjxNZh0WOkJ4fhPAMJFKs2d8v0sf3QvwYfyywO3VgRfkjp2BMj+nZ3Y4sAYfd73vX1
        r0Wk22anbcPnXeMm1xROjNUw4FXv3CpZ//E5kGLBCOU5pSPq6rxdMo5SpUpzNRnqnTenZYDBQLnuK
        SyqXQiWvIAm3H+7OPw/izqdkTGAy/mgKqz0gvPHGI3S07kfTqY24o+3j9Sam+WKj4QSZa3Kl349hE
        BY+MSRLmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJffa-0004Oa-Ku; Thu, 25 Apr 2019 14:48:14 +0000
Date:   Thu, 25 Apr 2019 07:48:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] drivers: nvme: target: core: fix build break
Message-ID: <20190425144814.GA16882@infradead.org>
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556102081-11820-2-git-send-email-info@metux.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.2.
