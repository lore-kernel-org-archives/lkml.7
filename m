Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A2C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648B42089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfFUJYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:24:38 -0400
Received: from verein.lst.de ([213.95.11.211]:36914 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfFUJYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:24:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0F90068C4E; Fri, 21 Jun 2019 11:24:07 +0200 (CEST)
Date:   Fri, 21 Jun 2019 11:24:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH 2/4] powerpc/powernv: remove the unused tunneling
 exports
Message-ID: <20190621092406.GA18894@lst.de>
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-3-hch@lst.de> <CAOSf1CFu_T=7weW0eagzjTc8474ntVx1uCKdQh8sX85bfaPxCQ@mail.gmail.com> <048e1242-a6ea-5d56-dc9a-e16f9eedf6d9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048e1242-a6ea-5d56-dc9a-e16f9eedf6d9@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:21:38AM +0200, Frederic Barrat wrote:
> The as-notify can be used in both CAPI mode and PCI mode. In capi mode, 
> it's integrated in the capi protocol, so the cxl driver doesn't need to do 
> extra setup, compared to what's already done to activate capi.
> As mentioned in a previous iteration of that patchset, those APIs are to be 
> used by the Mellanox CX5 driver. The in-tree driver is always a step behind 
> their latest, but word is they are working on upstreaming those 
> interactions.

We can review them together with the driver.  Especially as we need to
consider if we even want to support it if there is no generic platform
independent inferface.
