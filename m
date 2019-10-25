Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35DECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94BF21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504115AbfJYQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:06:30 -0400
Received: from mail.netline.ch ([148.251.143.178]:57132 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfJYQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:06:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 295582A6046;
        Fri, 25 Oct 2019 18:06:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id O_7KpgKi-kVj; Fri, 25 Oct 2019 18:06:27 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id A1E0B2A6045;
        Fri, 25 Oct 2019 18:06:27 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.92.3)
        (envelope-from <michel@daenzer.net>)
        id 1iO26c-0005b1-Qh; Fri, 25 Oct 2019 18:06:26 +0200
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
To:     Will Deacon <will@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nicolas Waisman <nico@semmle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191025110450.10474-1-will@kernel.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
Date:   Fri, 25 Oct 2019 18:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025110450.10474-1-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 1:04 p.m., Will Deacon wrote:
> In the highly unlikely event that we fail to allocate the "radeon-crtc"
> workqueue, we should bail cleanly rather than blindly march on with a
> NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
> structure.
> 
> This was reported previously by Nicolas, but I don't think his fix was
> correct:

Neither is this one I'm afraid. See my feedback on
https://patchwork.freedesktop.org/patch/331534/ .


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
