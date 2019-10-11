Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3BDC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB60206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfJKQCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:02:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:39270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:02:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA7062E6;
        Fri, 11 Oct 2019 16:02:24 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:02:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Message-ID: <20191011100223.6f3eff7e@lwn.net>
In-Reply-To: <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <201910021000.5E421A6F8F@keescook>
        <201910101535.1804FC6@keescook>
        <20191010163905.70a4d6e1@lwn.net>
        <CH2PR02MB6359973E7718EC50FE36E9C6CB970@CH2PR02MB6359.namprd02.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 08:59:22 +0000
Dragan Cvetic <draganc@xilinx.com> wrote:

> Yes, please add the file.

OK, I've applied the patch, thanks.  I took the liberty of sticking on a
final newline while I was at it.

jon
