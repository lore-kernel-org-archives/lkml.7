Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD57C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A082084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfIKPJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:09:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36878 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728421AbfIKPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:09:11 -0400
Received: (qmail 4433 invoked by uid 2102); 11 Sep 2019 11:09:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2019 11:09:10 -0400
Date:   Wed, 11 Sep 2019 11:09:10 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
cc:     linux-kernel@vger.kernel.org,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <Boris.Krasnovskiy@lairdconnect.com>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: host: ohci-at91: tailor power consumption
In-Reply-To: <20190911064154.28633-1-nicolas.ferre@microchip.com>
Message-ID: <Pine.LNX.4.44L0.1909111108460.1483-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019, Nicolas Ferre wrote:

> Following a set of experiments we found areas of improvement for OHCI power
> consumption (and associated USB analog cells).
> This enhances the shutdown of residual power consumption in case of Linux
> suspend/resume and removal of the driver (when compiled as a module).
> 
> Best regards,
>   Nicolas
> 
> Boris Krasnovskiy (2):
>   USB: host: ohci-at91: completely shutdown the controller in
>     at91_stop_hc()
>   USB: host: ohci-at91: resume: balance the clock start call
> 
> Nicolas Ferre (1):
>   USB: host: ohci-at91: suspend: delay needed before to stop clocks
> 
>  drivers/usb/host/ohci-at91.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

For all three patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

