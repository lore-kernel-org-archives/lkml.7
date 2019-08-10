Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA92C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C02084C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfHJLIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:08:06 -0400
Received: from verein.lst.de ([213.95.11.211]:33875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfHJLIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:08:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D25368BFE; Sat, 10 Aug 2019 13:08:02 +0200 (CEST)
Date:   Sat, 10 Aug 2019 13:08:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] nouveau: simplify nouveau_dmem_migrate_to_ram
Message-ID: <20190810110801.GA26349@lst.de>
References: <20190808153346.9061-1-hch@lst.de> <20190808153346.9061-7-hch@lst.de> <08112ecb-0984-9e32-a463-e731bc014747@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08112ecb-0984-9e32-a463-e731bc014747@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've added the fixups for v3.
