Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680821473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfFNUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:38:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:54198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfFNUiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:38:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D29F1740;
        Fri, 14 Jun 2019 20:37:59 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:37:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/documentation-file-ref-check: ignore output dir
Message-ID: <20190614143758.36b0ed65@lwn.net>
In-Reply-To: <093d01459be472a20894c5be6f9b937ff7fd7d47.1560421751.git.mchehab+samsung@kernel.org>
References: <093d01459be472a20894c5be6f9b937ff7fd7d47.1560421751.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 07:29:17 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> When there's no Documentation/output directory, the script will
> complain about those missing references:
> 
> 	Documentation/doc-guide/sphinx.rst: Documentation/output
> 	Documentation/doc-guide/sphinx.rst: Documentation/output
> 	Documentation/process/howto.rst: Documentation/output
> 	Documentation/translations/it_IT/doc-guide/sphinx.rst: Documentation/output
> 	Documentation/translations/it_IT/doc-guide/sphinx.rst: Documentation/output
> 	Documentation/translations/it_IT/process/howto.rst: Documentation/output
> 	Documentation/translations/ja_JP/howto.rst: Documentation/output
> 	Documentation/translations/ko_KR/howto.rst: Documentation/output
> 
> Those are false positives, so add an ignore rule for them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
