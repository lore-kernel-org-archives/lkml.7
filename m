Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136252133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfFZMlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:41:44 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:35397 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:41:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B913F20042;
        Wed, 26 Jun 2019 14:41:40 +0200 (CEST)
Date:   Wed, 26 Jun 2019 14:41:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: Re: [PATCH v2 0/4] drm/panel: jh057n0090: Add regulators and drop
 magic value in init
Message-ID: <20190626124139.GB7337@ravnborg.org>
References: <cover.1561542477.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1561542477.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10
        a=UBMrDm-lNqQcMwi2BuQA:9 a=wPNLvfGTeEIA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Wed, Jun 26, 2019 at 12:37:47PM +0200, Guido Günther wrote:
> Fix the omission of a regulators for the recently added panel and make sure all
> dsi commands start with a command instead of one having a magic constant (which
> already caused confusion).
> 
> Also adds a mail alias to the panel's MAINTAINER entry to reduce the bus
> factor.
> 
> Changes from v1:
> * As per review comments from Sam Ravnborg:
>   - Print error on devm_regulator_get() failres
>   - Fix typos in commit messages
> * Print an error on regulator_enable()
> * Disable vcc if iovcc fails to enable
> 
> Guido Günther (4):
>   MAINTAINERS: Add Purism mail alias as reviewer for their devkit's
>     panel
>   drm/panel: jh057n00900: Don't use magic constant
>   dt-bindings: display/panel: jh057n00900: Document power supply
>     properties
>   drm/panel: jh057n00900: Add regulator support

Patches applied to drm-misc-next and pushed out

	Sam
