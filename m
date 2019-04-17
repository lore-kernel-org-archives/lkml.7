Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E61206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbfDQTHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:07:49 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:57238 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:07:49 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 5DA742009BA;
        Wed, 17 Apr 2019 19:07:47 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 97F5420B14; Wed, 17 Apr 2019 20:25:04 +0200 (CEST)
Date:   Wed, 17 Apr 2019 20:25:04 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pcmcia: This patch fix the following checkpatch
 warning.
Message-ID: <20190417182504.GA3010@light.dominikbrodowski.net>
References: <1555436744-15494-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555436744-15494-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:45:44PM +0300, Mohan Kumar wrote:
> Switch hardcoded function name with a reference to __func__ making the
> code more maintainable

Thanks for your patch. Are there any other patches pending to this driver?

As noted in Kconfig, the TCIC host briges "are only found on a handful of
old systems". Therefore, I am a bit reluctant to apply this patch,
especially as the much more in this file does not adhere to current kernel
CodingStyle practices.

Thanks,
	Dominik
