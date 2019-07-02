Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA93C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D321721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGBPSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:18:21 -0400
Received: from 8bytes.org ([81.169.241.247]:33806 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfGBPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:18:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3FABA44C; Tue,  2 Jul 2019 17:18:17 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:18:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190702151817.GD3310@8bytes.org>
References: <20190701190940.7f23ac15@canb.auug.org.au>
 <20190701200418.GA72724@archlinux-epyc>
 <20190702141803.GA13685@ostrya.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702141803.GA13685@ostrya.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:18:03PM +0100, Jean-Philippe Brucker wrote:
> Nathan, thanks for noticing and fixing this.
> 
> Joerg, the virtio-iommu driver build failed in next because of a
> dependency on driver-core changes for v5.3. I'm not sure what the best
> practice is in this case, I guess I will resend the driver as applied
> onto the latest driver-core, to have it working in v5.3?

This depends on what the vhost-tree maintainer prefers. I would probably
merge the current driver-core into the virtio-iommu branch and put a
fix on-top.


Regards,

	Joerg
