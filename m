Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C970C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4436B214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kq4hxFjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfEHGT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:19:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEHGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eo2ZZXSbidBOgy5gTnZ+x+tl+8GKVbxIC6FOAvD+ROQ=; b=kq4hxFjZwfmIcwByTjPe9tqZw
        2GBiD5Pad0NCEuDGSb5wmU9gYF/Whtbf9ywy0gWp3iCG5K1d0RF5TmVNXVsnnqp/XEPwedJD8n4vW
        C9I0Zk6OwRVRCRokKJAFxSrE5fUcYmTHxa/tus4JsYyLdFL3ZqtLq/4dU53mOo58PsxPnmENwrfUq
        7qpVjot5F5Ilk7Z+mVE54YIBbSYavWIhNdHq4xaxCTRz0k8PICcNeIBytnFuVW9Kq+wG5+ZkKDlp8
        h3TBHU4oF3p2ZYUfrDr/xNxUYwQja99bMtqfNNI7lw5Sgtq3R/q+edfCVZV+Ki3olmGYOM4346EdU
        2K1xsWsOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOFvj-0002j3-Hq; Wed, 08 May 2019 06:19:51 +0000
Date:   Tue, 7 May 2019 23:19:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] MIPS: SGI-IP27: use generic PCI driver
Message-ID: <20190508061951.GC19227@infradead.org>
References: <20190507210917.4691-1-tbogendoerfer@suse.de>
 <20190507210917.4691-3-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507210917.4691-3-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:09:14PM +0200, Thomas Bogendoerfer wrote:
> Converted bridge code to a platform driver using the PCI generic driver
> framework and use adding platform devices during xtalk scan. This allows
> easier sharing bridge driver for other SGI platforms like IP30 (Octane) and
> IP35 (Origin 3k, Fuel, Tezro).

Ok, here everything makes sense again.  Looks like it is just the
changelogs for the first two patches that might need minor updates.

The whole series looks conceptually fine to me, although I'm not sure
I'm qualified to review it.
