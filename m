Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01671C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D32070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfHLVWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:22:36 -0400
Received: from ms.lwn.net ([45.79.88.28]:37172 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfHLVWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:22:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47AE8737;
        Mon, 12 Aug 2019 21:22:35 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:22:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation/arm/sa1100: Remove some obsolete
 documentation
Message-ID: <20190812152234.267a609d@lwn.net>
In-Reply-To: <20190808165929.16946-1-j.neuschaefer@gmx.net>
References: <20190808165929.16946-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 18:58:55 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> The support for the following boards, among others, was removed in 2004
> with commit "[ARM] Remove broken SA1100 machine support.":
> 
> - ADS Bitsy
> - Brutus
> - Freebird
> - ADS GraphicsClient Plus
> - ADS GraphicsMaster
> - Höft & Wessel Webpanel
> - Compaq Itsy
> - nanoEngine
> - Pangolin
> - PLEB
> - Yopy
> 
> Tifon support has been removed in 2.4.3.3.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Well, you know, we don't like to be too hasty about such things...:)

Applied, thanks for helping to clean out some of the cobwebs!

jon
