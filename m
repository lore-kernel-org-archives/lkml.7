Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68578C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B45422440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfKTKz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:55:26 -0500
Received: from verein.lst.de ([213.95.11.211]:39487 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfKTKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:55:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F59C68AFE; Wed, 20 Nov 2019 11:55:21 +0100 (CET)
Date:   Wed, 20 Nov 2019 11:55:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Christoph Hellwig <hch@lst.de>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paulburton@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: next/master bisection: boot on peach-pi
Message-ID: <20191120105521.GA3958@lst.de>
References: <5dd42b85.1c69fb81.36825.244a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd42b85.1c69fb81.36825.244a@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Marek Szyprowski already reported the issue and a fix is in the works.
