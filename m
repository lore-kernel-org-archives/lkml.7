Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164722087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfCAIKp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:10:45 -0500
Received: from foss.arm.com ([217.140.101.70]:59226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbfCAIKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:10:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3418A78;
        Fri,  1 Mar 2019 00:10:44 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5A43F575;
        Fri,  1 Mar 2019 00:10:43 -0800 (PST)
Date:   Fri, 1 Mar 2019 08:10:39 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC
Message-ID: <20190301081039.45d4637e@why.wild-wind.fr.eu.org>
In-Reply-To: <VI1PR04MB32474C533012923BD8A9690E91760@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20171110033125.991-1-qiang.zhao@nxp.com>
        <AM3PR04MB118541F73F953292C937E80891380@AM3PR04MB1185.eurprd04.prod.outlook.com>
        <VI1PR04MB32474C533012923BD8A9690E91760@VI1PR04MB3247.eurprd04.prod.outlook.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 02:13:44 +0000
Qiang Zhao <qiang.zhao@nxp.com> wrote:

> Anybody help to review on this patchset?

I'm afraid reviving reviving a series from 2017 by sending a ping like
this isn't going to have much effect. If you want people to review it,
please send an updated series on top of current mainline, and you'll
be in the review queue for 5.2.

Thanks.

	M.

> 
> Best Regards
> Qiang Zhao
> 
> > -----Original Message-----
> > From: Qiang Zhao
> > Sent: 2017年11月30日 9:11
> > To: Qiang Zhao <qiang.zhao@nxp.com>; tglx@linutronix.de;
> > marc.zyngier@arm.com; jason@lakedaemon.net
> > Cc: linux-kernel@vger.kernel.org
> > Subject: RE: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC
> > 
> > Hi Thomas and Marc,
> > 
> > Is there any feedback? Thank you!
> > 
> > Best Regards
> > Qiang Zhao
> >   
> > > -----Original Message-----
> > > From: Zhao Qiang [mailto:qiang.zhao@nxp.com]
> > > Sent: Friday, November 10, 2017 11:31 AM
> > > To: tglx@linutronix.de; marc.zyngier@arm.com; jason@lakedaemon.net
> > > Cc: linux-kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
> > > Subject: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC
> > >
> > > QEIC is an interrupt controller for QE, was put under
> > > drivers/soc/fsl/qe, and now move to driver/irqchip.
> > > And QEIC is supported more than just powerpc boards, so remove PPCisms.
> > >
> > > changelog:
> > > 	Changes for v8:
> > > 	- use IRQCHIP_DECLARE() instead of subsys_initcall in qeic driver
> > > 	- remove include/soc/fsl/qe/qe_ic.h
> > > 	Changes for v9:
> > > 	- rebase
> > > 	- fix the compile issue when apply the second patch, in fact, there
> > > was no compile issue
> > > 	  when apply all the patches of this patchset
> > > 	Changes for v10:
> > > 	- simplify codes, remove duplicated codes
> > > 	Changes for v11:
> > > 	- rebase
> > > 	Changes for v13:
> > > 	- rewrite single-bit constants to BIT(x) to make the code more
> > > readable
> > >
> > > Zhao Qiang (4):
> > >   irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
> > > 	Changes for v2:
> > > 		- modify the subject and commit msg
> > > 	Changes for v3:
> > > 		- merge .h file to .c, rename it with irq-qeic.c
> > > 	Changes for v4:
> > > 		- modify comments
> > > 	Changes for v5:
> > > 		- disable rename detection
> > > 	Changes for v6:
> > > 		- rebase
> > > 	Changes for v7:
> > > 		- na
> > >
> > >   irqchip/qeic: merge qeic init code from platforms to a common function
> > > 	Changes for v2:
> > > 		- modify subject and commit msg
> > > 		- add check for qeic by type
> > > 	Changes for v3:
> > > 		- na
> > > 	Changes for v4:
> > > 		- na
> > > 	Changes for v5:
> > > 		- na
> > > 	Changes for v6:
> > > 		- rebase
> > > 	Changes for v7:
> > > 		- na
> > > 	Changes for v8:
> > > 		- use IRQCHIP_DECLARE() instead of subsys_initcall
> > >
> > >   irqchip/qeic: merge qeic_of_init into qe_ic_init
> > > 	Changes for v2:
> > > 		- modify subject and commit msg
> > > 		- return 0 and add put node when return in qe_ic_init
> > > 	Changes for v3:
> > > 		- na
> > > 	Changes for v4:
> > > 		- na
> > > 	Changes for v5:
> > > 		- na
> > > 	Changes for v6:
> > > 		- rebase
> > > 	Changes for v7:
> > > 		- na
> > > 	Changes for v12:
> > > 		- remove unused code
> > >
> > >   irqchip/qeic: remove PPCisms for QEIC
> > > 	Changes for v6:
> > > 		- new added
> > > 	Changes for v7:
> > > 		- fix warning
> > > 	Changes for v8:
> > > 		- remove include/soc/fsl/qe/qe_ic.h
> > >
> > > Zhao Qiang (4):
> > >   irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
> > >   irqchip/qeic: merge qeic init code from platforms to a common function
> > >   irqchip/qeic: merge qeic_of_init into qe_ic_init
> > >   irqchip/qeic: remove PPCisms for QEIC
> > >
> > >  MAINTAINERS                                        |   6 +
> > >  arch/powerpc/platforms/83xx/km83xx.c               |   1 -
> > >  arch/powerpc/platforms/83xx/misc.c                 |  16 -
> > >  arch/powerpc/platforms/83xx/mpc832x_mds.c          |   1 -
> > >  arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   1 -
> > >  arch/powerpc/platforms/83xx/mpc836x_mds.c          |   1 -
> > >  arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   1 -
> > >  arch/powerpc/platforms/85xx/corenet_generic.c      |  10 -
> > >  arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  15 -
> > >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  17 -
> > >  arch/powerpc/platforms/85xx/twr_p102x.c            |  15 -
> > >  drivers/irqchip/Makefile                           |   1 +
> > >  drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} | 423 +++++++++++----------
> > >  drivers/soc/fsl/qe/Makefile                        |   2 +-
> > >  drivers/soc/fsl/qe/qe_ic.h                         | 103 -----
> > >  include/soc/fsl/qe/qe_ic.h                         | 139 -------
> > >  16 files changed, 231 insertions(+), 521 deletions(-)  rename
> > > drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} (53%)  delete mode
> > > 100644 drivers/soc/fsl/qe/qe_ic.h  delete mode 100644
> > > include/soc/fsl/qe/qe_ic.h
> > >
> > > --
> > > 2.14.1  
> 



-- 
Without deviation from the norm, progress is not possible.
