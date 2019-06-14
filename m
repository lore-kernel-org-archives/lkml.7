Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB0D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfFNUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:39:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:54214 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfFNUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:39:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 74F04128A;
        Fri, 14 Jun 2019 20:39:47 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:39:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] sphinx.rst: Add note about code snippets embedded in
 the text
Message-ID: <20190614143946.7c6072ac@lwn.net>
In-Reply-To: <20190611200316.30054-1-andrealmeid@collabora.com>
References: <20190611200316.30054-1-andrealmeid@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 17:03:16 -0300
André Almeida <andrealmeid@collabora.com> wrote:

> There's a paragraph that explains how to create fixed width text block,
> but it doesn't explains how to create fixed width text inline, although
> this feature is really used through the documentation. Fix that adding a
> quick note about it.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Applied, thanks.  But I do agree with Jani that we don't want to reproduce
the RST guide here.

jon
