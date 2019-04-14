Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9FEC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB020206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfDNH5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:57:09 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57830 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfDNH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:57:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2BC9C6125498;
        Sun, 14 Apr 2019 09:57:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kP43XDk5vzk5; Sun, 14 Apr 2019 09:57:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D316A6125499;
        Sun, 14 Apr 2019 09:57:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dx7IWehIctkk; Sun, 14 Apr 2019 09:57:06 +0200 (CEST)
Received: from blindfold.localnet (089144199171.atnat0008.highway.a1.net [89.144.199.171])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E8A42611C96F;
        Sun, 14 Apr 2019 09:57:05 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jeff Dike <jdike@addtoit.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 0/4] um: build and irq fixes
Date:   Sun, 14 Apr 2019 09:57:05 +0200
Message-ID: <2216811.6O4GKVgAaJ@blindfold>
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. April 2019, 11:49:40 CEST schrieb Bartosz Golaszewski:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Resending again - this time with tags collected.

Queued for next merge window.

Thanks,
//richard


