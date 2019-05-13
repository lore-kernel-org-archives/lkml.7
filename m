Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14514C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E116C21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfEMLGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:06:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfEMLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:06:32 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hQ8ms-0001aM-9u; Mon, 13 May 2019 13:06:30 +0200
Message-ID: <1557745589.4442.5.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Add reset controller support for BM1880 SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com
Date:   Mon, 13 May 2019 13:06:29 +0200
In-Reply-To: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
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

Hi,

On Sat, 2019-05-11 at 00:15 +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds reset controller support for Bitmain BM1880 SoC.
> BM1880 SoC has only one reset controller and the reset-simple driver
> has been reused here.
> 
> This patchset has been tested on 96Boards Sophon Edge board.
> 
> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Removed the clk-rst part as it turned out be the clock gating register set.

Thank you, I'd like to pick up patches 1, 3, and 4.

Since patch 2 depends on patch 1, you could either temporarily replace
the constants with their numerical value, until patch 1 is merged, or I
could provide a stable branch that contains patch 1 after v5.2-rc1.

regards
Philipp
