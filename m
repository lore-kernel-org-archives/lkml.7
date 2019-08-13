Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D05C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25D120665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfHMWH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:07:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:45646 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfHMWH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:07:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2C218738;
        Tue, 13 Aug 2019 22:07:27 +0000 (UTC)
Date:   Tue, 13 Aug 2019 16:07:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Subject: Re: Best practice for embedded code samles? [Was: drm/drv: Use //
 for comments in example code]
Message-ID: <20190813160726.3f9eb8c8@lwn.net>
In-Reply-To: <20190811213215.GA26468@ravnborg.org>
References: <20190808163629.14280-1-j.neuschaefer@gmx.net>
        <20190811213215.GA26468@ravnborg.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2019 23:32:15 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> I wonder if there is a better way to embed a code sample
> than reverting to // style comments.
> 
> As the kernel do not like // comments we should try to avoid them in
> examples.

If you're embedding a code sample *into a code comment* then I suspect
this is about as good as it gets.  The alternative is to put it in as a
plain literal text block.  That would lose the syntax highlighting; I
think that's an entirely bearable cost, but others seem to feel
differently about it.

Thanks,

jon
