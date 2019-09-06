Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F960206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394545AbfIFOpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:45:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:36600 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393068AbfIFOpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:45:21 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 43E1E97D;
        Fri,  6 Sep 2019 14:45:21 +0000 (UTC)
Date:   Fri, 6 Sep 2019 08:45:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     lixianfa <lixianfa.official@gmail.com>
Cc:     harryxiyou@gmail.com, alex.shi@linux.alibaba.com, robh@kernel.org,
        mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: arm64: fix grammar dtb placed in no attributes
 region
Message-ID: <20190906084520.59893169@lwn.net>
In-Reply-To: <3fe85082-6788-c693-c18f-4c029a3d093c@gmail.com>
References: <3fe85082-6788-c693-c18f-4c029a3d093c@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 11:07:27 +0800
lixianfa <lixianfa.official@gmail.com> wrote:

> Fix grammar dtb placed in no attributes region.
> This makes Chinese translation smooth to read.
> 
> Signed-off-by: lixinafa <lixinafa.official@gmail.com>

Applied, thanks.

jon
