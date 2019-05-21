Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1266C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12D22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfEUFNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:13:50 -0400
Received: from verein.lst.de ([213.95.11.211]:57331 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfEUFNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:13:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8255E68B05; Tue, 21 May 2019 07:13:26 +0200 (CEST)
Date:   Tue, 21 May 2019 07:13:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [RFC PATCH 02/12] powerpc: Add support for adding an ESM blob
 to the zImage wrapper
Message-ID: <20190521051326.GC29120@lst.de>
References: <20190521044912.1375-1-bauerman@linux.ibm.com> <20190521044912.1375-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521044912.1375-3-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:49:02AM -0300, Thiago Jung Bauermann wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> For secure VMs, the signing tool will create a ticket called the "ESM blob"
> for the Enter Secure Mode ultravisor call with the signatures of the kernel
> and initrd among other things.
> 
> This adds support to the wrapper script for adding that blob via the "-e"
> option to the zImage.pseries.
> 
> It also adds code to the zImage wrapper itself to retrieve and if necessary
> relocate the blob, and pass its address to Linux via the device-tree, to be
> later consumed by prom_init.

Where does the "BLOB" come from?  How is it licensed and how can we
satisfy the GPL with it?
