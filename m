Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7839221901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfDXPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:55:09 -0400
Received: from 8bytes.org ([81.169.241.247]:37322 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfDXPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:55:09 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4A77C78F; Wed, 24 Apr 2019 17:55:06 +0200 (CEST)
Date:   Wed, 24 Apr 2019 17:55:06 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190424155505.GA6731@8bytes.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
 <20190424143246.GA24079@infradead.org>
 <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
 <20190424145819.GA16141@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424145819.GA16141@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:58:19AM -0700, Christoph Hellwig wrote:
> I'd be tempted to do that.  But lets just ask Joerg if he has
> any opinion..

The reason was that it is an unlikely path, as hardware implementations
are not allowed to set this bit. It is purely for emulated AMD IOMMUs.
I have not measured whether this annotation has any performance
benefit, but I find it more readable at least.

Regards,

	Joerg

PS: Why did you drop me from the Cc list of the previous replies?
