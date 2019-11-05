Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2272080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfKEE75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:59:57 -0500
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:57286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387399AbfKEE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:59:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 412FF1801A991;
        Tue,  5 Nov 2019 04:59:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tiger32_90babfc2ae605
X-Filterd-Recvd-Size: 1412
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 04:59:54 +0000 (UTC)
Message-ID: <4df246124153bcece639fdd026c4eee629b4bb7a.camel@perches.com>
Subject: Re: [PATCH 0/3] drm/tegra: Remove space after parenthesis
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 20:59:43 -0800
In-Reply-To: <20191105045337.GB1764@qmqm.qmqm.pl>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
         <20191105045337.GB1764@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 05:53 +0100, Michał Mirosław wrote:
> On Mon, Nov 04, 2019 at 06:23:19PM -0800, Jamal Shareef wrote:
> > This patchset removes spaces after left open parenthesis.
> > Issue found by checkpatch.
> 
> I'd say that those spaces make code easier to look at, so it would
> be better to teach checkpatch to ignore cases like these.

Good luck with that.


