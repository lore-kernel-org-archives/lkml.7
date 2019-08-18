Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F1CC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0C2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHRGtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 02:49:03 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:53337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725290AbfHRGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:49:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E48AA1800B863;
        Sun, 18 Aug 2019 06:49:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board99_88e9ef4a09a19
X-Filterd-Recvd-Size: 1000
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Aug 2019 06:49:00 +0000 (UTC)
Message-ID: <c3f3f8394a018bab44081b00563ab3aa4b1aca22.camel@perches.com>
Subject: Re: [PATCH] toshiba: Add correct printk log level while emitting
 error log
From:   Joe Perches <joe@perches.com>
To:     Rishi Gupta <gupt21@gmail.com>, jonathan@buzzard.org.uk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 17 Aug 2019 23:48:59 -0700
In-Reply-To: <1566110368-30133-1-git-send-email-gupt21@gmail.com>
References: <1566110368-30133-1-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-18 at 12:09 +0530, Rishi Gupta wrote:
> TOSH_DEBUG

Perhaps better to remove it altogether and just use pr_debug.



