Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD0FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696C120679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfKLOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:41:16 -0500
Received: from verein.lst.de ([213.95.11.211]:56161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLOlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:41:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16B2D68BE1; Tue, 12 Nov 2019 15:41:10 +0100 (CET)
Date:   Tue, 12 Nov 2019 15:41:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, darren@stevens-zone.net,
        "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Message-ID: <20191112144109.GA11805@lst.de>
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de> <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de> <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de> <20191105162856.GA15402@lst.de> <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de> <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de> <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de> <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de> <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
> Now, I can definitely say that this patch does not solve the issue.
>
> Do you have another patch for testing or shall I bisect?

I'm still interested in the .config and dmesg.  Especially if the
board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
place inside the powerpc arch code doing funny things with the
bus_dma_mask, which Robin pointed out looks fishy.

>
> Thanks,
> Christian
---end quoted text---
