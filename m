Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FB1216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfGVTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:44:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:42980 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfGVTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:44:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 13C6C2C9;
        Mon, 22 Jul 2019 19:44:58 +0000 (UTC)
Date:   Mon, 22 Jul 2019 13:44:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc:it_IT: align translation to mainline
Message-ID: <20190722134456.6b38077c@lwn.net>
In-Reply-To: <20190718074724.29807-1-federico.vaga@vaga.pv.it>
References: <20190718074724.29807-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 09:47:24 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> The patch translates the following patches in Italian:
> 
> d9d7c0c497b8 docs: Note that :c:func: should no longer be used
> 83e8b971f81c sphinx.rst: Add note about code snippets embedded in the text
> cca5e0b8a430 Documentation: PGP: update for newer HW devices
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied (and the second one as well), thanks.

jon
