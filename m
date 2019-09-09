Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422D4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86421920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfIIPjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:39:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51569 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfIIPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:39:20 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i7Ll5-000154-JJ; Mon, 09 Sep 2019 17:39:15 +0200
Message-ID: <1568043555.2956.9.camel@pengutronix.de>
Subject: Re: [PATCH -next] reset: reset-scmi: add missing handle
 initialisation
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 17:39:15 +0200
In-Reply-To: <20190909152107.4968-1-sudeep.holla@arm.com>
References: <20190909152107.4968-1-sudeep.holla@arm.com>
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

Hi Sudeep,

On Mon, 2019-09-09 at 16:21 +0100, Sudeep Holla wrote:
> scmi_reset_data->handle needs to be initialised at probe, so that it
> can be used to access scmi reset protocol apis using the same later.
> 
> Since it was tested with a module that obtained handle elsewhere,
> it was missed easily. Add the missing scmi_reset_data->handle
> initialisation to fix the issue.
> 
> Fixes: c8ae9c2da1cc ("reset: Add support for resets provided by SCMI")
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reported-by: Etienne Carriere <etienne.carriere@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/reset/reset-scmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> Hi Philipp,
> 
> I can either take this via ARM SoC as the driver is getting merged through
> ARM SoC tree, or you can apply this once it gets landed in mainline.
> I am fine with whatever you prefer.

Feel free to take this in via ARM SoC directly, I see no need to wait
for this to hit mainline.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
