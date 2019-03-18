Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6352063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCRKAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:00:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbfCRKAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:00:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B67FFAE88;
        Mon, 18 Mar 2019 10:00:09 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Manoj Srivastava <srivasta@debian.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: add workaround for Debian make-kpkg
References: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
X-Yow:  You were s'posed to laugh!
Date:   Mon, 18 Mar 2019 11:00:08 +0100
In-Reply-To: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Fri, 8 Mar 2019 18:13:39 +0900")
Message-ID: <mvm7ecwqz87.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mär 08 2019, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> +$(warning Do not include top Makefile of Linux Kernel)

So how do I add additional targets then?  Currently I create
GNUmakefile, include Makefile, then add the targets I need.  It seems
this is now broken.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
