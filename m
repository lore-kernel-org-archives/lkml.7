Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE98C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250120673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJHOXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:23:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45377 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJHOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:23:22 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iHqOJ-0007ME-4O; Tue, 08 Oct 2019 16:23:07 +0200
Message-ID: <1570544586.18914.9.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/3] reset: meson: add Meson-A1 SoC support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 08 Oct 2019 16:23:06 +0200
In-Reply-To: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
References: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
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

Hi Xingyu,

On Sun, 2019-09-29 at 14:24 +0800, Xingyu Chen wrote:
> This patchset adds support for Meson-A1 SoC Reset Controller. A new struct
> meson_reset_param is introduced to describe the register differences between
> Meson-A1 and previous SoCs.
>
> Changes since v2 at [1]:
> - add comments in header file to indicate holes
> - reorder the Signed-off-by and Reviewed-by
> - remove Jianxin's Signed-off-by
> - add Kevin's Reviewed-by

Thank you, I have applied patches 2 and 3 to reset/next.

regards
Philipp

> Changes since v1 at [0]:
> - rebase on linux-next
> - add Neil's Reviewed-by
> 
> [0] https://lore.kernel.org/linux-amlogic/1568808746-1153-1-git-send-email-xingyu.chen@amlogic.com
> [1] https://lore.kernel.org/linux-amlogic/1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com
> 
> Xingyu Chen (3):
>   arm64: dts: meson: add reset controller for Meson-A1 SoC
>   dt-bindings: reset: add bindings for the Meson-A1 SoC Reset Controller
>   reset: add support for the Meson-A1 SoC Reset Controller
> 
>  .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  6 ++
>  drivers/reset/reset-meson.c                        | 35 ++++++++--
>  include/dt-bindings/reset/amlogic,meson-a1-reset.h | 74 ++++++++++++++++++++++
>  4 files changed, 109 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 
