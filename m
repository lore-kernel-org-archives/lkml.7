Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B0BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F6220C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHFNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:33:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:33:24 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1huzaa-0007Nz-7T; Tue, 06 Aug 2019 15:33:20 +0200
Message-ID: <1565098399.2359.0.camel@pengutronix.de>
Subject: Re: [RESEND V2 1/2] dt-bindings: Document the DesignWare IP reset
 bindings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Date:   Tue, 06 Aug 2019 15:33:19 +0200
In-Reply-To: <1563895048-30038-2-git-send-email-luis.oliveira@synopsys.com>
References: <1563895048-30038-1-git-send-email-luis.oliveira@synopsys.com>
         <1563895048-30038-2-git-send-email-luis.oliveira@synopsys.com>
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

Hi Luis,

On Tue, 2019-07-23 at 17:17 +0200, Luis Oliveira wrote:
> This adds documentation of device tree bindings for the
> DesignWare IP reset controller.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you, both applied to reset/next.

regards
Philipp
