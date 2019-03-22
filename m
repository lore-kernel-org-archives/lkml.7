Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB25A218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCVDOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:14:46 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:36208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727528AbfCVDOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:14:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 665B4181D341A;
        Fri, 22 Mar 2019 03:14:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brush66_4633d45d08111
X-Filterd-Recvd-Size: 1787
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Mar 2019 03:14:42 +0000 (UTC)
Message-ID: <742758434301d3329b336fd9c683dc753fbdc552.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Date:   Thu, 21 Mar 2019 20:14:41 -0700
In-Reply-To: <456595ea-6f20-76d7-2ff3-773724123967@embeddedor.com>
References: <20190103194845.GA26175@embeddedor>
         <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
         <456595ea-6f20-76d7-2ff3-773724123967@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 22:10 -0500, Gustavo A. R. Silva wrote:
> Hi Harry,
> 
> I noticed this patch is already in mainline, but the stable tag
> was removed.  What is the reason for that if this bug is present
> in stable?

It's not a bug, it's just a style issue and
the && use in some compilers it may be slower.

bool when set is 1.


