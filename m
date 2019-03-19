Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCSImH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:42:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfCSImG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:42:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 277D6AC89;
        Tue, 19 Mar 2019 08:42:05 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Manoj Srivastava <srivasta@debian.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kbuild: add workaround for Debian make-kpkg
References: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
        <mvm7ecwqz87.fsf@suse.de>
        <CAK7LNARKGYm0fO1BR83RdCWtxNj4dWBAVAw-JHXxCrRON986kw@mail.gmail.com>
X-Yow:  You should all JUMP UP AND DOWN for TWO HOURS while I decide
 on a NEW CAREER!!
Date:   Tue, 19 Mar 2019 09:42:04 +0100
In-Reply-To: <CAK7LNARKGYm0fO1BR83RdCWtxNj4dWBAVAw-JHXxCrRON986kw@mail.gmail.com>
        (Masahiro Yamada's message of "Tue, 19 Mar 2019 13:09:43 +0900")
Message-ID: <mvmo967ntlv.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 19 2019, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> How about this patch?
> https://patchwork.kernel.org/patch/10858809/

Thanks, this makes it work again.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
