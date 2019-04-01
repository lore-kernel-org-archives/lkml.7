Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AC7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A432133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDAU6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:58:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:40640 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfDAU6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:58:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 529D97DE;
        Mon,  1 Apr 2019 20:58:00 +0000 (UTC)
Date:   Mon, 1 Apr 2019 14:57:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it: alignement clarification about sign-off and
 Co-developed-by
Message-ID: <20190401145759.7fdb067f@lwn.net>
In-Reply-To: <20190327222835.27497-1-federico.vaga@vaga.pv.it>
References: <20190327222835.27497-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 23:28:35 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Align Italian documentation after the following patch to the main documents
> 
> commit 24a2bb90741b docs: Clarify the usage and sign-off requirements for Co-developed-by
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon
