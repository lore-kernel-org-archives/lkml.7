Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FE8214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfIPPiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:38:20 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48490 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfIPPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:38:20 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8FC5A80478;
        Mon, 16 Sep 2019 17:38:16 +0200 (CEST)
Date:   Mon, 16 Sep 2019 17:38:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com
Subject: Re: [PATCH v5 0/8] add driver for boe, tv101wum-nl6, boe,
 tv101wum-n53, auo, kd101n80-45na and auo, b101uan08.3 panels
Message-ID: <20190916153815.GA20997@ravnborg.org>
References: <20190916022941.15404-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916022941.15404-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=t5GJ4r0l-SeTeGRPmjgA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

> Changes since v4:

You are hit by some of the progress made in the kernel.
New dispaly bindings are preferred to be in meta-schma formal (.yaml
files).
This allows more formals checks and this is the format that we
hope all display bindigns will migrate over to use once
someone steps up and do a mass conversion.

This is a bit extra work now, but much better to have it done
by someone who knows the HW.

	Sam
