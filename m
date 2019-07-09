Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF7C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0162321537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfGIMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:48:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:58182 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIMsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:48:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2FDB1737;
        Tue,  9 Jul 2019 12:48:46 +0000 (UTC)
Date:   Tue, 9 Jul 2019 06:48:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: driver-api: generic-counter: fix file path to
 ABI doc
Message-ID: <20190709064845.6be66cd2@lwn.net>
In-Reply-To: <20190709110613.GA4476@icarus>
References: <20190709075436.7294-1-marcus.folkesson@gmail.com>
        <20190709110613.GA4476@icarus>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 20:06:33 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Fixes: 09e7d4ed8991 ("docs: Add Generic Counter interface documentation")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, would you be able to pick this up in your tree?

I can apply it, yes.  But why are you supplying an SOB for it?

Thanks,

jon
