Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD811C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846B72464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:32:24 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:39374 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgADPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:32:24 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CDA9480478;
        Sat,  4 Jan 2020 16:32:20 +0100 (CET)
Date:   Sat, 4 Jan 2020 16:32:19 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: Add vendor prefix for Xinpeng
 Technology
Message-ID: <20200104153219.GE17768@ravnborg.org>
References: <20191224112907.30758-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224112907.30758-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NXpJzYs8AAAA:8
        a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=SfDLEJJL2Fu8wSabf0EA:9
        a=CjuIK1q_8ugA:10 a=cwV61pgf2j4Cq8VD9hE_:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko.

Thanks for your work on this.

On Tue, Dec 24, 2019 at 12:29:05PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Shenzhen Xinpeng Technology Co., Ltd produces for example display panels.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Rob Herring <robh@kernel.org>

This and the following two patches are now applied to drm-misc-next.

	Sam
