Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A09C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E324676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfLSQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:36:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:37162 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSQg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:36:57 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C26C52E5;
        Thu, 19 Dec 2019 16:36:56 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:36:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     madhuparnabhowmik04@gmail.com
Cc:     mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: filesystems: automount-support: Change
 reference to document autofs.txt to autofs.rst
Message-ID: <20191219093655.357cfc65@lwn.net>
In-Reply-To: <20191204101939.6939-1-madhuparnabhowmik04@gmail.com>
References: <20191204101939.6939-1-madhuparnabhowmik04@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 15:49:39 +0530
madhuparnabhowmik04@gmail.com wrote:

> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes following documentation build warning:
> Warning: Documentation/filesystems/automount-support.txt references
> a file that doesn't exist: Documentation/filesystems/autofs.txt
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Both patches (finally) applied, thanks.

jon
