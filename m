Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51904C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A120854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCRRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:35:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:50954 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfCRRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:35:36 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A60EC2B4;
        Mon, 18 Mar 2019 17:35:35 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:35:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
Message-ID: <20190318113534.43fb94f3@lwn.net>
In-Reply-To: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 21:45:16 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Add the translation disclaimer in English as reference
> for other languages.  Translations must include this disclaimer
> in their language so that readers are properly informed.
> 
> This very same patch updates the Italian translation accordingly.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Honestly, it all feels a little too legalistic to me; have people been
worried about the translations in this regard?

Oh well, I went ahead and applied it.  I do think that it might make sense
to move the TOC *above* the disclaimer, though, since that's what readers
are really going to be interested in.

Thanks,

jon
