Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD44C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ch/iHhwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFRMHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:07:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Ch/iHhwArRi8hX6kUYbvEKciG
        lAblvR5q93+SsoQrZb2FiJMskj/41UflFC7Lh4m/TiaUeRAE8/9xR6TfmQBb2J/B8jU1ouDXFA5ER
        ekj72PEGNL0TMfy7XvGR9HKmQUvR1BrhKf6gtIJTsnBdIb5gLhtGclkf1pb0eVhrDj3Y02oVWNfYm
        GKPgb7ksqQH/MNeJn5ozfnrezGXnOB9bcDh/RXL0of0ZXXH7/jUq6HAFttA1hfvQpS9dpzhs6IPJE
        ngFF8N9TAlGvnI1I1rU2Vv5+TNnSf2XlCLn5d+mwKid2pI6blYHTUcCFTmXFGuFK/B2ZloyCGPG5J
        YUnQw0QLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdCtW-0002aZ-Lo; Tue, 18 Jun 2019 12:07:22 +0000
Date:   Tue, 18 Jun 2019 05:07:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2] fs: cramfs_fs.h: Fix shifting signed 32-bit value by
 31 bits problem
Message-ID: <20190618120722.GA9911@infradead.org>
References: <20190618114947.10563-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618114947.10563-1-puranjay12@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
