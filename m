Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8233B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfDQJ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:26:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:34348 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfDQJ0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:26:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 9BF9B20581;
        Wed, 17 Apr 2019 11:26:33 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 8B00920080;
        Wed, 17 Apr 2019 11:26:33 +0200 (CEST)
Subject: Re: [PATCH v2] nvmem: core: add NVMEM_SYSFS Kconfig
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <92f2d6fc-3710-1ae9-a392-1e812246b5f0@free.fr>
Date:   Wed, 17 Apr 2019 11:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416095924.17428-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Apr 17 11:26:33 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 11:59, Srinivas Kandagatla wrote:

> Many nvmem providers are not very keen on having default sysfs
> nvmem entry, as most of the usecases for them are inside kernel
> itself. And in some cases read/writes to some areas in nvmem are
> restricted and trapped at secure monitor level, so accessing them
> from userspace would result in board reboots.
> 
> This patch adds new NVMEM_SYSFS Kconfig to make binary sysfs entry
> an optional one. This provision will give more flexibility to users.
> This patch also moves existing sysfs code to a new file so that its
> not compiled in when its not really required.

"it's" ;-)

Regards.
