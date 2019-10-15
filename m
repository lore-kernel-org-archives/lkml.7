Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D67ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693E22086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mjb/k80Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfJOQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:32:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbfJOQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EgxUC7G5lBnZRGpuVrL6vYjqlO6WUnlkRfN5P1gFaxQ=; b=Mjb/k80QVWIMjpYPhp0ebVGi/
        VW/DVH9Oq62BEno6kzzdtzLv5QE3Tt/DIS2eLlE1FwEnoITjbXwlIB7gIj2TeaHskXZQCHpKuehah
        t1NuaXnAf3oa4FRHdj0QdQcrMWSGGwcwd7qtELSCNKm0NmDzq49GbpAlr/Wvrqxdwn43+qLqE4axv
        FLS+DSjOHO2GX5T4Yy5DlV/LL0iWZmx+PQsfw5t92CkSvetaVrCdLqtMJBW9hKPz9HwkDRek/8iLc
        ODu9M06mXiXTb0VZg567BIMQBkyyunVoDuuUe6IicCd8Py3uVb/lLoOMeiiOXwO7CYOx3fpX+Vj4N
        49PsGrnZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKPjx-0000T2-FV; Tue, 15 Oct 2019 16:32:05 +0000
Date:   Tue, 15 Oct 2019 09:32:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Marek Behun <marek.behun@nic.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: moxtet: declare moxtet_bus_type
Message-ID: <20191015163205.GB11160@infradead.org>
References: <20191015122535.5439-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015122535.5439-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:25:35PM +0100, Ben Dooks wrote:
> The moxtet_bus_type object is exported from the bus
> driver, but not declared. Add a declaration for use
> and to silence the following warning:

The symbol can be marked static instead.
