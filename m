Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A97208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfGaSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:46:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:55570 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfGaSqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:46:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8F9907DA;
        Wed, 31 Jul 2019 18:46:19 +0000 (UTC)
Date:   Wed, 31 Jul 2019 12:46:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: align translation to mainline
Message-ID: <20190731124618.6f9cdaa0@lwn.net>
In-Reply-To: <20190729215856.11128-1-federico.vaga@vaga.pv.it>
References: <20190729215856.11128-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 23:58:56 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> The patch translates the following patches in Italian:
> 
> 1fb12b35e5ff kbuild: Raise the minimum required binutils version to 2.21
> 9c3c0c204814 isdn: remove isdn4linux
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon
