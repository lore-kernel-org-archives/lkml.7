Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBDCC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBC521E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfHGK2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:28:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfHGK2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:28:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22C428;
        Wed,  7 Aug 2019 03:28:21 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49293F575;
        Wed,  7 Aug 2019 03:28:19 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:28:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        "aidapala@qti.qualcomm.com" <aidapala@qti.qualcomm.com>,
        "pajay@qti.qualcomm.com" <pajay@qti.qualcomm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "wesleys@xilinx.com" <wesleys@xilinx.com>,
        Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Quentin Perret <Quentin.Perret@arm.com>
Subject: Re: [PATCH v2 1/5] firmware: arm_scmi: Add discovery of SCMI v2.0
 performance fastchannels
Message-ID: <20190807102817.GG16546@e107155-lin>
References: <20190806170208.6787-1-sudeep.holla@arm.com>
 <20190806170208.6787-2-sudeep.holla@arm.com>
 <AM0PR04MB4481BA101A13A0E45DA50E9088D40@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481BA101A13A0E45DA50E9088D40@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:23:41AM +0000, Peng Fan wrote:
> > Subject: [PATCH v2 1/5] firmware: arm_scmi: Add discovery of SCMI v2.0
> > performance fastchannels
> >
> > SCMI v2.0 adds support for "FastChannel", a lightweight unidirectional
> > channel that is dedicated to a single SCMI message type for controlling a
> > specific platform resource. They do not use a message header as they are
> > specialized for a single message.
> >
> > Only PERFORMANCE_LIMITS_{SET,GET} and
> > PERFORMANCE_LEVEL_{SET,GET} commands are supported over
> > fastchannels. As they are optional, they need to be discovered by
> > PERFORMANCE_DESCRIBE_FASTCHANNEL command.
> > Further {LIMIT,LEVEL}_SET commands can have optional doorbell support.
> >
> > Add support for discovery of these fastchannels.
> >
> > Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
> > Cc: Chris Redpath <Chris.Redpath@arm.com>
> > Cc: Quentin Perret <Quentin.Perret@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 153
> > ++++++++++++++++++++++++++++++-
> >  1 file changed, 149 insertions(+), 4 deletions(-)
> >

[...]

>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>

Thanks for the review.

--
Regards,
Sudeep
