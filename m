Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD761C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A28B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfHGI1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:27:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbfHGI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:54 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hvHHX-00030K-Cg; Wed, 07 Aug 2019 10:26:51 +0200
Message-ID: <1565166410.5048.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/5] dt-bindings: arm: Extend SCMI to support new
 reset protocol
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Date:   Wed, 07 Aug 2019 10:26:50 +0200
In-Reply-To: <20190806170208.6787-4-sudeep.holla@arm.com>
References: <20190806170208.6787-1-sudeep.holla@arm.com>
         <20190806170208.6787-4-sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 18:02 +0100, Sudeep Holla wrote:
> SCMIv2.0 adds a new Reset Management Protocol to manage various reset
> states a given device or domain can enter. Extend the existing SCMI
> bindings to add reset protocol support by re-using the reset bindings
> for bothe reset providers and consumers.
          ^
typo

> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
