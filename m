Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F37206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfKHLH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:07:56 -0500
Received: from foss.arm.com ([217.140.110.172]:40706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfKHLH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:07:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68BE31B;
        Fri,  8 Nov 2019 03:07:55 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C173F719;
        Fri,  8 Nov 2019 03:07:54 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:07:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20191108110736.GA10708@e121166-lin.cambridge.arm.com>
References: <CAOesGMjVUCd9bN=pggS-ECjMR42b0SqXKewsp+NYFSVqRgSWrg@mail.gmail.com>
 <20191107211801.GA107543@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107211801.GA107543@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:18:01PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2019 at 10:27:20AM -0800, Olof Johansson wrote:
> > On Wed, Nov 6, 2019 at 2:46 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Today's linux-next merge of the pci tree got a conflict in:
> > >
> > >   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > >
> > > between commit:
> > >
> > >   68e36a429ef5 ("arm64: dts: ls1028a: Move thermal-zone out of SoC")
> > >
> > > from the arm-soc tree and commit:
> > >
> > >   8d49ebe713ab ("arm64: dts: ls1028a: Add PCIe controller DT nodes")
> > 
> > Bjorn, we ask that driver subsystem maintainers don't pick up DT
> > changes since it causes conflicts like these.
> > 
> > Is it easy for you to drop this patch, or are we stuck with it?
> > Ideally it should never have been sent to you in the first place. :(
> 
> Lorenzo, is it feasible for you to drop it from your pci/layerscape
> branch and repush it?  If so, I can redo the merge into my "next"
> branch.

Done. Should we ignore all dts updates from now onwards ?

Thanks,
Lorenzo
