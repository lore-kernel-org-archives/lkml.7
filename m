Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B126C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FA7214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKLQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:17:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:17:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 12E1B280084
Message-ID: <b84f3c8c3913de6d897ad91576afe0df913c7d98.camel@collabora.com>
Subject: Re: [PATCH 0/5] Add V4L2 driver for i.MX8 JPEG Encoder/Decoder
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mirela Rabulea <mirela.rabulea@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, paul.kocialkowski@bootlin.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, leonard.crestez@nxp.com,
        robert.chiras@nxp.com, laurentiu.palcu@nxp.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se,
        dafna.hirschfeld@collabora.com
Date:   Tue, 12 Nov 2019 13:17:20 -0300
In-Reply-To: <1573053633-21437-1-git-send-email-mirela.rabulea@nxp.com>
References: <1573053633-21437-1-git-send-email-mirela.rabulea@nxp.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mirela,

Thanks for the patch.

On Wed, 2019-11-06 at 17:20 +0200, Mirela Rabulea wrote:
> This patch set adds the V4L2 driver for i.MX8QXP/QM JPEG encoder/decoder
> and it's dependencies.
> The driver was tested on i.MX8QXP, using a unit test application and

What's the relatioship between this hardware and the JPEG hardware support that
is available on i.MX 8M?

Thanks,
Ezequiel

