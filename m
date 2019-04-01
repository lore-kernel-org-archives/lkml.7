Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59684C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F20A20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDAVEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:04:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:40692 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfDAVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:04:23 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF90C9B7;
        Mon,  1 Apr 2019 21:04:22 +0000 (UTC)
Date:   Mon, 1 Apr 2019 15:04:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: translation for maintainer-pgp-guide
Message-ID: <20190401150421.5524ea2d@lwn.net>
In-Reply-To: <20190330211956.3935-1-federico.vaga@vaga.pv.it>
References: <20190330211956.3935-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 22:19:56 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> It translates the maintainer-pgp-guide in Italian.
> 
> Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

I do wonder, though, given this:

> +:Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>

Should this patch have had a From: line to get the proper name into the
changelog?

Thanks,

jon
