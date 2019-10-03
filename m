Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB72B20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfJCQTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:32994 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389497AbfJCQTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:16 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA0AA300;
        Thu,  3 Oct 2019 16:19:15 +0000 (UTC)
Date:   Thu, 3 Oct 2019 10:19:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: maintainer-pgp-guide: Fix reference to
 "Nitrokey Pro 2"
Message-ID: <20191003101915.10659c24@lwn.net>
In-Reply-To: <20191002151841.18476-1-j.neuschaefer@gmx.net>
References: <20191002151841.18476-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 17:18:39 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> This fixes the following Sphinx warning:
> 
> Documentation/translations/it_IT/process/maintainer-pgp-guide.rst:458:
>   WARNING: Unknown target name: "nitrokey pro".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.

jon
