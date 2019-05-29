Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B16C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DEB208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FhPehD3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfE2GVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:21:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2GVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YAyDy9iRa/2fBxfKwwoNkpWrW0fkg9D/tjr6FTgsOyI=; b=FhPehD3axIksKRnIAkO8z5PZ0
        /IWo79p9ISk6KUJrb4Tzo0L7JcrN0r0NWLmJfZDWK/tGH1l3Ah8vxbrM1IQrF7lZMaH4E3wdMLSbR
        C7306ng7j+7pX41Ak9IWU97kQ/ib98gb139ktjf4dQK+92ag/7Bv77A6qBznURzzHlbB8AFVvAiK3
        /yCQaOXSok5cfCB6/XEVN3ShvbaXlCvm3jKMkRf76ZjXOCxmbFuemwrVWGkB6MfdVtKUBRVKfVVp4
        bOyZ0umCIni6OicPHULdvvjiSXTgNw9UeuMveGQsAfSjdPUtR9zjSvr6+VcE9u+fnmBufZafcC478
        Fm2NcITbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVrxl-00011q-W3; Wed, 29 May 2019 06:21:25 +0000
Date:   Tue, 28 May 2019 23:21:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, alex.williamson@redhat.com
Subject: Re: [PATCH v5 3/7] iommu/vt-d: Introduce is_downstream_to_pci_bridge
 helper
Message-ID: <20190529062125.GC26055@infradead.org>
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528115025.17194-4-eric.auger@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* is_downstream_to_pci_bridge - test if a device belongs to the
> + * PCI sub-hierarchy of a candidate PCI-PCI bridge
> + *
> + * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
> + * @bridge: the candidate PCI-PCI bridge
> + *
> + * Return: true if @dev belongs to @bridge PCI sub-hierarchy
> + */

This is not valid kerneldoc comment.  Try something like this:

/**
 * is_downstream_to_pci_bridge - test if a device belongs to the PCI
 *				 sub-hierarchy of a candidate PCI-PCI bridge
 * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
 * @bridge: the candidate PCI-PCI bridge
 *
 * Returns true if @dev belongs to @bridge PCI sub-hierarchy, else false.
 */
