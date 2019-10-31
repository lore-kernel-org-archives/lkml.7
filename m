Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE4CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7762086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572504668;
	bh=LdYyJIE33KHH3S1hU6rd+nzuIDkZi6BrCFonQIsQO00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nupc83q7KIHzZ0dnnv3B8oXc8lZlrgjckRJifqU6f/Epw49irULTWJeWummU3DbRC
	 Z7qI2wXEwX0f4lvGHDRwMv4QaGSFZJsup6MWEgNDz9JCejJVCxOquoHnjGwHRuQ3uh
	 /fhOUudqy24Vp52/Zi1z9cevEmsfcY3LFbrlRorY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJaGvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJaGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:51:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA0C2083E;
        Thu, 31 Oct 2019 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572504666;
        bh=LdYyJIE33KHH3S1hU6rd+nzuIDkZi6BrCFonQIsQO00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6uzzdfy9Su0waD7iZ0/i8/UhnM9eBviFTBjStgyIiDkIphvSc3BRKVvXNf/5QfwL
         Re+iDFbGbbFwhsv3sscoE75qTElPNTwIvO65xz7cGRKsPrAUa63x1xFkGD7hTOpVdB
         OK7R6BI03tg6oLBPx+wJqnbKgPLV0PM4Ts6ImQyA=
Date:   Thu, 31 Oct 2019 07:51:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191031065103.GE727325@kroah.com>
References: <20191029213423.28949-1-keescook@chromium.org>
 <20191029213423.28949-2-keescook@chromium.org>
 <20191030091849.GA637042@kroah.com>
 <20191030180921.GB19366@lst.de>
 <20191030192640.GC709410@kroah.com>
 <20191030194532.GA21020@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030194532.GA21020@lst.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:45:32PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 08:26:40PM +0100, Greg Kroah-Hartman wrote:
> > Looks good!  You can apply patch 2/2 as well if you want to take that
> > through your tree too.
> 
> I can do that, I'll just need a formal ACK from you.

Now sent, thanks.
