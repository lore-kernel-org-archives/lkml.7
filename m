Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F469C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA85120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCDTr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:47:26 -0500
Received: from ms.lwn.net ([45.79.88.28]:34392 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfCDTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:47:25 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 54D732B4;
        Mon,  4 Mar 2019 19:47:25 +0000 (UTC)
Date:   Mon, 4 Mar 2019 12:47:24 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zenghui Yu <zenghuiyu96@gmail.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/process/howto: Update for 4.x -> 5.x
 versioning
Message-ID: <20190304124724.5c8f21b6@lwn.net>
In-Reply-To: <1551205342-5630-1-git-send-email-zenghuiyu96@gmail.com>
References: <1551205342-5630-1-git-send-email-zenghuiyu96@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 02:22:22 +0800
Zenghui Yu <zenghuiyu96@gmail.com> wrote:

> As linux-5.0 is coming up soon, the howto.rst document can be
> updated for the new kernel version. Instead of changing all 4.x
> references to 5.x, this time we git rid of all explicit version
> numbers and rework some kernel trees' name to keep the docs
> current and real.
> 
> Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>

I've applied this, thanks.

jon
