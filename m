Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B26C742CF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7CC2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGLQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:04:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44341 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGLQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:04:42 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hly2F-0004Jo-Pr; Fri, 12 Jul 2019 18:04:35 +0200
Date:   Fri, 12 Jul 2019 18:04:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 1/3] x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to
 arch/Kconfig
In-Reply-To: <20190712053631.9814-2-bauerman@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1907121804230.1788@nanos.tec.linutronix.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-2-bauerman@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019, Thiago Jung Bauermann wrote:

> powerpc and s390 are going to use this feature as well, so put it in a
> generic location.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
