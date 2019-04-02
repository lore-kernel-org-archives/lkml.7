Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB121C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1A120657
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfDBPoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:44:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:46018 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDBPoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:44:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7B8D82D7;
        Tue,  2 Apr 2019 15:43:59 +0000 (UTC)
Date:   Tue, 2 Apr 2019 09:43:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-docs: Move vfs.txt under "Docs at
 the Linux Kernel tree"
Message-ID: <20190402094358.38c15809@lwn.net>
In-Reply-To: <20190331221439.22892-1-j.neuschaefer@gmx.net>
References: <20190331221439.22892-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 00:14:37 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> It's unnecessary to point to an external mirror of the Documentation
> directory. Also, drop the date field, because in-kernel documentation is
> continually updated.

So I had to ponder on this one a bit...saying "continually updated" is
pretty amusing for a document that leads off with:

		  Last updated on June 24, 2007.

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Alternatively, we might drop this entry of the list entirely, because
> Documentation/ is already covered.

In the end, I think this alternative option is the better one.  We don't
want to turn kernel-docs.rst into yet another out-of-date index for the
rest of Documentation/, and the removal of the external URL takes away the
only bit of additional information that this entry offers.

Thanks,

jon
