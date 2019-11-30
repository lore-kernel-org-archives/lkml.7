Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73429C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528ED20833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfK3WPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:15:39 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34372 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3WPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:15:38 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id DE53820027;
        Sat, 30 Nov 2019 23:15:34 +0100 (CET)
Date:   Sat, 30 Nov 2019 23:15:33 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: Add Logic PD Type 28 display panel
Message-ID: <20191130221533.GC29715@ravnborg.org>
References: <20191016135147.7743-1-aford173@gmail.com>
 <20191016135147.7743-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016135147.7743-2-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=eRrw9GIQMXpSLQo85sUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam.
On Wed, Oct 16, 2019 at 08:51:46AM -0500, Adam Ford wrote:
> This patch adds documentation of device tree bindings for the WVGA panel
> Logic PD Type 28 display.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V5:  Replace GPIO_ACTIVE_HIGH with 0 to fix make dt_binding_check -k
> V4:  Update per Rob H's suggestions and copy other panel yaml example from 5.4-rc1
> V3:  Correct build errors from 'make dt_binding_check'
> V2:  Use YAML instead of TXT for binding
> 

Applied to drm-misc-next.
It was applied before the driver changes so we had bindings
for the driver changes when applied.

	Sam
