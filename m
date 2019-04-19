Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E123C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E6B217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfDSWLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:11:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:41090 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:11:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 73091537;
        Fri, 19 Apr 2019 22:10:59 +0000 (UTC)
Date:   Fri, 19 Apr 2019 16:10:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, xdp-newbies@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, dm-devel@redhat.com, target-devel@vger.kernel.org,
        netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fpga@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Avoiding merge conflicts while adding new docs - Was: Re:
 [PATCH 00/57] Convert files to ReST
Message-ID: <20190419161058.3628a29b@lwn.net>
In-Reply-To: <20190418091526.00e074d1@coco.lan>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <20190418091526.00e074d1@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 09:42:23 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> After thinking a little bit and doing some tests, I think a good solution
> would be to add ":orphan:" markup to the new .rst files that were not
> added yet into the main body (e. g. something like the enclosed example).

Interesting...I didn't know about that.  Yes, I think it makes sense to
put that in...

jon
