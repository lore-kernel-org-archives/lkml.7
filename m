Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3FBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB45F22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGZMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:33:57 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:33740 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGZMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:33:57 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 655ED804B3;
        Fri, 26 Jul 2019 14:33:54 +0200 (CEST)
Date:   Fri, 26 Jul 2019 14:33:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     secalert@redhat.com, David Airlie <airlied@linux.ie>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>, smccaman@umn.edu,
        emamd001@umn.edu
Subject: Re: [PATCH v2] drm/panel: check failure cases in the probe func
Message-ID: <20190726123353.GA16964@ravnborg.org>
References: <20190724185933.GE22640@ravnborg.org>
 <20190724195534.9303-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724195534.9303-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=warq429__hhIKtkPYyQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid.

On Wed, Jul 24, 2019 at 02:55:34PM -0500, Navid Emamdoost wrote:
> The following function calls may fail and return NULL, so the null check
> is added.
> of_graph_get_next_endpoint
> of_graph_get_remote_port_parent
> of_graph_get_remote_port
> 
> Update: Thanks to Sam Ravnborg, for suggession on the use of goto to avoid
> leaking endpoint.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Applied and pushed to drm-misc-next.

	Sam
