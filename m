Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D517C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD39E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566871246;
	bh=MD3sr2OAksfs0NgAVZIyjzyTAVQ933/C4tnk/zWmHvo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=2YhUxSaJzJDGkHO6A80E7Y7KQrm1UMrxmKMMXeyM1afv8LDZqwx0ozHULlIuv25Vt
	 zgxSsHZ3R5DT9UiwyLYRDNaiN1XFEuUO2vdIi3J1/FUFDn/Tt7a6DOnh1ISHKI516S
	 upT+yjXiiQFGauuiZ3z1FOxNb7TqmOBA9el4K3bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfH0CAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfH0CAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:00:45 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CAC206E0;
        Tue, 27 Aug 2019 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566871244;
        bh=MD3sr2OAksfs0NgAVZIyjzyTAVQ933/C4tnk/zWmHvo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KKAmz9jBCgs55lt1JUWBC6wEihVGwH2eJlWekUmiAHQlHNBSQ9hfI35tKDoisVQk6
         HdBs2Y5wtgaFrBcGW2ON8fxbhdkD/NliHsyJGMXn19bSPectvaDItTx5pd6wjJ55wT
         z4Yn1Rc/2GZC8jtdzkMH5LcPSQD5Mrc/P1BiAwfU=
Date:   Mon, 26 Aug 2019 19:00:44 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: swiotlb-xen cleanups
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908261859490.3428@sstabellini-ThinkPad-T480s>
References: <20190816130013.31154-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Christoph Hellwig wrote:
> Hi Xen maintainers and friends,
> 
> please take a look at this series that cleans up the parts of swiotlb-xen
> that deal with non-coherent caches.

Hi Christoph,

I just wanted to let you know that your series is on my radar, but I
have been swamped the last few days. I hope to get to it by the end of
the week.

Cheers,

Stefano
