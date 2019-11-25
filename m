Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED5C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BC920679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfKYOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:06:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60792 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:06:10 -0500
Received: from 79.184.255.91.ipv4.supernova.orange.pl (79.184.255.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6c5a3eb053090b24; Mon, 25 Nov 2019 15:06:08 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pm tree with the pci tree
Date:   Mon, 25 Nov 2019 15:06:08 +0100
Message-ID: <9514618.IhCT8fYLWX@kreacher>
In-Reply-To: <20191125101345.760293f3@canb.auug.org.au>
References: <20191125101345.760293f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 25, 2019 12:13:45 AM CET Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   Documentation/power/pci.rst
> 
> between commits:
> 
>   b64cf7a1711d ("PCI/PM: Wrap long lines in documentation")
>   89cdbc354635 ("PCI/PM: Remove unused pci_driver.resume_early() hook")
>   1a1daf097e21 ("PCI/PM: Remove unused pci_driver.suspend_late() hook")
> 
> from the pci tree and commit:
> 
>   1992b66d2f55 ("PM: Wrap documentation to fit in 80 columns")
> 
> from the pm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, the fix looks good to me.

Cheers,
Rafael



