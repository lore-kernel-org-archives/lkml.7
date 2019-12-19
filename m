Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B7FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:38:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:37174 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:38:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B01EC2E5;
        Thu, 19 Dec 2019 16:38:00 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:37:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: boot.rst: fix typo
Message-ID: <20191219093759.18eb1171@lwn.net>
In-Reply-To: <20191203113314.26810-1-info@metux.net>
References: <20191203113314.26810-1-info@metux.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 12:33:14 +0100
"Enrico Weigelt, metux IT consult" <info@metux.net> wrote:

> There's a little typo in the text - it supposed to be "Header Fields",
> instead of "Harder Fileds".
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Applied, thanks.

jon
