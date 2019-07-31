Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C903C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59053206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGaGPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:15:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfGaGPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:15:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21BD5AD1E;
        Wed, 31 Jul 2019 06:15:07 +0000 (UTC)
Subject: Re: [PATCH] [v3] xen: avoid link error on ARM
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20190722074705.2082153-1-arnd@arndb.de>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <4c9fa545-1940-5bb8-ddbb-1024a8a23655@suse.com>
Date:   Wed, 31 Jul 2019 08:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722074705.2082153-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.19 09:46, Arnd Bergmann wrote:
> Building the privcmd code as a loadable module on ARM, we get
> a link error due to the private cache management functions:
> 
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> 
> Move the code into a new that is always built in when Xen is enabled,
> as suggested by Juergen Gross and Boris Ostrovsky.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pushed to xen/tip.git for-linus-5.3a


Juergen
