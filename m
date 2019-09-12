Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF1C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9498E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568295089;
	bh=kudAbqz+YL7Dz6mmDmzj8DHgNDReWUvuIXRGGzrkJNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mcJ/50vYbLO3acvIMSC4GqCrP3Z3tdm3mnTx+fi25JExt42489Lg1ryb3Fk76vU+f
	 XwoiBaCxiVyeQ9FSNae8gjb9EA64rTAGHB1hjQNRJE9muJhqJEAEFaiZ6fsYU/9SUh
	 SaYjLDVhnvlk22iIgnaUNNxET2GWQbnU0Bej9sSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfILNb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbfILNb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:31:28 -0400
Received: from linux-8ccs (ip5f5adbf4.dynamic.kabel-deutschland.de [95.90.219.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17B1C20856;
        Thu, 12 Sep 2019 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568295088;
        bh=kudAbqz+YL7Dz6mmDmzj8DHgNDReWUvuIXRGGzrkJNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sf02VnNCi1I5jraW3laSM64xxjmjNvfuLUFt0ijQinwVyYSm3fOs2Kqg0rBtt37u
         Qil9AfvD0A7PliE+TTMQZ2n6d4P0BljeEdMFkK4RXz9cuwClgW7x3IUzPkFarbO4jX
         OhXi7BoGCCP/zfm/KAVup7HC3yafp37JR78+SfzY=
Date:   Thu, 12 Sep 2019 15:31:24 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] module: Remove leftover '#undef' from export header
Message-ID: <20190912133123.GA27845@linux-8ccs>
References: <20190911230018.20155-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190911230018.20155-1-will@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Will Deacon [12/09/19 00:00 +0100]:
>Commit 7290d5809571 ("module: use relative references for __ksymtab
>entries") converted the '__put' #define into an assembly macro in
>asm-generic/export.h but forgot to remove the corresponding '#undef'.
>
>Remove the leftover '#undef'.
>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
>
>I spotted this trivial issue when debugging the namespace issue earlier
>today, so here's the patch.

Applied, thanks for the cleanup!

Jessica

