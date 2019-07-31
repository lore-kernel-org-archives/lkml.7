Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140F3206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfGaTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:10:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:55716 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfGaTK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:10:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 64DCD6D9;
        Wed, 31 Jul 2019 19:10:27 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:10:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     skhan@linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: filesystems: Convert ufs.txt to
 reStructuredText format
Message-ID: <20190731131026.56381580@lwn.net>
In-Reply-To: <1562772683-32422-1-git-send-email-shobhitkukreti@gmail.com>
References: <20190710092605.73ddee8b@coco.lan>
        <1562772683-32422-1-git-send-email-shobhitkukreti@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 08:31:23 -0700
Shobhit Kukreti <shobhitkukreti@gmail.com> wrote:

> This converts the plain text documentation of ufs.txt to
> reStructuredText format. Added to documentation build process
> and verified with make htmldocs
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

I've applied this one as well; apologies for the delay.

jon
