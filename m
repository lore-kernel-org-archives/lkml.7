Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3EFC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021DC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FEIrxw0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfFZHfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:35:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lDmlG4QlTTriJzFXWbGaRSBBFeeq9DSPhk5L2uu/dys=; b=FEIrxw0fA7wZ2Dgvq5SBxdVmN
        yhPyT0gCj6Bxbl/m8JShCPjIBGhfUFMREoijyGu6CGikjCKKCpf0b2qqwRam7jR/hlWuYyDPM14ds
        bqUfT5iAeCLEabNpYahNp1jcOmxfA6iSmh2JpyOpAGQyjm/PM5Ydk9rf9HcVKqWWmuf4OJHVZc+6D
        rl69Hx7yZb+nynPThSA+wG+PtBSuSdLyPqJw9ARsh/w+6FRPip840hneIcWRmm0HUdymEGBFaMQnZ
        LldmT8tVf34HugoPD5imjld6/n5Hh1p8tAsqrTrCSR7iV3Rjlzy3Ea9+xB76jwxTfsxNP6/h0qr0F
        y1s4FQJ5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hg2Sr-0007dW-2T; Wed, 26 Jun 2019 07:35:33 +0000
Date:   Wed, 26 Jun 2019 00:35:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-ID: <20190626073533.GA24199@infradead.org>
References: <cover.1558547956.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558547956.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, Andrew:

I have a series for the hmm tree, which touches the section size
bits, and remove device public memory support.

It might be best if we include this series in the hmm tree as well
to avoid conflicts.  Is it ok to include the rebase version of at least
the cleanup part (which looks like it is not required for the actual
arm64 support) in the hmm tree to avoid conflicts?
