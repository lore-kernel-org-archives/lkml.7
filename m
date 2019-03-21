Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA804218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553159761;
	bh=wUKuAWU9MFbl1sZC/bY5wvmpAWFvPyw0E4/t4/I8rFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oM8GefLnKUxSbwwGA0f8aoQNZ2ewbZ1e7oSPw49yR6lXOX7aq8N2uSBiGCjQFPlDR
	 B98mpNK8zFQEjbR8NUijwKYecgUI8vla+I2Z10HOplNEVml1PFsJ8EW4l3vsslSmbw
	 BHyCT7uNbAW73bTs0ErSXO43rlOeuJwP+ovDndoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCUJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfCUJP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:15:59 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D19E218A2;
        Thu, 21 Mar 2019 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553159758;
        bh=wUKuAWU9MFbl1sZC/bY5wvmpAWFvPyw0E4/t4/I8rFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1a45h0rYIrvlFhRlOMO1B8kL+w0GDQBAal/l1XXtTggaPYuIkj8vX6e9CC90HBPhl
         hx8rsqSDI3LfiUVI1AijU7HQEPKWZ4qavRodyjPcb9CPYMTr9E+HNam2C1GM0Er39m
         u0N9aipC7xcwhCh2milT+XWCovBAj8cv8cqggoww=
Date:   Thu, 21 Mar 2019 17:15:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Message-ID: <20190321091530.GI12513@dragon>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4481232D83340F894644673C88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB421176101FD9525175463D5F80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB448101B88810300ABAFD8DE488470@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB448101B88810300ABAFD8DE488470@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:31:34AM +0000, Peng Fan wrote:
> 
> 
> > -----Original Message-----
> > From: Aisheng Dong
> > Sent: 2019年3月15日 21:39
> > To: Peng Fan <peng.fan@nxp.com>; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; Anson Huang <anson.huang@nxp.com>;
> > arnd@arndb.de; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Cc: van.freenix@gmail.com
> > Subject: RE: [PATCH 1/2] ARM: imx: drop uneccessary
> > of_platform_default_populate
> > 
> > [...]
> > 
> > > > Originally devices are registered in arch_initcall. Now it will be a
> > > > bit later in arch_initcall_sync and this may cause a bit risk if the
> > > > code under the default_populate want to access the device service
> > > > provided
> > > by early probe.
> > > >
> > > > Probably it's more safe to leave as it is unless you can double
> > > > confirm there're no such code depends on accessing early probed
> > > > devices as follows before we can make the change.
> > >
> > > This has been boot tested on 6Q-SDB/6UL-EVK/6SL-EVK board.
> > > For i.MX, I only see pinctrl driver use arch_initcall from the link,
> > > https://elixir.bootlin.com/linux/latest/ident/arch_initcall
> > >
> > > From my boot test, the pinctrl driver probe will be delayed a bit, but
> > > I do not see issues.
> > >
> > 
> > From what I saw, imx6q_1588_init() and imx6q_axi_init() will use syscon which
> > is registered with postcore_initcall. Without having syscon devices populated,
> > I wonder those calls may fall.
> > Can you double check it?
> 
> I do not see failure in imx6q_1588_init by adding a return value check of
> regmap_update_bits, But the imx6q_pm_init will find ocram device for
> suspend usage, postpone the device population will make imx6q_pm_init
> fail, so drop this patch and leave the code as it is.

Ah, okay.  Thanks for the careful review and the check, Aisheng, Peng.

Shawn
