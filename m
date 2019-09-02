Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC39233A2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfIBDHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:07:30 -0400
Received: from ozlabs.org ([203.11.71.1]:39887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfIBDHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:07:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFPW6NYNz9sDQ; Mon,  2 Sep 2019 13:07:27 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0c9c1d56397518eb823d458b00b06bcccd956794
In-Reply-To: <20190806044919.10622-2-bauerman@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 1/6] x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
Message-Id: <46MFPW6NYNz9sDQ@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:07:27 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 04:49:14 UTC, Thiago Jung Bauermann wrote:
> powerpc is also going to use this feature, so put it in a generic location.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Series applied to powerpc topic/mem-encrypt, thanks.

https://git.kernel.org/powerpc/c/0c9c1d56397518eb823d458b00b06bcccd956794

cheers
