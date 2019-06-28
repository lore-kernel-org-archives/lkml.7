Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F7EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D4A20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfF1WBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:01:40 -0400
Received: from baldur.buserror.net ([165.227.176.147]:42010 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1WBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:01:39 -0400
X-Greylist: delayed 1912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 18:01:39 EDT
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1hgyP6-0001gO-VY; Fri, 28 Jun 2019 16:27:34 -0500
Message-ID: <af6156cafe7d7df31c042e60d2287b9a75b49738.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Nathan Huckleberry <nhuck@google.com>, mturquette@baylibre.com,
        sboyd@kernel.org, yogeshnarayan.gaur@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Fri, 28 Jun 2019 16:27:31 -0500
In-Reply-To: <20190627220642.78575-1-nhuck@google.com>
References: <20190627220642.78575-1-nhuck@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: nhuck@google.com, mturquette@baylibre.com, sboyd@kernel.org, yogeshnarayan.gaur@nxp.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] clk: qoriq: Fix -Wunused-const-variable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 15:06 -0700, Nathan Huckleberry wrote:
> drivers/clk/clk-qoriq.c:138:38: warning: unused variable
> 'p5020_cmux_grp1' [-Wunused-const-variable] static const struct
> clockgen_muxinfo p5020_cmux_grp1
> 
> drivers/clk/clk-qoriq.c:146:38: warning: unused variable
> 'p5020_cmux_grp2' [-Wunused-const-variable] static const struct
> clockgen_muxinfo p5020_cmux_grp2
> 
> In the definition of the p5020 chip, the p2041 chip's info was used
> instead.  The p5020 and p2041 chips have different info. This is most
> likely a typo.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/525
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Acked-by: Scott Wood <oss@buserror.net>

-Scott


