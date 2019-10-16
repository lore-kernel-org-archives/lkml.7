Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC8C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9621835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbfJPH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbfJPH7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:59:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 306C9AEA5;
        Wed, 16 Oct 2019 07:59:39 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     greentime.hu@sifive.com
Cc:     green.hu@gmail.com, paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START
References: <20191016073408.7299-1-greentime.hu@sifive.com>
X-Yow:  Oh, I get it!!  ``The BEACH goes on,'' huh, SONNY??
Date:   Wed, 16 Oct 2019 09:59:38 +0200
In-Reply-To: <20191016073408.7299-1-greentime.hu@sifive.com> (greentime hu's
        message of "Wed, 16 Oct 2019 15:34:08 +0800")
Message-ID: <mvmv9spdst1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 16 2019, greentime.hu@sifive.com wrote:

> From: Greentime Hu <greentime.hu@sifive.com>
>
> This patch fixes the virtual address layout in pgtable.h.
> The virtual address of FIXADDR_START and VMEMMAP_START should not be overlapped.
> These addresses will be existed at the same time in Linux kernel that they can't
> be overlapped.

s/be existed/exist/
s/be overlapped/overlap/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
