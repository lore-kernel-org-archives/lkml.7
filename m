Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3E3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D4B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfFGRf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:35:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:57852 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfFGRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:35:27 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2391C7DA;
        Fri,  7 Jun 2019 17:35:27 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:35:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: clk: fix struct syntax
Message-ID: <20190607113526.26e8b274@lwn.net>
In-Reply-To: <20190531143016.23185-1-luca@lucaceresoli.net>
References: <20190531143016.23185-1-luca@lucaceresoli.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 16:30:16 +0200
Luca Ceresoli <luca@lucaceresoli.net> wrote:

> The clk_foo_ops struct example has syntax errors. Fix it so it can be
> copy-pasted and used more easily.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Applied, thanks.

jon
