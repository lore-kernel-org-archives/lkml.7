Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B13C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE522ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGZUaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:30:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:52056 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfGZUaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:30:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 830104BF;
        Fri, 26 Jul 2019 20:30:07 +0000 (UTC)
Date:   Fri, 26 Jul 2019 14:30:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entries for some documentation scripts
Message-ID: <20190726143006.16449a76@lwn.net>
In-Reply-To: <b21677443a602c5dc263537fa48f0e78da75187a.1564152752.git.mchehab+samsung@kernel.org>
References: <b21677443a602c5dc263537fa48f0e78da75187a.1564152752.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 11:52:34 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> There are some documentation scripts I wrote with doesn't
> have any maintainer at maintainer's file.
> 
> Add them to the DOCUMENTATION entry, in order to have
> Jon and linux-doc ML c/c on those patches, plus a new
> entry to ensure that I'll be c/c when people send patches
> to those.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
