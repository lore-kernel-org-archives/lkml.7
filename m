Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E595C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008E320679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfHMKXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:23:11 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52392 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfHMKXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BA4B5FB03;
        Tue, 13 Aug 2019 12:23:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0wcZcnLC9pE5; Tue, 13 Aug 2019 12:23:07 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 88682416CC; Tue, 13 Aug 2019 12:23:07 +0200 (CEST)
Date:   Tue, 13 Aug 2019 12:23:07 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] Improvements and fixes for mxsfb DRM driver
Message-ID: <20190813102307.GA22623@bogon.m.sigxcpu.org>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Wed, Jun 26, 2019 at 04:32:08PM +0300, Robert Chiras wrote:
> This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
> and 8QXP). Following, are the new features added and fixes from this
> patch-set:

There was some feedback on various patches, do you intend to pick that
up again? That would be cool since there's some overlapping work popping
up already e.g. in

    https://patchwork.freedesktop.org/series/64595/

showing up and it's the base for the tiny

    https://patchwork.freedesktop.org/series/64300/    

Cheers,
 -- Guido
