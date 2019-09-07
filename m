Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9AC43140
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8A2218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406742AbfIGPuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:50:39 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:35198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392067AbfIGPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:50:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CD557180A884B;
        Sat,  7 Sep 2019 15:50:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake73_3f7a51a030944
X-Filterd-Recvd-Size: 1669
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 15:50:36 +0000 (UTC)
Message-ID: <b387b7ea498eb96d94f47b22ac4b11c75518513a.camel@perches.com>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
From:   Joe Perches <joe@perches.com>
To:     Sasha Levin <sashal@kernel.org>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@linux.ie>,
        Yu Zhao <yuzhao@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        stable <stable@vger.kernel.org>
Date:   Sat, 07 Sep 2019 08:50:34 -0700
In-Reply-To: <20190904120823.GW5281@sasha-vm>
References: <20190903162519.7136-1-sashal@kernel.org>
         <20190903162519.7136-44-sashal@kernel.org>
         <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
         <20190903170347.GA24357@kroah.com> <20190903200139.GJ5281@sasha-vm>
         <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
         <829c5912-cf80-81d0-7400-d01d286861fc@daenzer.net>
         <20190904120823.GW5281@sasha-vm>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 08:08 -0400, Sasha Levin wrote:
> it's better to get
> it right rather than to be done quickly :)

That also applies to the initial selection of
patches for the stable trees.


