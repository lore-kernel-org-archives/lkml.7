Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08632183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfB1KDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:03:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbfB1KDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:03:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0EB3EBD;
        Thu, 28 Feb 2019 02:03:17 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E391F3F738;
        Thu, 28 Feb 2019 02:03:16 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:03:11 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20190228100311.GA10207@e107981-ln.cambridge.arm.com>
References: <20190228080147.20df150f@canb.auug.org.au>
 <CAErSpo5-wi128AGyMsyvoyX0ObKon3Q4dU8FJEDTZAtxFHPk=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo5-wi128AGyMsyvoyX0ObKon3Q4dU8FJEDTZAtxFHPk=w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:51:46PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 27, 2019 at 3:01 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Bjorn,
> >
> > Commit
> >
> >   a048671aa0c8 ("PCI: qcom: Don't deassert reset GPIO during probe")
> >
> > is missing a Signed-off-by from its committer.
> 
> Lorenzo, if you add your signed-off-by, I can rebuild this.  I think
> it's on your pci/dwc branch.

Apologies, sorry about this. I have now updated the branch.

Thanks,
Lorenzo
